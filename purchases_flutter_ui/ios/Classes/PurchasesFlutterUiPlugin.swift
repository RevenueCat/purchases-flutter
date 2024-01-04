#if os(macOS)
import FlutterMacOS
#else
import Flutter
#endif
import PurchasesHybridCommon
import Foundation

public class PurchasesFlutterUiPlugin: NSObject, FlutterPlugin {

    private static let BAD_ARGS_ERROR_CODE = "BAD_ARGS"

    public static func register(with registrar: FlutterPluginRegistrar) {

        #if os(macOS)
        let messenger = registrar.messenger
        #else
        let messenger = registrar.messenger()
        #endif
        let channel = FlutterMethodChannel(name: "purchases_flutter_ui", binaryMessenger: messenger)
        let instance = PurchasesFlutterUiPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    private var _paywallProxy: Any?

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
    #endif

    override init() {
        #if os(iOS)
        if #available(iOS 15.0, *) {
            self._paywallProxy = PaywallProxy()
        }
        #endif
        super.init()
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "presentPaywall":
            self.presentPaywall(result, requiredEntitlementIdentifier: nil)
        case "presentPaywallIfNeeded":
            guard let args = call.arguments as? Dictionary<String, Any> else {
                result(FlutterError(code: PurchasesFlutterUiPlugin.BAD_ARGS_ERROR_CODE,
                                    message: "Invalid arguments type",
                                    details: nil))
                return
            }
            guard let requiredEntitlementIdentifier = args["requiredEntitlementIdentifier"] as? String? else {
                result(FlutterError(code: PurchasesFlutterUiPlugin.BAD_ARGS_ERROR_CODE,
                                    message: "Missing requiredEntitlementIdentifier in presentPaywallIfNeeded",
                                    details: nil))
                return
            }
            self.presentPaywall(result, requiredEntitlementIdentifier: requiredEntitlementIdentifier)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func presentPaywall(_ result: @escaping FlutterResult, requiredEntitlementIdentifier: String?) {
        #if os(iOS)
        if #available(iOS 15.0, *) {
            if let requiredEntitlementIdentifier {
                self.paywallProxy.presentPaywallIfNeeded(requiredEntitlementIdentifier: requiredEntitlementIdentifier)
            } else {
                self.paywallProxy.presentPaywall()
            }
        } else {
            NSLog("Presenting paywall requires iOS 15+")
        }
        #else
        NSLog("Presenting paywall requires iOS")
        #endif
        result(nil)
    }

}
