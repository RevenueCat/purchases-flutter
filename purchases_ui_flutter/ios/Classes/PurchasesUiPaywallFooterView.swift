import Flutter
import UIKit
import PurchasesHybridCommonUI
import RevenueCatUI

class PurchasesUiPaywallFooterViewFactory: NSObject, FlutterPlatformViewFactory {
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
            return PurchasesUiPaywallFooterView(
                frame: frame,
                viewIdentifier: viewId,
                arguments: args,
                binaryMessenger: messenger)
        } else {
            print("Error: attempted to present paywall footer on unsupported iOS version.")
            return UnsupportedPlatformView()
        }
    }

    /// Implementing this method is only necessary when the `arguments` in `createWithFrame` is not `nil`.
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
          return FlutterStandardMessageCodec.sharedInstance()
    }
}

@available(iOS 15.0, *)
class PurchasesUiPaywallFooterView: NSObject, FlutterPlatformView {
    private let _view: UIView
    private var _paywallProxy: PaywallProxy?
    // Need to keep the controller in memory while this view is alive otherwise the delegate is dealocated
    private var _paywallFooterViewController: PaywallFooterViewController
    private let channel: FlutterMethodChannel

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger
    ) {
        channel = FlutterMethodChannel(name: "com.revenuecat.purchasesui/PaywallFooterView/\(viewId)",
                                       binaryMessenger: messenger)
        let paywallProxy = PaywallProxy()
        _paywallProxy = paywallProxy
        let paywallFooterViewController = paywallProxy.createFooterPaywallView()
        _paywallFooterViewController = paywallFooterViewController
        if let args = args as? [String: Any?] {
            if let offeringId = args["offeringIdentifier"] as? String {
                paywallFooterViewController.update(with: offeringId)
            }
        }
        guard let paywallFooterView = paywallFooterViewController.view else {
            print("Error: error getting PaywallFooterView.")
            _view = UIView()
            super.init()
            return
        }
        _view = paywallFooterView
        super.init()
        paywallProxy.delegate = self
    }

    func view() -> UIView {
        return _view
    }
}


@available(iOS 15.0, *)
extension PurchasesUiPaywallFooterView: PaywallViewControllerDelegateWrapper {

    func paywallViewController(_ controller: PaywallViewController, didChangeSizeTo size: CGSize) {
        let newHeight = size.height
        channel.invokeMethod("onHeightChanged", arguments: newHeight)
    }

    func paywallViewController(_ controller: PaywallViewController,
                               didStartPurchaseWith packageDictionary: [String : Any]) {
        channel.invokeMethod("onPurchaseStarted", arguments: packageDictionary)
    }

    func paywallViewController(_ controller: PaywallViewController,
                               didFinishPurchasingWith customerInfoDictionary: [String : Any],
                               transaction transactionDictionary: [String : Any]?) {
        channel.invokeMethod("onPurchaseCompleted", arguments: [
            "customerInfo":customerInfoDictionary,
            "storeTransaction":transactionDictionary
        ])
    }

    func paywallViewControllerDidCancelPurchase(_ controller: PaywallViewController) {
        channel.invokeMethod("onPurchaseCancelled", arguments: nil)
    }

    func paywallViewController(_ controller: PaywallViewController,
                               didFailPurchasingWith errorDictionary: [String : Any]) {
        channel.invokeMethod("onPurchaseError", arguments: errorDictionary)
    }

    func paywallViewController(_ controller: PaywallViewController,
                               didFinishRestoringWith customerInfoDictionary: [String : Any]) {
        channel.invokeMethod("onRestoreCompleted", arguments: customerInfoDictionary)
    }

    func paywallViewController(_ controller: PaywallViewController,
                               didFailRestoringWith errorDictionary: [String : Any]) {
        channel.invokeMethod("onRestoreError", arguments: errorDictionary)
    }

    func paywallViewControllerRequestedDismissal(_ controller: PaywallViewController) {
        channel.invokeMethod("onDismiss", arguments: nil)
    }
}
