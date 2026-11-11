#if os(iOS)
import Flutter
import PurchasesHybridCommonUI

/// Owns checkpoint callbacks independently of the customer center method handler.
final class CheckpointHandler {
    private let channel: FlutterMethodChannel
    private var disposed = false
    private var generation = 0

    init(messenger: FlutterBinaryMessenger) {
        self.channel = FlutterMethodChannel(name: "com.revenuecat.purchasesui/Checkpoints", binaryMessenger: messenger)
        self.channel.setMethodCallHandler { [weak self] call, result in
            guard let self = self, !self.disposed else {
                result(FlutterMethodNotImplemented)
                return
            }
            DispatchQueue.main.async {
                self.handle(call, result: result)
            }
        }
    }

    @MainActor
    private func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard !self.disposed else {
            result(FlutterMethodNotImplemented)
            return
        }
        let args = call.arguments as? [String: Any] ?? [:]
        switch call.method {
        case "initialize":
            self.generation += 1
            CheckpointProxy.invalidateCheckpointPresentations()
        case "completePaywallPresentation":
            guard let requestId = args["requestId"] as? String, let outcome = args["result"] as? String else {
                result(FlutterError(code: "BAD_ARGS", message: "Missing checkpoint presentation result", details: nil))
                return
            }
            CheckpointProxy.completePaywallPresentation(requestId: requestId, result: outcome)
        case "resolveErrorDialog":
            guard let requestId = args["requestId"] as? String else {
                result(FlutterError(code: "BAD_ARGS", message: "Missing checkpoint error requestId", details: nil))
                return
            }
            CheckpointProxy.resolveErrorDialog(requestId: requestId, outcome: args["outcome"] as? [String: Any])
        case "detachCheckpoint":
            guard let callId = args["callId"] as? String else {
                result(FlutterError(code: "BAD_ARGS", message: "Missing checkpoint callId", details: nil))
                return
            }
            CheckpointProxy.detachCheckpoint(callId: callId, activePaywallRequestId: args["activePaywallRequestId"] as? String)
        default:
            result(FlutterMethodNotImplemented)
            return
        }
        result(nil)
    }

    func present(_ args: [String: Any], result: @escaping FlutterResult) {
        DispatchQueue.main.async {
            self.presentOnMain(args, result: result)
        }
    }

    @MainActor
    private func presentOnMain(_ args: [String: Any], result: @escaping FlutterResult) {
        guard !self.disposed else {
            result(FlutterMethodNotImplemented)
            return
        }
        guard let identifier = args["identifier"] as? String, let callId = args["callId"] as? String else {
            result(FlutterError(code: "BAD_ARGS", message: "Missing identifier or callId in checkpoint", details: nil))
            return
        }
        let currentGeneration = self.generation
        let presentPaywall: ((String, [String: Any]) -> Void)? = args["useCustomPaywallPresenter"] as? Bool == true
            ? { [weak self] requestId, params in
                let fallback = { CheckpointProxy.completePaywallPresentation(requestId: requestId, result: "NAVIGATED_BACK") }
                guard let self = self else { fallback(); return }
                self.send(
                    method: "onPaywallPresentation",
                    arguments: [
                        "callId": callId,
                        "requestId": requestId,
                        "params": params
                    ],
                    callGeneration: currentGeneration,
                    fallback: fallback
                )
            } : nil
        let errorDialog: ((String, [String: Any]) -> Void)? = args["hasErrorDialogFactory"] as? Bool == true
            ? { [weak self] requestId, error in
                let fallback = { CheckpointProxy.resolveErrorDialog(requestId: requestId, outcome: ["type": "useDefault"]) }
                guard let self = self else { fallback(); return }
                self.send(
                    method: "onErrorDialogRequested",
                    arguments: [
                        "callId": callId,
                        "requestId": requestId,
                        "error": error
                    ],
                    callGeneration: currentGeneration,
                    fallback: fallback
                )
            } : nil
        CheckpointProxy.present(
            identifier: identifier,
            callId: callId,
            customVariables: args["customVariables"] as? [String: Any],
            presentationMode: args["presentationMode"] as? String,
            onPassed: { [weak self] value in
                guard let self = self, !self.disposed, self.generation == currentGeneration else { return }
                result(value)
            },
            onError: { [weak self] code, message in
                guard let self = self, !self.disposed, self.generation == currentGeneration else { return }
                result(FlutterError(code: code, message: message, details: nil))
            },
            onPaywallPresentationRequested: presentPaywall,
            onErrorDialogRequested: errorDialog
        )
    }

    @MainActor
    private func send(
        method: String,
        arguments: [String: Any],
        callGeneration: Int,
        fallback: @escaping () -> Void
    ) {
        guard !self.disposed, self.generation == callGeneration else { fallback(); return }
        self.channel.invokeMethod(method, arguments: arguments) { result in
            if result is FlutterError || (result as? NSObject) === FlutterMethodNotImplemented {
                fallback()
            }
        }
    }

    func dispose() {
        self.disposed = true
        self.channel.setMethodCallHandler(nil)
        DispatchQueue.main.async {
            CheckpointProxy.invalidateCheckpointPresentations()
        }
    }
}
#endif
