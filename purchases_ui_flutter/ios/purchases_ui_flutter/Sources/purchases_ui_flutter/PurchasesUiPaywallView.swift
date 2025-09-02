import Flutter
import UIKit
import PurchasesHybridCommonUI
import RevenueCatUI

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
}

@available(iOS 15.0, *)
class PurchasesUiPaywallView: NSObject, FlutterPlatformView {
    private var _view: PaywallViewWrapper
    private var _paywallProxy: PaywallProxy?
    private var _methodChannel: FlutterMethodChannel
    private var _paywallViewController: PaywallViewController

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
        _paywallViewController = paywallProxy.createPaywallView()
        if let args = args as? [String: Any?] {
            if let offeringId = args["offeringIdentifier"] as? String {
                _paywallViewController.update(with: offeringId)
            }
            if let displayCloseButton = args["displayCloseButton"] as? Bool {
                _paywallViewController.update(with: displayCloseButton)
            }
        }
        _view = PaywallViewWrapper(paywallViewController: _paywallViewController)

        super.init()
        _paywallProxy?.delegate = self
        setupMethodCallHandler()
    }

    func view() -> UIView {
        return _view
    }

    private func setupMethodCallHandler() {
        _methodChannel.setMethodCallHandler { [weak self] (call, result) in
            guard self != nil else { return }
            switch call.method {
            // We currently don't have any communication in this channel from dart to native,
            // so this can be empty.
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
