package com.revenuecat.purchases.hybridcommon

import com.revenuecat.purchases.Purchases

// region Attribution IDs

fun collectDeviceIdentifiers() {
    Purchases.sharedInstance.collectDeviceIdentifiers()
}

fun setAdjustID(adjustID: String?) {
    Purchases.sharedInstance.setAdjustID(adjustID)
}

fun setAppsflyerID(appsflyerID: String?) {
    Purchases.sharedInstance.setAppsflyerID(appsflyerID)
}

fun setFBAnonymousID(fbAnonymousID: String?) {
    Purchases.sharedInstance.setFBAnonymousID(fbAnonymousID)
}

fun setMparticleID(mparticleID: String?) {
    Purchases.sharedInstance.setMparticleID(mparticleID)
}

fun setCleverTapID(cleverTapID: String?) {
    Purchases.sharedInstance.setCleverTapID(cleverTapID)
}

fun setKochavaDeviceID(kochavaDeviceID: String?) {
    Purchases.sharedInstance.setKochavaDeviceID(kochavaDeviceID)
}

fun setMixpanelDistinctID(mixpanelDistinctID: String?) {
    Purchases.sharedInstance.setMixpanelDistinctID(mixpanelDistinctID)
}

fun setFirebaseAppInstanceID(firebaseAppInstanceID: String?) {
    Purchases.sharedInstance.setFirebaseAppInstanceID(firebaseAppInstanceID)
}

fun setTenjinAnalyticsInstallationID(tenjinAnalyticsInstallationID: String?) {
    Purchases.sharedInstance.setTenjinAnalyticsInstallationID(tenjinAnalyticsInstallationID)
}

fun setOnesignalID(onesignalID: String?) {
    Purchases.sharedInstance.setOnesignalID(onesignalID)
}

fun setOnesignalUserID(onesignalUserID: String?) {
    Purchases.sharedInstance.setOnesignalUserID(onesignalUserID)
}

fun setAirshipChannelID(airshipChannelID: String?) {
    Purchases.sharedInstance.setAirshipChannelID(airshipChannelID)
}

fun setPostHogUserID(postHogUserID: String?) {
    Purchases.sharedInstance.setPostHogUserId(postHogUserID)
}

fun setAirbridgeDeviceID(airbridgeDeviceID: String?) {
    Purchases.sharedInstance.setAirbridgeDeviceID(airbridgeDeviceID)
}

fun setSingularDeviceID(singularDeviceID: String?) {
    Purchases.sharedInstance.setSingularDeviceID(singularDeviceID)
}

// endregion
// region Campaign parameters

fun setMediaSource(mediaSource: String?) {
    Purchases.sharedInstance.setMediaSource(mediaSource)
}

fun setCampaign(campaign: String?) {
    Purchases.sharedInstance.setCampaign(campaign)
}

fun setAdGroup(adGroup: String?) {
    Purchases.sharedInstance.setAdGroup(adGroup)
}

fun setAd(ad: String?) {
    Purchases.sharedInstance.setAd(ad)
}

fun setKeyword(keyword: String?) {
    Purchases.sharedInstance.setKeyword(keyword)
}

fun setCreative(creative: String?) {
    Purchases.sharedInstance.setCreative(creative)
}

fun setAppsFlyerConversionData(data: Map<*, *>?) {
    Purchases.sharedInstance.setAppsFlyerConversionData(data)
}

// endregion
// region subscriber attributes

fun setAttributes(attributes: Map<String, String?>) {
    Purchases.sharedInstance.setAttributes(attributes)
}

fun setEmail(email: String?) {
    Purchases.sharedInstance.setEmail(email)
}

fun setPhoneNumber(phoneNumber: String?) {
    Purchases.sharedInstance.setPhoneNumber(phoneNumber)
}

fun setDisplayName(displayName: String?) {
    Purchases.sharedInstance.setDisplayName(displayName)
}

fun setPushToken(fcmToken: String?) {
    Purchases.sharedInstance.setPushToken(fcmToken)
}

// endregion
