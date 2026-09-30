import Flutter
import PurchasesHybridCommonUI
import RevenueCatUI

@available(iOS 15.0, *)
final class PaywallChannelForwarder: NSObject, PaywallViewControllerDelegateWrapper {

    private let methodChannel: FlutterMethodChannel

    init(methodChannel: FlutterMethodChannel) {
        self.methodChannel = methodChannel
    }

    func paywallViewController(_ controller: PaywallViewController,
                               didStartPurchaseWith packageDictionary: [String: Any]) {
        methodChannel.invokeMethod("onPurchaseStarted", arguments: packageDictionary)
    }

    func paywallViewController(_ controller: PaywallViewController,
                               didFinishPurchasingWith customerInfoDictionary: [String: Any],
                               transaction transactionDictionary: [String: Any]?) {
        methodChannel.invokeMethod("onPurchaseCompleted", arguments: [
            "customerInfo": customerInfoDictionary,
            "storeTransaction": transactionDictionary
        ])
    }

    func paywallViewControllerDidCancelPurchase(_ controller: PaywallViewController) {
        methodChannel.invokeMethod("onPurchaseCancelled", arguments: nil)
    }

    func paywallViewController(_ controller: PaywallViewController,
                               didFailPurchasingWith errorDictionary: [String: Any]) {
        methodChannel.invokeMethod("onPurchaseError", arguments: errorDictionary)
    }

    func paywallViewController(_ controller: PaywallViewController,
                               didFinishRestoringWith customerInfoDictionary: [String: Any]) {
        methodChannel.invokeMethod("onRestoreCompleted", arguments: customerInfoDictionary)
    }

    func paywallViewController(_ controller: PaywallViewController,
                               didFailRestoringWith errorDictionary: [String: Any]) {
        methodChannel.invokeMethod("onRestoreError", arguments: errorDictionary)
    }

    func paywallViewControllerRequestedDismissal(_ controller: PaywallViewController) {
        methodChannel.invokeMethod("onDismiss", arguments: nil)
    }

    func paywallViewControllerDidOpenWebCheckout(_ controller: PaywallViewController) {
        methodChannel.invokeMethod("onWebCheckoutOpened", arguments: nil)
    }

    func paywallViewController(_ controller: PaywallViewController, didOpenURL url: String) {
        methodChannel.invokeMethod("onUrlOpened", arguments: ["url": url])
    }

    func paywallViewController(_ controller: PaywallViewController,
                               didTrackInteraction eventDictionary: [String: Any]) {
        methodChannel.invokeMethod("onInteraction", arguments: eventDictionary)
    }
}
