#if os(macOS)
import FlutterMacOS
#else
import Flutter
#endif

import PurchasesHybridCommonUI
import Foundation

public class PurchasesUiFlutterPlugin: NSObject, FlutterPlugin {

    private static let BAD_ARGS_ERROR_CODE = "BAD_ARGS"
    private var methodChannel: FlutterMethodChannel?

    public static func register(with registrar: FlutterPluginRegistrar) {

#if os(macOS)
        let messenger = registrar.messenger
#else
        let messenger = registrar.messenger()
        let factory = PurchasesUiPaywallViewFactory(messenger: messenger)
        let footerFactory = PurchasesUiPaywallFooterViewFactory(messenger: messenger)
        let customerCenterFactory = PurchasesUiCustomerCenterViewFactory(messenger: messenger)

        registrar.register(factory, withId: "com.revenuecat.purchasesui/PaywallView")
        registrar.register(footerFactory, withId: "com.revenuecat.purchasesui/PaywallFooterView")
        registrar.register(customerCenterFactory, withId: "com.revenuecat.purchasesui/CustomerCenterView")

#endif
        let channel = FlutterMethodChannel(name: "purchases_ui_flutter", binaryMessenger: messenger)
        let instance = PurchasesUiFlutterPlugin()
        instance.methodChannel = channel
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    private var _paywallProxy: Any?
    private var _customerCenterProxy: Any?
    private var _customerCenterDelegateForwarder: Any?

#if os(iOS)
    @available(iOS 15.0, *)
    private var paywallProxy: PaywallProxy {
        get {
            // swiftlint:disable:next force_cast
            return self._paywallProxy as! PaywallProxy
        }

        set {
            self._paywallProxy = newValue
        }
    }

    @available(iOS 15.0, *)
    private var customerCenterProxy: CustomerCenterProxy {
        get {
            // swiftlint:disable:next force_cast
            return self._customerCenterProxy as! CustomerCenterProxy
        }

        set {
            self._customerCenterProxy = newValue
        }
    }

    @available(iOS 15.0, *)
    private var customerCenterDelegateForwarder: CustomerCenterDelegateForwarder? {
        get {
            return self._customerCenterDelegateForwarder as? CustomerCenterDelegateForwarder
        }

        set {
            self._customerCenterDelegateForwarder = newValue
        }
    }

#endif

    override init() {
#if os(iOS)
        if #available(iOS 15.0, *) {
            self._paywallProxy = PaywallProxy()
            self._customerCenterProxy = CustomerCenterProxy()
        }
#endif
        super.init()
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {

        case "setCustomerCenterCallbacks":
            self.setCustomerCenterCallbacks(result)

        case "clearCustomerCenterCallbacks":
            self.clearCustomerCenterCallbacks(result)

        case "presentPaywall":
            let args = call.arguments as? Dictionary<String, Any> ?? [:]

            self.presentPaywall(
                result,
                requiredEntitlementIdentifier: nil,
                offeringIdentifier: args[Parameter.offeringIdentifier.rawValue] as? String,
                presentedOfferingContext: args[Parameter.presentedOfferingContext.rawValue] as? [String: Any],
                displayCloseButton: args[Parameter.displayCloseButton.rawValue] as? Bool
            )

        case "presentPaywallIfNeeded":
            guard let args = call.arguments as? Dictionary<String, Any> else {
                result(FlutterError(code: PurchasesUiFlutterPlugin.BAD_ARGS_ERROR_CODE,
                                    message: "Invalid arguments type",
                                    details: nil))
                return
            }
            guard let requiredEntitlementIdentifier = args[Parameter.requiredEntitlementIdentifier.rawValue] as? String? else {
                result(FlutterError(code: PurchasesUiFlutterPlugin.BAD_ARGS_ERROR_CODE,
                                    message: "Missing requiredEntitlementIdentifier in presentPaywallIfNeeded",
                                    details: nil))
                return
            }

            self.presentPaywall(
                result,
                requiredEntitlementIdentifier: requiredEntitlementIdentifier,
                offeringIdentifier: args[Parameter.offeringIdentifier.rawValue] as? String,
                presentedOfferingContext: args[Parameter.presentedOfferingContext.rawValue] as? [String: Any],
                displayCloseButton: args[Parameter.displayCloseButton.rawValue] as? Bool
            )

        case "presentCustomerCenter":
            self.presentCustomerCenter(
                result
            )
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func setCustomerCenterCallbacks(
        _ result: @escaping FlutterResult
    ) {
#if os(iOS)
        if #available(iOS 15.0, *) {
            self.ensureCustomerCenterDelegateForwarder()
            result(nil)
        } else {
            result(nil)
        }
#else
        result(nil)
#endif
    }

    private func clearCustomerCenterCallbacks(
        _ result: @escaping FlutterResult
    ) {
#if os(iOS)
        if #available(iOS 15.0, *) {
            self.customerCenterProxy.delegate = nil
            self.customerCenterDelegateForwarder = nil
            result(nil)
        } else {
            result(nil)
        }
#else
        result(nil)
#endif
    }

