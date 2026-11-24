import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'checkpoint.dart';
import 'custom_variable_value.dart';

/// Handles checkpoint platform calls and callbacks.
/// @nodoc
class CheckpointMethodHandler {
  final MethodChannel _mainChannel;

  CheckpointMethodHandler(this._mainChannel);

  void Function() checkpoint(
    String identifier,
    CheckpointPassed onPassed,
    CheckpointParams params,
  ) {
    // Native never replies when the user backs out, so the future below can stay
    // pending for the lifetime of the engine. Dropping the callback on removal
    // keeps that closure from retaining `onPassed` and whatever it captures.
    CheckpointPassed? callback = onPassed;
    _mainChannel.invokeMethod<Object?>('checkpoint', {
      'identifier': identifier,
      'customVariables': convertCustomVariablesToNative(
        params.customVariables,
      ),
      'presentationMode': params.presentationMode.toString(),
    }).then<void>((response) {
      final passed = callback;
      if (passed == null) return;
      callback = null;
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
    }).catchError((Object e) {
      debugPrint('RevenueCatUI: Error presenting checkpoint $identifier: $e');
    });
    return () => callback = null;
  }
}
