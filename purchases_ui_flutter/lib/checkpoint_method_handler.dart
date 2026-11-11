import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'checkpoint.dart';
import 'custom_variable_value.dart';

/// Routes checkpoint callbacks independently of customer center callbacks.
/// @nodoc
class CheckpointMethodHandler {
  final MethodChannel _mainChannel;
  static const _channel =
      MethodChannel('com.revenuecat.purchasesui/Checkpoints');
  final _calls = <String, _CheckpointCall>{};
  final _prefix =
      '${DateTime.now().microsecondsSinceEpoch}-${Random().nextInt(1 << 32)}';
  int _nextCallId = 0;
  PaywallPresenter? paywallPresenter;

  CheckpointMethodHandler(this._mainChannel) {
    _channel.setMethodCallHandler(_handleMethodCall);
    _send('initialize', {});
  }

  void Function() checkpoint(
    String identifier,
    CheckpointPassed onPassed,
    CheckpointParams params,
  ) {
    final callId = '$_prefix-${++_nextCallId}';
    final call = _CheckpointCall(
      onPassed,
      params.useNativePaywallPresenter
          ? null
          : params.paywallPresenter ?? paywallPresenter,
      params.errorDialogFactory,
    );
    _calls[callId] = call;
    // Native only replies when the checkpoint passes or cannot start. Retain
    // just the call state here, whose app closures are cleared on removal.
    _mainChannel.invokeMethod<Object?>('checkpoint', {
      'identifier': identifier,
      'customVariables': convertCustomVariablesToNative(params.customVariables),
      'presentationMode': params.presentationMode.toString(),
      'callId': callId,
      'useCustomPaywallPresenter': call.presenter != null,
      'hasErrorDialogFactory': call.factory != null,
    }).then<void>((response) {
      final passed = call.onPassed;
      _calls.remove(callId);
      call.clear();
      if (passed == null) return;
      final CheckpointResult result;
      try {
        result = CheckpointResult.fromJson(
          Map<String, dynamic>.from(response as Map),
        );
      } catch (e) {
        debugPrint('RevenueCatUI: Error parsing the checkpoint result: $e');
        return;
      }
      try {
        passed(result);
      } catch (error, stack) {
        FlutterError.reportError(
          FlutterErrorDetails(
            exception: error,
            stack: stack,
            library: 'purchases_ui_flutter',
            context: ErrorDescription('while calling a checkpoint callback'),
          ),
        );
      }
    }).catchError((Object error) {
      _calls.remove(callId);
      call.clear();
      debugPrint(
        'RevenueCatUI: Error presenting checkpoint $identifier: $error',
      );
    });
    return () {
      if (call.detached) return;
      _calls.remove(callId);
      call.clear();
      _send(
        'detachCheckpoint',
        {'callId': callId, 'activePaywallRequestId': call.activeRequestId},
      );
    };
  }

  Future<void> _handleMethodCall(MethodCall method) async {
    final args = Map<String, dynamic>.from(method.arguments as Map);
    final requestId = args['requestId'] as String;
    final call = _calls[args['callId']];
    switch (method.method) {
      case 'onPaywallPresentation':
        final presenter = call?.presenter;
        if (call == null || presenter == null) {
          _complete(requestId, PaywallPresentationResult.navigatedBack);
          return;
        }
        call.activeRequestId = requestId;
        var completed = false;
        void complete(PaywallPresentationResult result) {
          if (completed) return;
          completed = true;
          call.activeRequestId = null;
          _complete(requestId, result);
          if (result == PaywallPresentationResult.navigatedBack) {
            _calls.remove(args['callId']);
            call.clear();
          }
        }
        // Do not await app-owned UI: the completion callback controls when
        // native purchase synchronization can begin.
        unawaited(
          Future<void>.sync(
            () => presenter(
              PaywallPresentationParams.fromJson(
                Map<String, dynamic>.from(args['params'] as Map),
              ),
              complete,
            ),
          ).catchError((Object error) {
            debugPrint(
              'RevenueCatUI: Checkpoint paywall presenter failed: $error',
            );
            complete(PaywallPresentationResult.navigatedBack);
          }),
        );
        return;
      case 'onErrorDialogRequested':
        final factory = call?.factory;
        var outcome = const CheckpointErrorDialogOutcome.useDefault();
        try {
          if (factory != null) {
            outcome = await factory(
              CheckpointError.fromJson(
                Map<String, dynamic>.from(args['error'] as Map),
              ),
            );
          }
        } catch (error) {
          debugPrint(
            'RevenueCatUI: Using the default checkpoint error dialog: $error',
          );
        }
        if (call == null || !call.detached) {
          _send(
            'resolveErrorDialog',
            {'requestId': requestId, 'outcome': outcome.toJson()},
          );
        }
        return;
      default:
        throw MissingPluginException(
          'Unknown checkpoint callback ${method.method}',
        );
    }
  }

  void _complete(String requestId, PaywallPresentationResult result) => _send(
        'completePaywallPresentation',
        {'requestId': requestId, 'result': result.toString()},
      );

  void _send(String method, Map<String, dynamic> arguments) {
    unawaited(
      _channel.invokeMethod<void>(method, arguments).catchError((Object error) {
        debugPrint('RevenueCatUI: Checkpoint $method failed: $error');
      }),
    );
  }
}

class _CheckpointCall {
  CheckpointPassed? onPassed;
  PaywallPresenter? presenter;
  CheckpointErrorDialogFactory? factory;
  String? activeRequestId;
  bool detached = false;

  _CheckpointCall(this.onPassed, this.presenter, this.factory);

  void clear() {
    detached = true;
    onPassed = null;
    presenter = null;
    factory = null;
  }
}
