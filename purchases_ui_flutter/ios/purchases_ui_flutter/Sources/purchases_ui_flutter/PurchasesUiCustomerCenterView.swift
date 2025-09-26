import Flutter
import UIKit
import PurchasesHybridCommonUI
@_spi(Internal) import RevenueCatUI
import RevenueCat

final class PurchasesUiCustomerCenterViewFactory: NSObject, FlutterPlatformViewFactory {
    private let messenger: FlutterBinaryMessenger

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
            return PurchasesUiCustomerCenterView(
                frame: frame,
                viewIdentifier: viewId,
                arguments: args,
                binaryMessenger: messenger
            )
        } else {
            print("Error: attempted to present customer center on unsupported iOS version.")
            return UnsupportedPlatformView()
        }
    }

    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        FlutterStandardMessageCodec.sharedInstance()
    }
}

@available(iOS 15.0, *)
final class PurchasesUiCustomerCenterView: NSObject, FlutterPlatformView {
    private let methodChannel: FlutterMethodChannel
    private let viewController: CustomerCenterUIViewController
    private let wrapperView: ViewControllerWrapper<CustomerCenterUIViewController>

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger
    ) {
        methodChannel = FlutterMethodChannel(
            name: "com.revenuecat.purchasesui/CustomerCenterView/\(viewId)",
            binaryMessenger: messenger
        )

        viewController = CustomerCenterUIViewController()
        wrapperView = ViewControllerWrapper(viewController: viewController)

        super.init()

        setupMethodChannel()
        configureViewController(arguments: args)
    }

    func view() -> UIView {
        wrapperView
    }

    private func setupMethodChannel() {
        methodChannel.setMethodCallHandler { _, result in
            result(FlutterMethodNotImplemented)
        }
    }

    private func configureViewController(arguments args: Any?) {
        viewController.delegate = self

        if let arguments = args as? [String: Any],
           let shouldShowCloseButton = arguments["shouldShowCloseButton"] as? Bool {
            viewController.shouldShowCloseButton = shouldShowCloseButton
        }

        viewController.onCloseHandler = { [weak self] in
            self?.methodChannel.invokeMethod("onDismiss", arguments: nil)
        }
    }
}

@available(iOS 15.0, *)
extension PurchasesUiCustomerCenterView: CustomerCenterViewControllerDelegateWrapper {
    func customerCenterViewControllerWasDismissed(_ controller: CustomerCenterUIViewController) {
        methodChannel.invokeMethod("onDismiss", arguments: nil)
    }

    func customerCenterViewControllerDidStartRestore(_ controller: CustomerCenterUIViewController) {
        methodChannel.invokeMethod("onRestoreStarted", arguments: nil)
    }

    func customerCenterViewController(
        _ controller: CustomerCenterUIViewController,
        didFinishRestoringWith customerInfoDictionary: [String : Any]
    ) {
        methodChannel.invokeMethod("onRestoreCompleted", arguments: customerInfoDictionary)
    }

    func customerCenterViewController(
        _ controller: CustomerCenterUIViewController,
        didFailRestoringWith errorDictionary: [String : Any]
    ) {
        methodChannel.invokeMethod("onRestoreFailed", arguments: errorDictionary)
    }

    func customerCenterViewControllerDidShowManageSubscriptions(_ controller: CustomerCenterUIViewController) {
        methodChannel.invokeMethod("onShowingManageSubscriptions", arguments: nil)
    }

    func customerCenterViewController(
        _ controller: CustomerCenterUIViewController,
        didStartRefundRequestForProductWithID productID: String
    ) {
        methodChannel.invokeMethod("onRefundRequestStarted", arguments: productID)
    }

    func customerCenterViewController(
        _ controller: CustomerCenterUIViewController,
        didCompleteRefundRequestForProductWithID productId: String,
        withStatus status: String
    ) {
        methodChannel.invokeMethod(
            "onRefundRequestCompleted",
            arguments: [
                "productId": productId,
                "status": status
            ]
        )
    }

    func customerCenterViewController(
        _ controller: CustomerCenterUIViewController,
        didSelectCustomerCenterManagementOption optionID: String,
        withURL url: String?
    ) {
        methodChannel.invokeMethod(
            "onManagementOptionSelected",
            arguments: [
                "optionId": optionID,
                "url": url as Any
            ]
        )
    }

    func customerCenterViewController(
        _ controller: CustomerCenterUIViewController,
        didCompleteFeedbackSurveyWithOptionID optionID: String
    ) {
        methodChannel.invokeMethod("onFeedbackSurveyCompleted", arguments: optionID)
    }

    func customerCenterViewController(
        _ controller: CustomerCenterUIViewController,
        didSelectCustomAction actionID: String,
        withPurchaseIdentifier purchaseIdentifier: String?
    ) {
        methodChannel.invokeMethod(
            "onCustomActionSelected",
            arguments: [
                "actionId": actionID,
                "purchaseIdentifier": purchaseIdentifier as Any
            ]
        )
    }
}
