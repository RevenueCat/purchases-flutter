#if os(iOS)
import Flutter
import PurchasesHybridCommonUI

/// Owns checkpoint callbacks independently of the customer center method handler.
final class CheckpointHandler {
    private let channel: FlutterMethodChannel
    private var disposed = false
    private var generation = 0

    private var activeCalls = Set<String>()
    private var paywallCallsByRequest: [String: String] = [:]

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
            self.detachOwnedCalls()
        case "completePaywallPresentation":
            guard let requestId = args["requestId"] as? String, let outcome = args["result"] as? String else {
                result(FlutterError(code: "BAD_ARGS", message: "Missing checkpoint presentation result", details: nil))
                return
            }
            self.completePaywall(requestId: requestId, outcome: outcome)
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
            if self.activeCalls.remove(callId) != nil {
                let activeRequest = args["activePaywallRequestId"] as? String
                self.paywallCallsByRequest = self.paywallCallsByRequest.filter { requestId, owner in
                    owner != callId || requestId == activeRequest
                }
                CheckpointProxy.detachCheckpoint(callId: callId, activePaywallRequestId: activeRequest)
            }
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
        self.activeCalls.insert(callId)
        let currentGeneration = self.generation
        let presentPaywall: ((String, [String: Any]) -> Void)? = args["useCustomPaywallPresenter"] as? Bool == true
            ? { [weak self] requestId, params in
                guard let self = self else {
                    CheckpointProxy.completePaywallPresentation(requestId: requestId, result: "NAVIGATED_BACK")
                    return
                }
                self.paywallCallsByRequest[requestId] = callId
                let fallback = { self.completePaywall(requestId: requestId, outcome: "NAVIGATED_BACK") }
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
                self.activeCalls.remove(callId)
                result(value)
            },
            onError: { [weak self] code, message in
                guard let self = self, !self.disposed, self.generation == currentGeneration else { return }
                self.activeCalls.remove(callId)
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

    @MainActor
    private func completePaywall(requestId: String, outcome: String) {
        guard let callId = self.paywallCallsByRequest.removeValue(forKey: requestId) else { return }
        if outcome != "CLOSED" && outcome != "CONTINUED" {
            self.activeCalls.remove(callId)
        }
        CheckpointProxy.completePaywallPresentation(requestId: requestId, result: outcome)
    }

    @MainActor
    private func detachOwnedCalls() {
        // A detached screen can still own a presented paywall until Dart completes it.
        let callIds = self.activeCalls.union(self.paywallCallsByRequest.values)
        self.activeCalls.removeAll()
        self.paywallCallsByRequest.removeAll()
        for callId in callIds {
            CheckpointProxy.detachCheckpoint(callId: callId, activePaywallRequestId: nil)
        }
    }

    func dispose() {
        self.disposed = true
        self.channel.setMethodCallHandler(nil)
        DispatchQueue.main.async {
            self.detachOwnedCalls()
        }
    }
}
#endif
