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
class PurchasesUiPaywallView: NSObject, FlutterPlatformView {
    private var _view: UIView
    private var _paywallProxy: PaywallProxy?
    private var _methodChannel: FlutterMethodChannel
    // Need to keep the controller in memory while this view is alive otherwise the delegate is dealocated
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
        guard let paywallView = _paywallViewController.view else {
            print("Error: error getting PaywallView.")
            _view = UIView()
            super.init()
            return
        }
        _view = paywallView

        super.init()
        _paywallProxy?.delegate = self;
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
