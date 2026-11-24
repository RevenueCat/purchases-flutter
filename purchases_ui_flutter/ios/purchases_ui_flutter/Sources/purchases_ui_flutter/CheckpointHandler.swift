#if os(iOS)
import Flutter
import PurchasesHybridCommonUI
import Foundation

final class CheckpointHandler {
    func present(
        _ result: @escaping FlutterResult,
        identifier: String,
        customVariables: [String: Any]?,
        presentationMode: String?
    ) {
#if os(iOS)
        // Replies at most once, and only when the checkpoint passes: backing out never invokes the callback.
        CheckpointProxy.present(
            identifier: identifier,
            callId: UUID().uuidString,
            customVariables: customVariables,
            presentationMode: presentationMode,
            onPassed: { result($0) },
            onError: { code, message in
                result(FlutterError(code: code, message: message, details: nil))
            },
            onPaywallPresentationRequested: nil,
            onErrorDialogRequested: nil
        )
#else
        result(FlutterError(code: "UNSUPPORTED_PLATFORM",
                            message: "Checkpoints require iOS",
                            details: nil))
#endif
    }
}
#endif
