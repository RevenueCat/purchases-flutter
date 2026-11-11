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
    final call = _CheckpointCall(onPassed);
    _calls[callId] = call;
    // Native only replies when the checkpoint passes or cannot start. Retain
    // just the call state here, whose app closures are cleared on removal.
    _mainChannel.invokeMethod<Object?>('checkpoint', {
      'identifier': identifier,
      'customVariables': convertCustomVariablesToNative(params.customVariables),
      'presentationMode': params.presentationMode.toString(),
      'callId': callId,
      'useCustomPaywallPresenter': false,
      'hasErrorDialogFactory': false,
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
        {'callId': callId, 'activePaywallRequestId': null},
      );
    };
  }

  Future<void> _handleMethodCall(MethodCall method) async {
    switch (method.method) {
      case 'onPaywallPresentation':
        // Custom paywall presenter support follows in the next PR.
        return;
      case 'onErrorDialogRequested':
        // Error-dialog factory support follows later in the stack.
        return;
      default:
        throw MissingPluginException(
          'Unknown checkpoint callback ${method.method}',
        );
    }
  }

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
  bool detached = false;

  _CheckpointCall(this.onPassed);

  void clear() {
    detached = true;
    onPassed = null;
  }
}
