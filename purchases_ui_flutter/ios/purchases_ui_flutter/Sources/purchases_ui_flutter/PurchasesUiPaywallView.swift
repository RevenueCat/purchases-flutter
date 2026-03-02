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
class PaywallViewWrapper: UIView {
    private var paywallViewController: PaywallViewController
    private var addedToHierarchy = false

    init(paywallViewController: PaywallViewController) {
        self.paywallViewController = paywallViewController
        super.init(frame: paywallViewController.view.bounds)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        // Need to wait for this view to be in the hierarchy to look for the parent UIVC.
        // This is required to add a SwiftUI `UIHostingController` to the hierarchy in a way that allows
        // UIKit to read properties from the environment, like traits and safe area.
        // Not doing this leads to the view not respecting the safe area.
        if !addedToHierarchy {
            if let parentController = self.parentViewController {
                paywallViewController.view.translatesAutoresizingMaskIntoConstraints = false
                parentController.addChild(paywallViewController)
                addSubview(paywallViewController.view)
                paywallViewController.didMove(toParent: parentController)

                NSLayoutConstraint.activate([
                    paywallViewController.view.topAnchor.constraint(equalTo: topAnchor),
                    paywallViewController.view.bottomAnchor.constraint(equalTo: bottomAnchor),
                    paywallViewController.view.leadingAnchor.constraint(equalTo: leadingAnchor),
                    paywallViewController.view.trailingAnchor.constraint(equalTo: trailingAnchor)
                ])

                addedToHierarchy = true
            }
        }
    }

    override func removeFromSuperview() {
        cleanupViewControllerHierarchy()
        super.removeFromSuperview()
    }

    deinit {
        // Ensure cleanup happens even if removeFromSuperview wasn't called
        cleanupViewControllerHierarchy()
    }

    private func cleanupViewControllerHierarchy() {
        guard addedToHierarchy else { return }
        paywallViewController.willMove(toParent: nil)
        paywallViewController.view.removeFromSuperview()
        paywallViewController.removeFromParent()
        addedToHierarchy = false
    }
}

@available(iOS 15.0, *)
class PurchasesUiPaywallView: NSObject, FlutterPlatformView {
    private var _view: PaywallViewWrapper
    private var _paywallProxy: PaywallProxy?
    private var _methodChannel: FlutterMethodChannel
    private var _paywallViewController: PaywallViewController
    private var _purchaseLogicBridge: HybridPurchaseLogicBridge?

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger
    ) {
        _methodChannel = FlutterMethodChannel(name: "com.revenuecat.purchasesui/PaywallView/\(viewId)",
                                              binaryMessenger: messenger)
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
        let paywallViewController = paywallProxy.createPaywallView(params: params)
        // Custom variables must be set before any other updates that might initialize the hosting controller
        if let customVariables = argsDictionary?["customVariables"] as? [String: Any] {
            customVariables
                .compactMapValues { $0 as? String }
                .forEach { key, value in
                    paywallViewController.setCustomVariable(value, forKey: key)
                }
        }
        if let displayCloseButton = argsDictionary?["displayCloseButton"] as? Bool {
            paywallViewController.update(with: displayCloseButton)
        }
        _paywallViewController = paywallViewController
        _view = PaywallViewWrapper(paywallViewController: paywallViewController)

        super.init()
        _paywallProxy?.delegate = self
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

@available(iOS 15.0, *)
extension PurchasesUiPaywallView: PaywallViewControllerDelegateWrapper {
    func paywallViewController(_ controller: PaywallViewController, 
                               didStartPurchaseWith packageDictionary: [String : Any]) {
        _methodChannel.invokeMethod("onPurchaseStarted", arguments: packageDictionary)
    }

    func paywallViewController(_ controller: PaywallViewController, 
                               didFinishPurchasingWith customerInfoDictionary: [String : Any],
                               transaction transactionDictionary: [String : Any]?) {
        _methodChannel.invokeMethod("onPurchaseCompleted", arguments: [
            "customerInfo":customerInfoDictionary,
            "storeTransaction":transactionDictionary
        ])
    }

    func paywallViewControllerDidCancelPurchase(_ controller: PaywallViewController) {
        _methodChannel.invokeMethod("onPurchaseCancelled", arguments: nil)
    }

    func paywallViewController(_ controller: PaywallViewController, 
                               didFailPurchasingWith errorDictionary: [String : Any]) {
        _methodChannel.invokeMethod("onPurchaseError", arguments: errorDictionary)
    }

    func paywallViewController(_ controller: PaywallViewController, 
                               didFinishRestoringWith customerInfoDictionary: [String : Any]) {
        _methodChannel.invokeMethod("onRestoreCompleted", arguments: customerInfoDictionary)
    }

    func paywallViewController(_ controller: PaywallViewController,
                               didFailRestoringWith errorDictionary: [String : Any]) {
        _methodChannel.invokeMethod("onRestoreError", arguments: errorDictionary)
    }

    func paywallViewControllerRequestedDismissal(_ controller: PaywallViewController) {
        _methodChannel.invokeMethod("onDismiss", arguments: nil)
    }
}
