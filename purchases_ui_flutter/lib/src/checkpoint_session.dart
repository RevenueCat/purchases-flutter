import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:purchases_flutter/errors.dart';
import 'package:purchases_flutter/models/purchases_error.dart';

import '../checkpoint.dart';
import '../checkpoint_error_presenter.dart';

/// Owns one checkpoint's channel and acknowledgement lifecycle.
/// @nodoc
class CheckpointSession {
  final String callId;
  final MethodChannel channel;
  final bool waitsForFinished;
  CheckpointPassed? _onPassed;
  FutureOr<BuildContext> Function()? _errorContext;
  Future<void> Function(CheckpointErrorRequest)? _presentError;
  Future<void> Function()? _closeHost;
  final Set<String> _seenRequests = {};
  final Set<String> _completedRequests = {};
  Future<void> _errors = Future<void>.value();
  CheckpointResult? _result;
  bool _terminal = false;
  bool _cancelled = false;

  CheckpointSession({
    required this.callId,
    required CheckpointPassed onPassed,
    required FutureOr<BuildContext> Function() errorContext,
    required Future<void> Function(CheckpointErrorRequest) presentError,
    required Future<void> Function() closeHost,
    this.waitsForFinished = true,
  })  : channel = MethodChannel(
          'com.revenuecat.purchasesui/Checkpoint/$callId',
        ),
        _onPassed = onPassed,
        _errorContext = errorContext,
        _presentError = presentError,
        _closeHost = closeHost {
    channel.setMethodCallHandler(handleMethodCall);
  }

  bool get isActive => !_terminal;

  Future<void> handleMethodCall(MethodCall call) async {
    if (_terminal) return;
    try {
      if (call.arguments is! Map) {
        throw const FormatException('Missing checkpoint event payload.');
      }
      final args = Map<String, dynamic>.from(call.arguments as Map);
      if (args['callId'] != callId) return;
      switch (call.method) {
        case 'error':
          final requestId = args['requestId'];
          if (requestId is! String ||
              args['kind'] is! String ||
              args['error'] is! Map) {
            throw const FormatException('Invalid checkpoint error payload.');
          }
          if (!_seenRequests.add(requestId)) return;
          final error = _parseError(
            Map<String, dynamic>.from(args['error'] as Map),
          );
          final kind = switch (args['kind']) {
            'flowCouldNotBeShown' => CheckpointErrorKind.flowCouldNotBeShown,
            'flowActionFailed' => CheckpointErrorKind.flowActionFailed,
            'flowResultSyncFailed' => CheckpointErrorKind.flowResultSyncFailed,
            _ => CheckpointErrorKind.unknown,
          };
          // Reply to native immediately. Only completeError acknowledges an error.
          _errors = _errors.then((_) async {
            if (_terminal) return;
            final context = await _errorContext!();
            if (_terminal) return;
            if (!context.mounted) {
              cancel();
              return;
            }
            final request = _CheckpointErrorRequest(
              requestId,
              kind,
              error,
              context,
              () => completeError(requestId),
            );
            try {
              await _presentError!(request);
            } catch (error, stack) {
              _report(error, stack, 'presenting a checkpoint error');
            } finally {
              await completeError(requestId);
            }
          }).catchError((Object error, StackTrace stack) {
            _report(error, stack, 'handling a checkpoint error');
            cancel();
          });
        case 'passed':
          _result ??= CheckpointResult.fromJson(
            Map<String, dynamic>.from(args['result'] as Map),
          );
          if (!waitsForFinished) _finish();
        case 'finished':
          _finish();
      }
    } catch (error, stack) {
      _report(error, stack, 'parsing a checkpoint event');
      cancel();
    }
  }

  Future<void> completeError(String requestId) async {
    if (_terminal || !_completedRequests.add(requestId)) return;
    await channel.invokeMethod<void>('completeError', {'requestId': requestId});
  }

  void detachCallback() => _onPassed = null;

  void cancel() {
    if (_cancelled) return;
    _cancelled = true;
    _onPassed = null;
    if (_terminal) return;
    unawaited(
      channel.invokeMethod<void>('cancel').catchError((Object error) {
        debugPrint('RevenueCatUI: Error cancelling checkpoint: $error');
      }),
    );
    _finish();
  }

  void _finish() {
    if (_terminal) return;
    _terminal = true;
    channel.setMethodCallHandler(null);
    final close = _closeHost;
    _closeHost = null;
    _errorContext = null;
    _presentError = null;
    unawaited(() async {
      try {
        await close?.call();
        final callback = _onPassed;
        final result = _result;
        _onPassed = null;
        _result = null;
        if (!_cancelled && result != null) callback?.call(result);
      } catch (error, stack) {
        _report(error, stack, 'finishing a checkpoint');
      } finally {
        _onPassed = null;
        _result = null;
      }
    }());
  }

  static PurchasesError _parseError(Map<String, dynamic> json) {
    final rawCode = json['code'];
    final number = rawCode is num ? rawCode : num.tryParse('$rawCode');
    final code = number != null && number.isFinite ? number.round() : -1;
    return PurchasesError.fromJson({
      'code': code >= 0 && code < PurchasesErrorCode.values.length ? code : 0,
      'message': json['message'] is String ? json['message'] : '',
      'underlyingErrorMessage': json['underlyingErrorMessage'] is String
          ? json['underlyingErrorMessage']
          : '',
      'readableErrorCode': json['readableErrorCode'] is String
          ? json['readableErrorCode']
          : json['readable_error_code'] is String
              ? json['readable_error_code']
              : '',
    });
  }

  static void _report(Object error, StackTrace stack, String activity) {
    FlutterError.reportError(
      FlutterErrorDetails(
        exception: error,
        stack: stack,
        library: 'purchases_ui_flutter',
        context: ErrorDescription('while $activity'),
      ),
    );
  }
}

final class _CheckpointErrorRequest implements CheckpointErrorRequest {
  @override
  final String requestId;
  @override
  final CheckpointErrorKind kind;
  @override
  final PurchasesError error;
  @override
  final BuildContext context;
  final Future<void> Function() _complete;

  _CheckpointErrorRequest(
    this.requestId,
    this.kind,
    this.error,
    this.context,
    this._complete,
  );

  @override
  Future<void> complete() => _complete();
}
