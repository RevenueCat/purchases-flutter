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
        return PurchasesUiPaywallView(
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

class PurchasesUiPaywallView: NSObject, FlutterPlatformView {
    private var _view: UIView

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        if #available(iOS 15.0, *) {
            let paywallProxy = PaywallProxy()
            guard let paywallView = paywallProxy.createPaywallView().view else {
                print("Error: error getting PaywallView.")
                _view = UIView()
                super.init()
                return
            }
            _view = paywallView
        } else {
            print("Error: attempted to present paywalls on unsupported iOS version.")
            _view = UIView()
        }
        super.init()
    }

    func view() -> UIView {
        return _view
    }

}
