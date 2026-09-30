import Flutter
import UIKit
import PurchasesHybridCommonUI
@_spi(Internal) import RevenueCatUI
import RevenueCat

class PurchasesUiPaywallViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        if #available(iOS 15.0, *) {
            return PurchasesUiPaywallView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger)
        } else {
            print("Error: attempted to present paywalls on unsupported iOS version.")
            return UnsupportedPlatformView()
        }
    }

    /// Implementing this method is only necessary when the `arguments` in `createWithFrame` is not `nil`.
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
          return FlutterStandardMessageCodec.sharedInstance()
    }
}

@available(iOS 15.0, *)
class PurchasesUiPaywallView: NSObject, FlutterPlatformView {
    private var _view: ViewControllerWrapper<PaywallViewController>
    private var _paywallProxy: PaywallProxy?
    private var _methodChannel: FlutterMethodChannel
    private var _paywallViewController: PaywallViewController
    private var _purchaseLogicBridge: HybridPurchaseLogicBridge?
    private let _eventForwarder: PaywallChannelForwarder

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger
    ) {
        _methodChannel = FlutterMethodChannel(name: "com.revenuecat.purchasesui/PaywallView/\(viewId)",
                                              binaryMessenger: messenger)
        _eventForwarder = PaywallChannelForwarder(methodChannel: _methodChannel)
        let paywallProxy = PaywallProxy()
        _paywallProxy = paywallProxy

        let argsDictionary = args as? [String: Any?]

        var purchaseLogicBridge: HybridPurchaseLogicBridge? = nil
        if argsDictionary?["hasPurchaseLogic"] as? Bool == true {
            let methodChannel = _methodChannel
            purchaseLogicBridge = HybridPurchaseLogicBridge(
                onPerformPurchase: { eventData in
                    methodChannel.invokeMethod("onPerformPurchase", arguments: eventData)
                },
                onPerformRestore: { eventData in
                    methodChannel.invokeMethod("onPerformRestore", arguments: eventData)
                }
            )
            _purchaseLogicBridge = purchaseLogicBridge
        }

        let params = PaywallViewCreationParams()
        params.purchaseLogicBridge = purchaseLogicBridge
        params.offeringIdentifier = argsDictionary?["offeringIdentifier"] as? String
        if let presentedOfferingContextMap = argsDictionary?["presentedOfferingContext"] as? [String: Any] {
            params.presentedOfferingContext = presentedOfferingContextMap
        }
        if let customVariables = argsDictionary?["customVariables"] as? [String: Any] {
            params.customVariables = customVariables.compactMapValues { $0 }
        }
        let paywallViewController = paywallProxy.createPaywallView(params: params)
        if let displayCloseButton = argsDictionary?["displayCloseButton"] as? Bool {
            paywallViewController.update(with: displayCloseButton)
        }
        _paywallViewController = paywallViewController
        _view = ViewControllerWrapper(
            viewController: paywallViewController,
            usesSafeAreaLayoutGuide: false
        )

        super.init()
        _paywallProxy?.delegate = _eventForwarder
        setupMethodCallHandler()
    }

    deinit {
        _purchaseLogicBridge?.cancelPending()
    }

    func view() -> UIView {
        return _view
    }

    private func setupMethodCallHandler() {
        _methodChannel.setMethodCallHandler { [weak self] (call, result) in
            guard self != nil else { return }
            switch call.method {
            case "resolvePurchaseLogicResult":
                if let args = call.arguments as? [String: Any],
                   let requestId = args["requestId"] as? String,
                   let resultString = args["result"] as? String {
                    let errorMessage = args["errorMessage"] as? String
                    HybridPurchaseLogicBridge.resolveResult(
                        requestId: requestId,
                        resultString: resultString,
                        errorMessage: errorMessage
                    )
                }
                result(nil)
            default:
                result(FlutterMethodNotImplemented)
            }
        }
    }

}
