#if os(iOS) && !targetEnvironment(macCatalyst)
import Flutter
import UIKit
import PurchasesHybridCommonUI

/// Experimental until the embedded checkpoint SPI ships in hybrid-common.
final class PurchasesUiCheckpointViewFactory: NSObject, FlutterPlatformViewFactory {
    private let messenger: FlutterBinaryMessenger
    private let views = NSHashTable<AnyObject>.weakObjects()

    static var isAvailable: Bool {
#if RC_CHECKPOINT_EMBEDDED
        if #available(iOS 15.0, *) { return true }
#endif
        return false
    }

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
#if RC_CHECKPOINT_EMBEDDED
        if #available(iOS 15.0, *) {
            return MainActor.assumeIsolated {
                let view = PurchasesUiCheckpointView(arguments: args, messenger: self.messenger)
                self.views.add(view)
                return view
            }
        }
#endif
        return UnsupportedPlatformView()
    }

    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        FlutterStandardMessageCodec.sharedInstance()
    }

    func cancelAll() {
#if RC_CHECKPOINT_EMBEDDED
        if #available(iOS 15.0, *) {
            MainActor.assumeIsolated {
                for case let view as PurchasesUiCheckpointView in self.views.allObjects {
                    view.cancel()
                }
            }
        }
#endif
    }
}

// The currently released hybrid-common has no EmbeddedCheckpointProxy. Keep
// default builds compiling; enable this condition only with the experimental
// native dependencies, then remove the condition once that SPI is released.
#if RC_CHECKPOINT_EMBEDDED
@available(iOS 15.0, *)
@MainActor
private final class PurchasesUiCheckpointView: NSObject, FlutterPlatformView {
    private let callId: String
    private let identifier: String
    private let customVariables: [String: Any]?
    private let channel: FlutterMethodChannel
    private let controller = CheckpointHostViewController()
    private let wrapper: ViewControllerWrapper<CheckpointHostViewController>
    private var proxy: EmbeddedCheckpointProxy?
    private var wantsStart = false
    private var started = false
    private var finished = false

    init(arguments args: Any?, messenger: FlutterBinaryMessenger) {
        let arguments = args as? [String: Any] ?? [:]
        callId = arguments["callId"] as? String ?? ""
        identifier = arguments["identifier"] as? String ?? ""
        customVariables = arguments["customVariables"] as? [String: Any]
        channel = FlutterMethodChannel(
            name: "com.revenuecat.purchasesui/Checkpoint/\(callId)", binaryMessenger: messenger
        )
        wrapper = ViewControllerWrapper(viewController: controller)
        super.init()
        proxy = EmbeddedCheckpointProxy { [weak self] event in
            self?.emit(event)
        }
        controller.onReady = { [weak self] in self?.startIfReady() }
        channel.setMethodCallHandler { [weak self] call, result in
            MainActor.assumeIsolated {
                guard let self else { result(nil); return }
                switch call.method {
                case "start":
                    self.wantsStart = true
                    result(nil)
                    self.startIfReady()
                case "completeError":
                    if let requestId = (call.arguments as? [String: Any])?["requestId"] as? String {
                        self.proxy?.completeError(callId: self.callId, requestId: requestId)
                    }
                    result(nil)
                case "cancel":
                    self.cancel()
                    result(nil)
                default:
                    result(FlutterMethodNotImplemented)
                }
            }
        }
    }

    func view() -> UIView { wrapper }

    private func startIfReady() {
        guard wantsStart, !started, !finished,
              EmbeddedCheckpointProxy.isUsableParent(controller) else { return }
        started = true
        proxy?.start(callId: callId, identifier: identifier, customVariables: customVariables,
                     parentViewController: controller, presentsErrors: true)
    }

    private func emit(_ event: [String: Any]) {
        guard !finished, let type = event["type"] as? String else { return }
        if type == "finished" { finished = true }
        channel.invokeMethod(type, arguments: event) { [weak self] response in
            guard let self else { return }
            if response is FlutterError || (response as? NSObject) === FlutterMethodNotImplemented {
                self.cancel()
            }
        }
        if finished { channel.setMethodCallHandler(nil) }
    }

    func cancel() {
        guard !finished else { return }
        if started {
            proxy?.cancel(callId: callId)
        }
        finished = true
        controller.onReady = nil
        proxy?.cancelAll()
        channel.setMethodCallHandler(nil)
    }

    deinit {
        let proxy = self.proxy
        MainActor.assumeIsolated { proxy?.cancelAll() }
        channel.setMethodCallHandler(nil)
    }
}

@available(iOS 15.0, *)
private final class CheckpointHostViewController: UIViewController {
    var onReady: (() -> Void)?

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        onReady?()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        onReady?()
    }
}
#endif
#endif
