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
        return PurchasesUiPaywallFooterView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger)
    }

    /// Implementing this method is only necessary when the `arguments` in `createWithFrame` is not `nil`.
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
          return FlutterStandardMessageCodec.sharedInstance()
    }
}

class PurchasesUiPaywallFooterView: NSObject, FlutterPlatformView, PaywallViewControllerDelegateWrapper {
    private var _view: UIView
    private let channel: FlutterMethodChannel?

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger
    ) {
        if #available(iOS 15.0, *) {
            channel = FlutterMethodChannel(name: "purchases_ui_flutter/PaywallFooterView/\(viewId)",
                                           binaryMessenger: messenger)
            let paywallProxy = PaywallProxy()
            let paywallFooterViewController = paywallProxy.createFooterPaywallView()
            if let args = args as? [String: Any?] {
                if let offeringId = args["offeringIdentifier"] as? String {
                    paywallFooterViewController.update(with: offeringId)
                }
            }
            guard let paywallFooterView = paywallFooterViewController.view else {
                print("Error: error getting PaywallView.")
                _view = UIView()
                super.init()
                return
            }
            let newHeight = paywallFooterView.bounds.height
            _view = paywallFooterView
            channel?.invokeMethod("onHeightChanged", arguments: newHeight)
        } else {
            print("Error: attempted to present footer paywalls on unsupported iOS version.")
            _view = UIView()
            channel = nil
        }
        super.init()
    }

    func view() -> UIView {
        return _view
    }

    @available(iOS 15.0, macOS 12.0, tvOS 15.0, *)
    func paywallViewController(_ controller: PaywallViewController, didChangeSizeTo size: CGSize) {
        let newHeight = _view.bounds.height
        channel?.invokeMethod("onHeightChanged", arguments: newHeight)
    }

}