    private func presentPaywall(
        _ result: @escaping FlutterResult,
        requiredEntitlementIdentifier: String?,
        offeringIdentifier: String?,
        presentedOfferingContext: [String: Any]?,
        displayCloseButton: Bool?
    ) {
#if os(iOS)
        if #available(iOS 15.0, *) {
            let displayCloseButton = displayCloseButton ?? false

            var options: [String:Any] = [
                PaywallProxy.PaywallOptionsKeys.displayCloseButton: displayCloseButton,
                // This is needed for: https://github.com/RevenueCat/purchases-flutter/issues/1023
                PaywallProxy.PaywallOptionsKeys.shouldBlockTouchEvents: true
            ]

            if let offeringIdentifier {
                options[PaywallProxy.PaywallOptionsKeys.offeringIdentifier] = offeringIdentifier

                if let presentedOfferingContext {
                    options[PaywallProxy.PaywallOptionsKeys.presentedOfferingContext] = presentedOfferingContext
                }
            }

            if let requiredEntitlementIdentifier {
                options[PaywallProxy.PaywallOptionsKeys.requiredEntitlementIdentifier] = requiredEntitlementIdentifier

                self.paywallProxy.presentPaywallIfNeeded(
                    options: options,
                    paywallResultHandler: result
                )
            } else {
                self.paywallProxy.presentPaywall(
                    options: options,
                    paywallResultHandler: result
                )
            }
        } else {
            NSLog("Presenting paywall requires iOS 15+")
        }
#else
        NSLog("Presenting paywall requires iOS")
#endif
    }

    private func presentCustomerCenter(
        _ result: @escaping FlutterResult
    ) {
#if os(iOS)
    if #available(iOS 15.0, *) {
        // Set up delegate to forward events to Flutter
        self.ensureCustomerCenterDelegateForwarder()
        
        self.customerCenterProxy.present(resultHandler: {
            result(nil)
        })
    } else {
        let errorMessage = "Presenting customer center requires iOS 15+"
        NSLog(errorMessage)
        result(FlutterError(
            code: "UNSUPPORTED_OS_VERSION",
            message: errorMessage,
            details: nil
        ))
    }
#else
    let errorMessage = "Presenting customer center requires iOS"
    NSLog(errorMessage)
    result(FlutterError(
        code: "UNSUPPORTED_PLATFORM",
        message: errorMessage,
        details: nil
    ))
#endif
    }
}

private extension PurchasesUiFlutterPlugin {

    enum Parameter: String {
        case requiredEntitlementIdentifier
        case offeringIdentifier
        case presentedOfferingContext
        case displayCloseButton
    }

#if os(iOS)
    @available(iOS 15.0, *)
    func ensureCustomerCenterDelegateForwarder() {
        if self.customerCenterDelegateForwarder == nil {
            self.customerCenterDelegateForwarder = CustomerCenterDelegateForwarder(methodChannel: self.methodChannel)
        }
        self.customerCenterProxy.delegate = self.customerCenterDelegateForwarder
    }
#endif

}

// MARK: - CustomerCenter Delegate Forwarder

#if os(iOS)
@available(iOS 15.0, *)
class CustomerCenterDelegateForwarder: NSObject, CustomerCenterViewControllerDelegateWrapper {
    
    private weak var methodChannel: FlutterMethodChannel?
    
    init(methodChannel: FlutterMethodChannel?) {
        self.methodChannel = methodChannel
    }
    
    func customerCenterViewControllerWasDismissed(_ controller: CustomerCenterUIViewController) {
        methodChannel?.invokeMethod("onDismiss", arguments: nil)
    }
    
    func customerCenterViewControllerDidStartRestore(_ controller: CustomerCenterUIViewController) {
        methodChannel?.invokeMethod("onRestoreStarted", arguments: nil)
    }
    
    func customerCenterViewController(_ controller: CustomerCenterUIViewController, didFinishRestoringWith customerInfoDictionary: [String: Any]) {
        methodChannel?.invokeMethod("onRestoreCompleted", arguments: customerInfoDictionary)
    }
    
    func customerCenterViewController(_ controller: CustomerCenterUIViewController, didFailRestoringWith errorDictionary: [String: Any]) {
        methodChannel?.invokeMethod("onRestoreFailed", arguments: errorDictionary)
    }
    
    func customerCenterViewControllerDidShowManageSubscriptions(_ controller: CustomerCenterUIViewController) {
        methodChannel?.invokeMethod("onShowingManageSubscriptions", arguments: nil)
    }
    
    func customerCenterViewController(_ controller: CustomerCenterUIViewController, didStartRefundRequestForProductWithID productID: String) {
        let args = [
            "productId": productID
        ]
        methodChannel?.invokeMethod("onRefundRequestStarted", arguments: args)
    }
    
    func customerCenterViewController(_ controller: CustomerCenterUIViewController, didCompleteRefundRequestForProductWithID productId: String, withStatus status: String) {
        let args = [
            "productId": productId,
            "status": status
        ]
        methodChannel?.invokeMethod("onRefundRequestCompleted", arguments: args)
    }
    
    func customerCenterViewController(_ controller: CustomerCenterUIViewController, didSelectCustomerCenterManagementOption optionID: String, withURL url: String?) {
        let args = [
            "optionId": optionID,
            "url": url as Any
        ]
        methodChannel?.invokeMethod("onManagementOptionSelected", arguments: args)
    }
    
    func customerCenterViewController(_ controller: CustomerCenterUIViewController, didCompleteFeedbackSurveyWithOptionID optionID: String) {
        let args = [
            "optionId": optionID
        ]
        methodChannel?.invokeMethod("onFeedbackSurveyCompleted", arguments: args)
    }
    
    func customerCenterViewController(_ controller: CustomerCenterUIViewController, didSelectCustomAction actionID: String, withPurchaseIdentifier purchaseIdentifier: String?) {
        let args = [
            "actionId": actionID,
            "purchaseIdentifier": purchaseIdentifier as Any
        ]
        methodChannel?.invokeMethod("onCustomActionSelected", arguments: args)
    }
}
#endif
