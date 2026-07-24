import Foundation
@_spi(Internal) import RevenueCat

/// Builds DangerousSettings for the Flutter bridge. `useWorkflows` is an internal SPI and is not
/// available to the Objective-C bridge.
@objc public class PurchasesFlutterDangerousSettingsFactory: NSObject {
    @objc public static func make(useWorkflows: Bool) -> DangerousSettings {
        useWorkflows ? DangerousSettings(useWorkflows: true) : DangerousSettings()
    }
}
