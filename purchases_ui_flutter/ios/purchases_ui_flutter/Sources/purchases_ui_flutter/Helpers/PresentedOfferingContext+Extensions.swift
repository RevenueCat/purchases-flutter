//
//  PresentedOfferingContext+Extensions.swift
//  purchases_ui_flutter
//
//  Created by Antonio Rico Diez on 8/9/25.
//

import RevenueCat

extension PresentedOfferingContext {

    static func createFrom(map: [String: Any]) -> PresentedOfferingContext? {
        if let offeringIdentifier = map["offeringIdentifier"] as? String {
            let placementIdentifier = map["placementIdentifier"] as? String
            var targetingContext: TargetingContext? = nil
            if let targetingContextMap = map["targetingContext"] as? [String: Any],
                let revision = targetingContextMap["revision"] as? Int,
                let ruleId = targetingContextMap["ruleId"] as? String {
                targetingContext = TargetingContext(revision: revision, ruleId: ruleId)
            }
            return PresentedOfferingContext(
                offeringIdentifier: offeringIdentifier,
                placementIdentifier: placementIdentifier,
                targetingContext: targetingContext
            )
        } else {
            return nil
        }
    }
}
