import 'package:flutter/widgets.dart';
import 'package:purchases_flutter/models/purchases_error.dart';

/// App-owned error UI for an experimental, invite-only checkpoint.
///
/// [context] selects the root navigator at the time the checkpoint is called.
/// Use the request's context, rather than this context, to show error UI:
/// `showDialog(context: request.context, useRootNavigator: false, ...)`.
/// The returned future must complete once that UI has been dismissed. The SDK
/// then acknowledges the error and decides how the flow proceeds.
final class CheckpointErrorPresenter {
  final BuildContext context;
  final Future<void> Function(CheckpointErrorRequest request) present;

  const CheckpointErrorPresenter({
    required this.context,
    required this.present,
  });
}

/// An error the native checkpoint asks the app to handle.
abstract interface class CheckpointErrorRequest {
  String get requestId;
  CheckpointErrorKind get kind;
  PurchasesError get error;

  /// Context inside the SDK-owned Flutter error host.
  ///
  /// Use `useRootNavigator: false` with Flutter dialogs so they are disposed
  /// with this checkpoint. This context is valid only while presenting the error.
  BuildContext get context;

  /// Acknowledges this error once its UI is gone. Repeated calls are harmless.
  ///
  /// Successful or failed completion of the presenter's future also acknowledges
  /// the error. This method does not dismiss app UI or choose a checkpoint result.
  Future<void> complete();
}

/// Why the native SDK requested error presentation.
final class CheckpointErrorKind {
  final String _value;
  const CheckpointErrorKind._(this._value);

  static const flowCouldNotBeShown =
      CheckpointErrorKind._('flowCouldNotBeShown');
  static const flowActionFailed = CheckpointErrorKind._('flowActionFailed');
  static const flowResultSyncFailed =
      CheckpointErrorKind._('flowResultSyncFailed');
  static const unknown = CheckpointErrorKind._('unknown');

  @override
  String toString() => _value;
}
