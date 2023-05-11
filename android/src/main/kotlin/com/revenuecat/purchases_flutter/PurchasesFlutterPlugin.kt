package com.revenuecat.purchases_flutter

import android.app.Activity
import android.content.Context
import android.os.Handler
import android.os.Looper
import com.revenuecat.purchases.CustomerInfo
import com.revenuecat.purchases.Purchases
import com.revenuecat.purchases.PurchasesErrorCode
import com.revenuecat.purchases.Store
import com.revenuecat.purchases.common.PlatformInfo
import com.revenuecat.purchases.hybridcommon.*
import com.revenuecat.purchases.hybridcommon.mappers.map
import com.revenuecat.purchases.interfaces.UpdatedCustomerInfoListener
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.PluginRegistry.Registrar

/**
 * PurchasesFlutterPlugin
 */
class PurchasesFlutterPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private val INVALID_ARGS_ERROR_CODE = "invalidArgs"

    // Only set registrar for v1 embedder.
    @SuppressWarnings("deprecation")
    private var registrar: Registrar? = null

    // Only set activity for v2 embedder. Always access activity from getActivity() method.
    private var applicationContext: Context? = null
    private var channel: MethodChannel? = null
    private var activity: Activity? = null
    private val handler = Handler(Looper.getMainLooper())
    override fun onAttachedToEngine(binding: FlutterPluginBinding) {
        onAttachedToEngine(binding.binaryMessenger, binding.applicationContext)
    }

    private fun onAttachedToEngine(messenger: BinaryMessenger, applicationContext: Context) {
        channel = MethodChannel(messenger, "purchases_flutter")
        this.applicationContext = applicationContext
        channel!!.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPluginBinding) {
        if (channel != null) {
            channel!!.setMethodCallHandler(null)
        }
        channel = null
        applicationContext = null
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        onAttachedToActivity(binding)
    }

    override fun onDetachedFromActivity() {
        activity = null
    }

    override fun onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity()
    }

    private fun getActivity(): Activity? {
        return if (registrar != null) registrar!!.activity() else activity
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            Constants.MethodNameConstants.setupPurchases -> {
                val apiKey = call.argument<String>(Constants.MethodArgsNameConstants.apiKey)
                val appUserId = call.argument<String>(Constants.MethodArgsNameConstants.appUserId)
                val observerMode = call.argument<Boolean>(Constants.MethodArgsNameConstants.observerMode)
                val useAmazon = call.argument<Boolean>(Constants.MethodArgsNameConstants.useAmazon)
                val userDefaultsSuiteName =
                    call.argument<String>(Constants.MethodArgsNameConstants.userDefaultsSuiteName) // iOS-only, unused.
                val usesStoreKit2IfAvailable =
                    call.argument<Boolean>(Constants.MethodArgsNameConstants.usesStoreKit2IfAvailable) // iOS-only, unused.
                setupPurchases(apiKey, appUserId, observerMode, useAmazon, result)
            }
            Constants.MethodNameConstants.setFinishTransactions -> {
                val finishTransactions = call.argument<Boolean>(Constants.MethodArgsNameConstants.finishTransactions)
                setFinishTransactions(finishTransactions, result)
            }
            Constants.MethodNameConstants.setAllowSharingStoreAccount -> {
                val allowSharing = call.argument<Boolean>(Constants.MethodArgsNameConstants.allowSharing)
                setAllowSharingAppStoreAccount(allowSharing, result)
            }
            Constants.MethodNameConstants.getOfferings -> getOfferings(result)
            Constants.MethodNameConstants.getProductInfo -> {
                val productIdentifiers = call.argument<ArrayList<String>>(Constants.MethodArgsNameConstants.productIdentifiers)!!
                val type = call.argument<String>(Constants.MethodArgsNameConstants.type)
                getProductInfo(productIdentifiers, type, result)
            }
            Constants.MethodNameConstants.purchaseProduct -> {
                val productIdentifier = call.argument<String>(Constants.MethodArgsNameConstants.productIdentifier)
                val oldSKU = call.argument<String>(Constants.MethodArgsNameConstants.oldSKU)
                val prorationMode = call.argument<Int>(Constants.MethodArgsNameConstants.prorationMode)
                val type = call.argument<String>(Constants.MethodArgsNameConstants.type)
                purchaseProduct(productIdentifier, oldSKU, prorationMode, type!!, result)
            }
            Constants.MethodNameConstants.purchasePackage -> {
                val packageIdentifier = call.argument<String>(Constants.MethodArgsNameConstants.packageIdentifier)
                val offeringIdentifier = call.argument<String>(Constants.MethodArgsNameConstants.offeringIdentifier)
                val oldSKU = call.argument<String>(Constants.MethodArgsNameConstants.oldSKU)
                val prorationMode = call.argument<Int>(Constants.MethodArgsNameConstants.prorationMode)
                purchasePackage(
                    packageIdentifier,
                    offeringIdentifier,
                    oldSKU,
                    prorationMode,
                    result
                )
            }
            Constants.MethodNameConstants.getAppUserID -> getAppUserID(result)
            Constants.MethodNameConstants.restorePurchases -> restorePurchases(result)
            Constants.MethodNameConstants.logIn -> {
                val appUserIDToLogIn = call.argument<String>(Constants.MethodArgsNameConstants.appUserID)
                logIn(appUserIDToLogIn, result)
            }
            Constants.MethodNameConstants.logOut -> logOut(result)
            Constants.MethodNameConstants.setDebugLogsEnabled -> {
                val enabled =
                    call.argument<Any?>(Constants.MethodArgsNameConstants.enabled) != null && call.argument<Any>(Constants.MethodArgsNameConstants.enabled) as Boolean
                setDebugLogsEnabled(enabled, result)
            }
            Constants.MethodNameConstants.setLogLevel -> {
                val level = call.argument<Any>(Constants.MethodArgsNameConstants.level) as String?
                setLogLevel(level, result)
            }
            Constants.MethodNameConstants.setProxyURLString -> {
                val proxyURLString = call.argument<String>(Constants.MethodArgsNameConstants.proxyURLString)
                setProxyURLString(proxyURLString, result)
            }
            Constants.MethodNameConstants.getCustomerInfo -> getCustomerInfo(result)
            Constants.MethodNameConstants.syncPurchases -> syncPurchases(result)
            Constants.MethodNameConstants.setAutomaticAppleSearchAdsAttributionCollection ->                 // NOOP
                result.success(null)
            Constants.MethodNameConstants.enableAdServicesAttributionTokenCollection ->                 // NOOP
                result.success(null)
            Constants.MethodNameConstants.isAnonymous -> isAnonymous(result)
            Constants.MethodNameConstants.isConfigured -> isConfigured(result)
            Constants.MethodNameConstants.checkTrialOrIntroductoryPriceEligibility -> {
                val productIdentifiers = call.argument<ArrayList<String>>(Constants.MethodArgsNameConstants.productIdentifiers)
                checkTrialOrIntroductoryPriceEligibility(productIdentifiers!!, result)
            }
            Constants.MethodNameConstants.invalidateCustomerInfoCache -> invalidateCustomerInfoCache(result)
            Constants.MethodNameConstants.getPromotionalOffer,
            Constants.MethodNameConstants.presentCodeRedemptionSheet,
            Constants.MethodNameConstants.setSimulatesAskToBuyInSandbox,
            Constants.MethodNameConstants.beginRefundRequestForActiveEntitlement,
            Constants.MethodNameConstants.beginRefundRequestForProduct,
            Constants.MethodNameConstants.beginRefundRequestForEntitlement ->                 // NOOP
                result.success(null)
            Constants.MethodNameConstants.setAttributes -> {
                val attributes = call.argument<Map<String, String?>>(Constants.MethodArgsNameConstants.attributes)!!
                setAttributes(attributes, result)
            }
            Constants.MethodNameConstants.setEmail -> {
                val email = call.argument<String>(Constants.MethodArgsNameConstants.email)
                setEmail(email, result)
            }
            Constants.MethodNameConstants.setPhoneNumber -> {
                val phoneNumber = call.argument<String>(Constants.MethodArgsNameConstants.phoneNumber)
                setPhoneNumber(phoneNumber, result)
            }
            Constants.MethodNameConstants.setDisplayName -> {
                val displayName = call.argument<String>(Constants.MethodArgsNameConstants.displayName)
                setDisplayName(displayName, result)
            }
            Constants.MethodNameConstants.setPushToken -> {
                val pushToken = call.argument<String>(Constants.MethodArgsNameConstants.pushToken)
                setPushToken(pushToken, result)
            }
            Constants.MethodNameConstants.setAdjustID -> {
                val adjustID = call.argument<String>(Constants.MethodArgsNameConstants.adjustID)
                setAdjustID(adjustID, result)
            }
            Constants.MethodNameConstants.setAppsflyerID -> {
                val appsflyerID = call.argument<String>(Constants.MethodArgsNameConstants.appsflyerID)
                setAppsflyerID(appsflyerID, result)
            }
            Constants.MethodNameConstants.setFBAnonymousID -> {
                val fbAnonymousID = call.argument<String>(Constants.MethodArgsNameConstants.fbAnonymousID)
                setFBAnonymousID(fbAnonymousID, result)
            }
            Constants.MethodNameConstants.setMparticleID -> {
                val mparticleID = call.argument<String>(Constants.MethodArgsNameConstants.mparticleID)
                setMparticleID(mparticleID, result)
            }
            Constants.MethodNameConstants.setCleverTapID -> {
                val cleverTapID = call.argument<String>(Constants.MethodArgsNameConstants.cleverTapID)
                setCleverTapID(cleverTapID, result)
            }
            Constants.MethodNameConstants.setMixpanelDistinctID -> {
                val mixpanelDistinctID = call.argument<String>(Constants.MethodArgsNameConstants.mixpanelDistinctID)
                setMixpanelDistinctID(mixpanelDistinctID, result)
            }
            Constants.MethodNameConstants.setFirebaseAppInstanceID -> {
                val firebaseAppInstanceID = call.argument<String>(Constants.MethodArgsNameConstants.firebaseAppInstanceID)
                setFirebaseAppInstanceID(firebaseAppInstanceID, result)
            }
            Constants.MethodNameConstants.setOnesignalID -> {
                val onesignalID = call.argument<String>(Constants.MethodArgsNameConstants.onesignalID)
                setOnesignalID(onesignalID, result)
            }
            Constants.MethodNameConstants.setAirshipChannelID -> {
                val airshipChannelID = call.argument<String>(Constants.MethodArgsNameConstants.airshipChannelID)
                setAirshipChannelID(airshipChannelID, result)
            }
            Constants.MethodNameConstants.setMediaSource -> {
                val mediaSource = call.argument<String>(Constants.MethodArgsNameConstants.mediaSource)
                setMediaSource(mediaSource, result)
            }
            Constants.MethodNameConstants.setCampaign -> {
                val campaign = call.argument<String>(Constants.MethodArgsNameConstants.campaign)
                setCampaign(campaign, result)
            }
            Constants.MethodNameConstants.setAdGroup -> {
                val adGroup = call.argument<String>(Constants.MethodArgsNameConstants.adGroup)
                setAdGroup(adGroup, result)
            }
            Constants.MethodNameConstants.setAd -> {
                val ad = call.argument<String>(Constants.MethodArgsNameConstants.ad)
                setAd(ad, result)
            }
            Constants.MethodNameConstants.setKeyword -> {
                val keyword = call.argument<String>(Constants.MethodArgsNameConstants.keyword)
                setKeyword(keyword, result)
            }
            Constants.MethodNameConstants.setCreative -> {
                val creative = call.argument<String>(Constants.MethodArgsNameConstants.creative)
                setCreative(creative, result)
            }
            Constants.MethodNameConstants.collectDeviceIdentifiers -> collectDeviceIdentifiers(result)
            Constants.MethodNameConstants.canMakePayments -> {
                val features = call.argument<List<Int>>(Constants.MethodArgsNameConstants.features)!!
                canMakePayments(features, result)
            }
            Constants.MethodNameConstants.close -> close(result)
            Constants.MethodNameConstants.setLogHandler -> setLogHandler(result)
            Constants.MethodNameConstants.syncObserverModeAmazonPurchase -> {
                val productID = call.argument<String>(Constants.MethodArgsNameConstants.productID)
                val receiptID = call.argument<String>(Constants.MethodArgsNameConstants.receiptID)
                val amazonUserID = call.argument<String>(Constants.MethodArgsNameConstants.amazonUserID)
                val isoCurrencyCode = call.argument<String>(Constants.MethodArgsNameConstants.isoCurrencyCode)
                val price = call.argument<Double>(Constants.MethodArgsNameConstants.price)
                syncObserverModeAmazonPurchase(
                    productID, receiptID, amazonUserID, isoCurrencyCode,
                    price, result
                )
            }
            else -> result.notImplemented()
        }
    }

    private fun setupPurchases(
        apiKey: String?, appUserID: String?, observerMode: Boolean?,
        useAmazon: Boolean?, result: MethodChannel.Result
    ) {
        if (applicationContext != null) {
            val platformInfo = PlatformInfo(PLATFORM_NAME, PLUGIN_VERSION)
            var store = Store.PLAY_STORE
            if (useAmazon != null && useAmazon) {
                store = Store.AMAZON
            }
            configure(
                applicationContext!!, apiKey!!, appUserID, observerMode,
                platformInfo, store
            )
            setUpdatedCustomerInfoListener()
            result.success(null)
        } else {
            result.error(
                PurchasesErrorCode.UnknownError.code.toString(),
                "Purchases can't be setup. There is no Application context",
                null
            )
        }
    }

    private fun setUpdatedCustomerInfoListener() {
        Purchases.sharedInstance.updatedCustomerInfoListener =
            UpdatedCustomerInfoListener { customerInfo: CustomerInfo ->
                val customerInfoMap = customerInfo.map()
                invokeChannelMethodOnUiThread(CUSTOMER_INFO_UPDATED, customerInfoMap)
            }
    }

    private fun setFinishTransactions(finishTransactions: Boolean?, result: MethodChannel.Result) {
        if (finishTransactions != null) {
            setFinishTransactions(finishTransactions)
            result.success(null)
        } else {
            result.error(
                INVALID_ARGS_ERROR_CODE,
                "Missing finishTransactions argument",
                null
            )
        }
    }

    @SuppressWarnings("deprecation")
    private fun setAllowSharingAppStoreAccount(
        allowSharingAppStoreAccount: Boolean?,
        result: MethodChannel.Result
    ) {
        if (allowSharingAppStoreAccount != null) {
            setAllowSharingAppStoreAccount(allowSharingAppStoreAccount)
            result.success(null)
        } else {
            result.error(
                INVALID_ARGS_ERROR_CODE,
                "Missing allowSharing argument",
                null
            )
        }
    }

    private fun getOfferings(result: MethodChannel.Result) {
        getOfferings(getOnResult(result))
    }

    private fun getProductInfo(
        productIDs: ArrayList<String>,
        type: String?,
        result: MethodChannel.Result
    ) {
        getProductInfo(productIDs, type!!, object : OnResultList {
            override fun onReceived(map: List<Map<String?, *>?>?) {
                result.success(map)
            }

            override fun onError(errorContainer: ErrorContainer) {
                reject(errorContainer, result)
            }
        })
    }

    private fun purchaseProduct(
        productIdentifier: String?, oldSKU: String?,
        prorationMode: Int?, type: String,
        result: MethodChannel.Result
    ) {
        purchaseProduct(
            getActivity(),
            productIdentifier!!,
            oldSKU,
            prorationMode,
            type,
            getOnResult(result)
        )
    }

    private fun purchasePackage(
        packageIdentifier: String?,
        offeringIdentifier: String?,
        oldSKU: String?,
        prorationMode: Int?,
        result: MethodChannel.Result
    ) {
        purchasePackage(
            getActivity(),
            packageIdentifier!!,
            offeringIdentifier!!,
            oldSKU,
            prorationMode,
            getOnResult(result)
        )
    }

    private fun getAppUserID(result: MethodChannel.Result) {
        result.success(getAppUserID())
    }

    private fun restorePurchases(result: MethodChannel.Result) {
        restorePurchases(getOnResult(result))
    }

    private fun logOut(result: MethodChannel.Result) {
        logOut(getOnResult(result))
    }

    private fun logIn(appUserID: String?, result: MethodChannel.Result) {
        logIn(appUserID!!, getOnResult(result))
    }

    private fun setDebugLogsEnabled(enabled: Boolean, result: MethodChannel.Result) {
        setDebugLogsEnabled(enabled)
        result.success(null)
    }

    private fun syncObserverModeAmazonPurchase(
        productID: String?,
        receiptID: String?,
        amazonUserID: String?,
        isoCurrencyCode: String?,
        price: Double?,
        result: MethodChannel.Result
    ) {
        Purchases.sharedInstance.syncObserverModeAmazonPurchase(
            productID ?: "", receiptID ?: "",
            amazonUserID ?: "", isoCurrencyCode, price
        )
        result.success(null)
    }

    private fun setLogLevel(level: String?, result: MethodChannel.Result) {
        setLogLevel(level!!)
        result.success(null)
    }

    private fun setProxyURLString(proxyURLString: String?, result: MethodChannel.Result) {
        setProxyURLString(proxyURLString)
        result.success(null)
    }

    private fun getCustomerInfo(result: MethodChannel.Result) {
        getCustomerInfo(getOnResult(result))
    }

    private fun syncPurchases(result: MethodChannel.Result) {
        syncPurchases()
        result.success(null)
    }

    private fun isAnonymous(result: MethodChannel.Result) {
        result.success(isAnonymous())
    }

    private fun isConfigured(result: MethodChannel.Result) {
        result.success(Purchases.isConfigured)
    }

    private fun checkTrialOrIntroductoryPriceEligibility(
        productIDs: ArrayList<String>,
        result: MethodChannel.Result
    ) {
        result.success(checkTrialOrIntroductoryPriceEligibility(productIDs))
    }

    private fun invalidateCustomerInfoCache(result: MethodChannel.Result) {
        invalidateCustomerInfoCache()
        result.success(null)
    }

    //================================================================================
    // Subscriber Attributes
    //================================================================================
    private fun setAttributes(map: Map<String, String?>, result: MethodChannel.Result) {
        setAttributes(map)
        result.success(null)
    }

    private fun setEmail(email: String?, result: MethodChannel.Result) {
        setEmail(email)
        result.success(null)
    }

    private fun setPhoneNumber(phoneNumber: String?, result: MethodChannel.Result) {
        setPhoneNumber(phoneNumber)
        result.success(null)
    }

    private fun setDisplayName(displayName: String?, result: MethodChannel.Result) {
        setDisplayName(displayName)
        result.success(null)
    }

    private fun setPushToken(pushToken: String?, result: MethodChannel.Result) {
        setPushToken(pushToken)
        result.success(null)
    }

    private fun setAdjustID(adjustID: String?, result: MethodChannel.Result) {
        setAdjustID(adjustID)
        result.success(null)
    }

    private fun setAppsflyerID(appsflyerID: String?, result: MethodChannel.Result) {
        setAppsflyerID(appsflyerID)
        result.success(null)
    }

    private fun setFBAnonymousID(fbAnonymousID: String?, result: MethodChannel.Result) {
        setFBAnonymousID(fbAnonymousID)
        result.success(null)
    }

    private fun setMparticleID(mparticleID: String?, result: MethodChannel.Result) {
        setMparticleID(mparticleID)
        result.success(null)
    }

    private fun setCleverTapID(cleverTapID: String?, result: MethodChannel.Result) {
        setCleverTapID(cleverTapID)
        result.success(null)
    }

    private fun setMixpanelDistinctID(mixpanelDistinctID: String?, result: MethodChannel.Result) {
        setMixpanelDistinctID(mixpanelDistinctID)
        result.success(null)
    }

    private fun setFirebaseAppInstanceID(
        firebaseAppInstanceId: String?,
        result: MethodChannel.Result
    ) {
        setFirebaseAppInstanceID(firebaseAppInstanceId)
        result.success(null)
    }

    private fun setOnesignalID(onesignalID: String?, result: MethodChannel.Result) {
        setOnesignalID(onesignalID)
        result.success(null)
    }

    private fun setAirshipChannelID(airshipChannelID: String?, result: MethodChannel.Result) {
        setAirshipChannelID(airshipChannelID)
        result.success(null)
    }

    private fun setMediaSource(mediaSource: String?, result: MethodChannel.Result) {
        setMediaSource(mediaSource)
        result.success(null)
    }

    private fun setCampaign(campaign: String?, result: MethodChannel.Result) {
        setCampaign(campaign)
        result.success(null)
    }

    private fun setAdGroup(adGroup: String?, result: MethodChannel.Result) {
        setAdGroup(adGroup)
        result.success(null)
    }

    private fun setAd(ad: String?, result: MethodChannel.Result) {
        setAd(ad)
        result.success(null)
    }

    private fun setKeyword(keyword: String?, result: MethodChannel.Result) {
        setKeyword(keyword)
        result.success(null)
    }

    private fun setCreative(creative: String?, result: MethodChannel.Result) {
        setCreative(creative)
        result.success(null)
    }

    private fun collectDeviceIdentifiers(result: MethodChannel.Result) {
        collectDeviceIdentifiers()
        result.success(null)
    }

    private fun canMakePayments(features: List<Int>, resultMethodChannel: MethodChannel.Result) {
        canMakePayments(
            applicationContext!!,
            features,
            object : OnResultAny<Boolean> {
                override fun onError(errorContainer: ErrorContainer?) {
                    reject(errorContainer, resultMethodChannel)
                }

                override fun onReceived(result: Boolean) {
                    resultMethodChannel.success(result)
                }
            })
    }

    private fun close(result: MethodChannel.Result) {
        try {
            Purchases.sharedInstance.close()
        } catch (e: UninitializedPropertyAccessException) {
            // there's no instance so all good
        }
        result.success(null)
    }

    private fun setLogHandler(result: MethodChannel.Result) {
        setLogHandler {logDetails ->
            invokeChannelMethodOnUiThread(LOG_HANDLER_EVENT, logDetails)
        }
        result.success(null)
    }

    private fun runOnUiThread(runnable: Runnable) {
        handler.post(runnable)
    }

    private fun getOnResult(result: MethodChannel.Result): OnResult {
        return object : OnResult {
            override fun onReceived(map: MutableMap<String, *>) {
                result.success(map)
            }

            override fun onError(errorContainer: ErrorContainer) {
                reject(errorContainer, result)
            }
        }
    }

    private fun reject(errorContainer: ErrorContainer?, result: MethodChannel.Result) {
        result.error(errorContainer!!.code.toString(), errorContainer.message, errorContainer.info)
    }

    private fun invokeChannelMethodOnUiThread(method: String, argumentsMap: Any) {
        runOnUiThread {
            if (channel != null) {
                channel!!.invokeMethod(method, argumentsMap)
            }
        }
    }

    companion object {
        private const val CUSTOMER_INFO_UPDATED = "Purchases-CustomerInfoUpdated"
        protected const val LOG_HANDLER_EVENT = "Purchases-LogHandlerEvent"
        private const val PLATFORM_NAME = "flutter"
        private const val PLUGIN_VERSION = "4.13.0-SNAPSHOT"

        /**
         * Plugin registration.
         */
        @Suppress("DEPRECATION", "unused")
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val instance = PurchasesFlutterPlugin()
            instance.onAttachedToEngine(registrar.messenger(), registrar.context())
            instance.registrar = registrar
            registrar.addViewDestroyListener {
                try {
                    Purchases.sharedInstance.close()
                } catch (e: UninitializedPropertyAccessException) {
                    // there's no instance so all good
                }
                false
            }
        }
    }
}