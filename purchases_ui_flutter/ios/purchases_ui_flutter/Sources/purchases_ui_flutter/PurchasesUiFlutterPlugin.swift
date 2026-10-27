#if os(macOS)
import FlutterMacOS
#else
import Flutter
#endif

import PurchasesHybridCommon
import PurchasesHybridCommonUI
import Foundation
#if os(iOS)
@_spi(Internal) import RevenueCat
@_spi(InviteOnlyCheckpointsApi) import RevenueCatUI
#endif

public class PurchasesUiFlutterPlugin: NSObject, FlutterPlugin {

    private static let BAD_ARGS_ERROR_CODE = "BAD_ARGS"
    private var methodChannel: FlutterMethodChannel?
    private var binaryMessenger: FlutterBinaryMessenger?

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
        instance.binaryMessenger = messenger
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
                displayCloseButton: args[Parameter.displayCloseButton.rawValue] as? Bool,
                customVariables: args[Parameter.customVariables.rawValue] as? [String: Any],
                useFullScreenPresentation: args[Parameter.useFullScreenPresentation.rawValue] as? Bool,
                presentationId: args[Parameter.presentationId.rawValue] as? Int
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
                displayCloseButton: args[Parameter.displayCloseButton.rawValue] as? Bool,
                customVariables: args[Parameter.customVariables.rawValue] as? [String: Any],
                useFullScreenPresentation: args[Parameter.useFullScreenPresentation.rawValue] as? Bool,
                presentationId: args[Parameter.presentationId.rawValue] as? Int
            )

        case "presentCustomerCenter":
            self.presentCustomerCenter(
                result
            )

        case "checkpoint":
            guard let args = call.arguments as? Dictionary<String, Any>,
                  let identifier = args[Parameter.identifier.rawValue] as? String else {
                result(FlutterError(code: PurchasesUiFlutterPlugin.BAD_ARGS_ERROR_CODE,
                                    message: "Missing identifier in checkpoint",
                                    details: nil))
                return
            }
            self.checkpoint(
                result,
                identifier: identifier,
                customVariables: args[Parameter.customVariables.rawValue] as? [String: Any],
                presentationMode: args[Parameter.presentationMode.rawValue] as? String
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
            self.setCustomerCenterDelegateForwarderIfNeeded()
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
        displayCloseButton: Bool?,
        customVariables: [String: Any]?,
        useFullScreenPresentation: Bool?,
        presentationId: Int?
    ) {
#if os(iOS)
        if #available(iOS 15.0, *) {
            let displayCloseButton = displayCloseButton ?? false

            var presentationDelegate: PaywallChannelForwarder?
            if let presentationId, let binaryMessenger = self.binaryMessenger {
                let channel = FlutterMethodChannel(
                    name: "com.revenuecat.purchasesui/PresentedPaywall/\(presentationId)",
                    binaryMessenger: binaryMessenger
                )
                presentationDelegate = PaywallChannelForwarder(methodChannel: channel)
            }

            var options: [String:Any] = [
                PaywallProxy.PaywallOptionsKeys.displayCloseButton: displayCloseButton,
                // This is needed for: https://github.com/RevenueCat/purchases-flutter/issues/1023
                PaywallProxy.PaywallOptionsKeys.shouldBlockTouchEvents: true,
            ]

            if let useFullScreenPresentation {
                options[PaywallProxy.PaywallOptionsKeys.useFullScreenPresentation] = useFullScreenPresentation
            }

            if let offeringIdentifier {
                options[PaywallProxy.PaywallOptionsKeys.offeringIdentifier] = offeringIdentifier

                if let presentedOfferingContext {
                    options[PaywallProxy.PaywallOptionsKeys.presentedOfferingContext] = presentedOfferingContext
                }
            }

            if let customVariables {
                options[PaywallProxy.PaywallOptionsKeys.customVariables] = customVariables
            }

            if let requiredEntitlementIdentifier {
                options[PaywallProxy.PaywallOptionsKeys.requiredEntitlementIdentifier] = requiredEntitlementIdentifier

                self.paywallProxy.presentPaywallIfNeeded(
                    options: options,
                    purchaseLogicBridge: nil,
                    delegate: presentationDelegate,
                    paywallResultHandler: result
                )
            } else {
                self.paywallProxy.presentPaywall(
                    options: options,
                    purchaseLogicBridge: nil,
                    delegate: presentationDelegate,
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

    private func checkpoint(
        _ result: @escaping FlutterResult,
        identifier: String,
        customVariables: [String: Any]?,
        presentationMode: String?
    ) {
#if os(iOS)
        guard #available(iOS 15.0, *) else {
            result(FlutterError(code: "UNSUPPORTED_OS_VERSION",
                                message: "Checkpoints require iOS 15+",
                                details: nil))
            return
        }
        guard Purchases.isConfigured else {
            result(FlutterError(code: "NOT_CONFIGURED",
                                message: "Configure Purchases before calling a checkpoint.",
                                details: nil))
            return
        }

        let variables = (customVariables ?? [:]).compactMapValues { value -> CustomVariableValue? in
            if let number = value as? NSNumber {
                return CFGetTypeID(number) == CFBooleanGetTypeID()
                    ? .bool(number.boolValue) : .number(number.doubleValue)
            }
            if let string = value as? String { return .string(string) }
            return nil
        }
        let mode: FlowPresentationMode
        switch presentationMode {
        case "MODAL_FULL_SCREEN": mode = .modalFullScreen
        case "MODAL_SHEET": mode = .modalSheet
        default: mode = .default
        }

        // Replies at most once, and only when the checkpoint passes: backing out never invokes the callback.
        Purchases.shared.checkpoint(identifier, customVariables: variables, presentationMode: mode) { checkpointResult in
            let customer = checkpointResult.customer.dictionary
            let entitlements = (customer["entitlements"] as? [String: Any])?["all"] as? [String: Any] ?? [:]
            let flow: Any = checkpointResult.flow.map { flow -> [String: Any] in
                [
                    "obtainedEntitlements": flow.obtainedEntitlements.sorted {
                        $0.entitlementInfo.identifier < $1.entitlementInfo.identifier
                    }.map { ["entitlementInfo": entitlements[$0.entitlementInfo.identifier] ?? NSNull()] },
                    "obtainedProducts": flow.obtainedProducts.sorted { $0.product.id < $1.product.id }.map {
                        // PHC exposes the product serializer through Package.dictionary. Use that
                        // serializer on the original product to preserve its billing plan and context.
                        let package = Package(identifier: $0.product.id, packageType: .custom,
                                              storeProduct: $0.product, offeringIdentifier: "", webCheckoutUrl: nil)
                        return ["product": package.dictionary["product"] ?? NSNull()]
                    }
                ]
            } ?? NSNull()
            result(["flow": flow, "customer": customer])
        }
#else
        result(FlutterError(code: "UNSUPPORTED_PLATFORM",
                            message: "Checkpoints require iOS",
                            details: nil))
#endif
    }

    private func presentCustomerCenter(
        _ result: @escaping FlutterResult
    ) {
#if os(iOS)
    if #available(iOS 15.0, *) {
        // Set up delegate to forward events to Flutter
        self.setCustomerCenterDelegateForwarderIfNeeded()
        
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
        case customVariables
        case useFullScreenPresentation
        case presentationId
        case identifier
        case presentationMode
    }

#if os(iOS)
    @available(iOS 15.0, *)
    func setCustomerCenterDelegateForwarderIfNeeded() {
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
final class CustomerCenterDelegateForwarder: NSObject, CustomerCenterViewControllerDelegateWrapper {
    
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

    func customerCenterViewController(
        _ controller: CustomerCenterUIViewController,
        didSucceedWithPromotionalOffer offerId: String,
        customerInfoDictionary: [String: Any],
        transactionDictionary: [String: Any]
    ) {
        methodChannel?.invokeMethod(
            "onPromotionalOfferSucceeded",
            arguments: [
                "customerInfo": customerInfoDictionary,
                "transaction": transactionDictionary,
                "offerId": offerId
            ]
        )
    }
}
#endif
