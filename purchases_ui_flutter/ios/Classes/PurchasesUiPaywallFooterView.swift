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
    private var _paywallFooterViewController: PaywallFooterViewController
    private let channel: FlutterMethodChannel

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger
    ) {
        channel = FlutterMethodChannel(name: "purchases_ui_flutter/PaywallFooterView/\(viewId)",
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

}
