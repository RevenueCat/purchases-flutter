package com.revenuecat.purchases_flutter;

import android.app.Activity;
import android.content.Context;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.revenuecat.purchases.DangerousSettings;
import com.revenuecat.purchases.Purchases;
import com.revenuecat.purchases.PurchasesErrorCode;
import com.revenuecat.purchases.Store;
import com.revenuecat.purchases.common.PlatformInfo;
import com.revenuecat.purchases.hybridcommon.CommonKt;
import com.revenuecat.purchases.hybridcommon.ErrorContainer;
import com.revenuecat.purchases.hybridcommon.OnNullableResult;
import com.revenuecat.purchases.hybridcommon.OnResult;
import com.revenuecat.purchases.hybridcommon.OnResultAny;
import com.revenuecat.purchases.hybridcommon.OnResultList;
import com.revenuecat.purchases.hybridcommon.SubscriberAttributesKt;
import com.revenuecat.purchases.hybridcommon.mappers.CustomerInfoMapperKt;
import com.revenuecat.purchases.models.InAppMessageType;

import org.jetbrains.annotations.NotNull;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import kotlin.UninitializedPropertyAccessException;
import kotlin.Unit;
import kotlin.jvm.functions.Function1;

/**
 * PurchasesFlutterPlugin
 */
public class PurchasesFlutterPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
    private static final String TAG = "PurchasesFlutter";
    private static final String INVALID_ARGS_ERROR_CODE = "invalidArgs";

    private static final String CUSTOMER_INFO_UPDATED = "Purchases-CustomerInfoUpdated";
    protected static final String LOG_HANDLER_EVENT = "Purchases-LogHandlerEvent";

    @Nullable
    private Context applicationContext;
    @Nullable
    private MethodChannel channel;
    @Nullable
    private Activity activity;

    private final Handler handler = new Handler(Looper.getMainLooper());

    private static final String PLATFORM_NAME = "flutter";
    private static final String PLUGIN_VERSION = "8.11.0";

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        onAttachedToEngine(binding.getBinaryMessenger(), binding.getApplicationContext());
    }

    private void onAttachedToEngine(BinaryMessenger messenger, Context applicationContext) {
        this.channel = new MethodChannel(messenger, "purchases_flutter");
        this.applicationContext = applicationContext;
        this.channel.setMethodCallHandler(this);
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        if (channel != null) {
            channel.setMethodCallHandler(null);
        }
        this.channel = null;
        this.applicationContext = null;
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        this.activity = binding.getActivity();
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        onAttachedToActivity(binding);
    }

    @Override
    public void onDetachedFromActivity() {
        this.activity = null;
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity();
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        switch (call.method) {
            case "setupPurchases":
                String apiKey = call.argument("apiKey");
                String appUserId = call.argument("appUserId");
                String purchasesAreCompletedBy = call.argument("purchasesAreCompletedBy");
                Boolean useAmazon = call.argument("useAmazon");
                // noinspection unused
                String userDefaultsSuiteName = call.argument("userDefaultsSuiteName"); // iOS-only, unused.
                // noinspection unused
                String storeKitVersion = call.argument("storeKitVersion"); // iOS-only, unused.
                Boolean shouldShowInAppMessagesAutomatically = call.argument("shouldShowInAppMessagesAutomatically");
                String verificationMode = call.argument("entitlementVerificationMode");
                Boolean pendingTransactionsForPrepaidPlansEnabled = call
                        .argument("pendingTransactionsForPrepaidPlansEnabled");
                setupPurchases(apiKey, appUserId, purchasesAreCompletedBy, useAmazon,
                        shouldShowInAppMessagesAutomatically, verificationMode,
                        pendingTransactionsForPrepaidPlansEnabled, result);
                break;
            case "setAllowSharingStoreAccount":
                Boolean allowSharing = call.argument("allowSharing");
                setAllowSharingAppStoreAccount(allowSharing, result);
                break;
            case "getOfferings":
                getOfferings(result);
                break;
            case "getCurrentOfferingForPlacement":
                String placementIdentifier = call.argument("placementIdentifier");
                getCurrentOfferingForPlacement(placementIdentifier, result);
                break;
            case "syncAttributesAndOfferingsIfNeeded":
                syncAttributesAndOfferingsIfNeeded(result);
                break;
            case "getProductInfo":
                ArrayList<String> productIdentifiers = call.argument("productIdentifiers");
                String type = call.argument("type");
                getProductInfo(productIdentifiers, type, result);
                break;
            case "purchaseProduct":
                String productIdentifier = call.argument("productIdentifier");
                String googleOldProductIdentifer = call.argument("googleOldProductIdentifier");
                Integer googleProrationMode = call.argument("googleProrationMode");
                Boolean googleIsPersonalizedPrice = call.argument("googleIsPersonalizedPrice");
                type = call.argument("type");
                Map<String, Object> presentedOfferingContext = call.argument("presentedOfferingContext");
                purchaseProduct(productIdentifier, type, googleOldProductIdentifer, googleProrationMode,
                        googleIsPersonalizedPrice, presentedOfferingContext, result);
                break;
            case "purchasePackage":
                String packageIdentifier = call.argument("packageIdentifier");
                presentedOfferingContext = call.argument("presentedOfferingContext");
                googleOldProductIdentifer = call.argument("googleOldProductIdentifier");
                googleProrationMode = call.argument("googleProrationMode");
                googleIsPersonalizedPrice = call.argument("googleIsPersonalizedPrice");
                purchasePackage(packageIdentifier, presentedOfferingContext, googleOldProductIdentifer,
                        googleProrationMode, googleIsPersonalizedPrice, result);
                break;
            case "purchaseSubscriptionOption":
                productIdentifier = call.argument("productIdentifier");
                String optionIdentifier = call.argument("optionIdentifier");
                googleOldProductIdentifer = call.argument("googleOldProductIdentifier");
                googleProrationMode = call.argument("googleProrationMode");
                googleIsPersonalizedPrice = call.argument("googleIsPersonalizedPrice");
                presentedOfferingContext = call.argument("presentedOfferingContext");
                purchaseSubscriptionOption(productIdentifier, optionIdentifier, googleOldProductIdentifer,
                        googleProrationMode, googleIsPersonalizedPrice, presentedOfferingContext, result);
                break;
            case "getAppUserID":
                getAppUserID(result);
                break;
            case "getStorefront":
                getStorefront(result);
                break;
            case "restorePurchases":
                restorePurchases(result);
                break;
            case "logIn":
                String appUserIDToLogIn = call.argument("appUserID");
                logIn(appUserIDToLogIn, result);
                break;
            case "logOut":
                logOut(result);
                break;
            case "setDebugLogsEnabled":
                boolean enabled = call.argument("enabled") != null && (boolean) call.argument("enabled");
                setDebugLogsEnabled(enabled, result);
                break;
            case "setLogLevel":
                String level = call.argument("level");
                setLogLevel(level, result);
                break;
            case "setProxyURLString":
                String proxyURLString = call.argument("proxyURLString");
                setProxyURLString(proxyURLString, result);
                break;
            case "getCustomerInfo":
                getCustomerInfo(result);
                break;
            case "syncPurchases":
                syncPurchases(result);
                break;
            case "isAnonymous":
                isAnonymous(result);
                break;
            case "isConfigured":
                isConfigured(result);
                break;
            case "checkTrialOrIntroductoryPriceEligibility":
                productIdentifiers = call.argument("productIdentifiers");
                checkTrialOrIntroductoryPriceEligibility(productIdentifiers, result);
                break;
            case "invalidateCustomerInfoCache":
                invalidateCustomerInfoCache(result);
                break;
            case "getPromotionalOffer":
            case "presentCodeRedemptionSheet":
            case "setSimulatesAskToBuyInSandbox":
            case "beginRefundRequestForActiveEntitlement":
            case "beginRefundRequestForProduct":
            case "beginRefundRequestForEntitlement":
            case "recordPurchaseForProductID":
            case "enableAdServicesAttributionTokenCollection":
            case "eligibleWinBackOffersForProduct":
            case "purchaseProductWithWinBackOffer":
            case "purchasePackageWithWinBackOffer":
                // NOOP
                result.success(null);
                break;
            case "setAttributes":
                Map<String, String> attributes = call.argument("attributes");
                setAttributes(attributes, result);
                break;
            case "setEmail":
                String email = call.argument("email");
                setEmail(email, result);
                break;
            case "setPhoneNumber":
                String phoneNumber = call.argument("phoneNumber");
                setPhoneNumber(phoneNumber, result);
                break;
            case "setDisplayName":
                String displayName = call.argument("displayName");
                setDisplayName(displayName, result);
                break;
            case "setPushToken":
                String pushToken = call.argument("pushToken");
                setPushToken(pushToken, result);
                break;
            case "setAdjustID":
                String adjustID = call.argument("adjustID");
                setAdjustID(adjustID, result);
                break;
            case "setAppsflyerID":
                String appsflyerID = call.argument("appsflyerID");
                setAppsflyerID(appsflyerID, result);
                break;
            case "setFBAnonymousID":
                String fbAnonymousID = call.argument("fbAnonymousID");
                setFBAnonymousID(fbAnonymousID, result);
                break;
            case "setMparticleID":
                String mparticleID = call.argument("mparticleID");
                setMparticleID(mparticleID, result);
                break;
            case "setCleverTapID":
                String cleverTapID = call.argument("cleverTapID");
                setCleverTapID(cleverTapID, result);
                break;
            case "setMixpanelDistinctID":
                String mixpanelDistinctID = call.argument("mixpanelDistinctID");
                setMixpanelDistinctID(mixpanelDistinctID, result);
                break;
            case "setFirebaseAppInstanceID":
                String firebaseAppInstanceID = call.argument("firebaseAppInstanceID");
                setFirebaseAppInstanceID(firebaseAppInstanceID, result);
                break;
            case "setTenjinAnalyticsInstallationID":
                String tenjinAnalyticsInstallationID = call.argument("tenjinAnalyticsInstallationID");
                setTenjinAnalyticsInstallationID(tenjinAnalyticsInstallationID, result);
                break;
            case "setOnesignalID":
                String onesignalID = call.argument("onesignalID");
                setOnesignalID(onesignalID, result);
                break;
            case "setAirshipChannelID":
                String airshipChannelID = call.argument("airshipChannelID");
                setAirshipChannelID(airshipChannelID, result);
                break;
            case "setMediaSource":
                String mediaSource = call.argument("mediaSource");
                setMediaSource(mediaSource, result);
                break;
            case "setCampaign":
                String campaign = call.argument("campaign");
                setCampaign(campaign, result);
                break;
            case "setAdGroup":
                String adGroup = call.argument("adGroup");
                setAdGroup(adGroup, result);
                break;
            case "setAd":
                String ad = call.argument("ad");
                setAd(ad, result);
                break;
            case "setKeyword":
                String keyword = call.argument("keyword");
                setKeyword(keyword, result);
                break;
            case "setCreative":
                String creative = call.argument("creative");
                setCreative(creative, result);
                break;
            case "collectDeviceIdentifiers":
                collectDeviceIdentifiers(result);
                break;
            case "canMakePayments":
                List<Integer> features = call.argument("features");
                canMakePayments(features, result);
                break;
            case "close":
                close(result);
                break;
            case "setLogHandler":
                setLogHandler(result);
                break;
            case "showInAppMessages":
                ArrayList<Integer> types = call.argument("types");
                showInAppMessages(types, result);
                break;
            case "syncAmazonPurchase":
                String productID = call.argument("productID");
                String receiptID = call.argument("receiptID");
                String amazonUserID = call.argument("amazonUserID");
                String isoCurrencyCode = call.argument("isoCurrencyCode");
                Double price = call.argument("price");
                syncAmazonPurchase(productID, receiptID, amazonUserID, isoCurrencyCode,
                        price, result);
                break;
            case "isWebPurchaseRedemptionURL":
                String urlString = call.argument("urlString");
                isWebPurchaseRedemptionURL(urlString, result);
                break;
            case "redeemWebPurchase":
                String redemptionLink = call.argument("redemptionLink");
                redeemWebPurchase(redemptionLink, result);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void setupPurchases(String apiKey, String appUserID,
            @Nullable String purchasesAreCompletedBy, @Nullable Boolean useAmazon,
            @Nullable Boolean shouldShowInAppMessagesAutomatically, @Nullable String verificationMode,
            @Nullable Boolean pendingTransactionsForPrepaidPlansEnabled,
            final Result result) {
        if (this.applicationContext != null) {
            PlatformInfo platformInfo = new PlatformInfo(PLATFORM_NAME, PLUGIN_VERSION);
            Store store = Store.PLAY_STORE;
            if (useAmazon != null && useAmazon) {
                store = Store.AMAZON;
            }

            CommonKt.configure(this.applicationContext,
                    apiKey,
                    appUserID,
                    purchasesAreCompletedBy,
                    platformInfo,
                    store,
                    new DangerousSettings(),
                    shouldShowInAppMessagesAutomatically,
                    verificationMode,
                    pendingTransactionsForPrepaidPlansEnabled);
            setUpdatedCustomerInfoListener();
            result.success(null);
        } else {
            result.error(
                    String.valueOf(PurchasesErrorCode.UnknownError.getCode()),
                    "Purchases can't be setup. There is no Application context",
                    null);
        }
    }

    private void setUpdatedCustomerInfoListener() {
        Purchases.getSharedInstance().setUpdatedCustomerInfoListener(customerInfo -> {
            CustomerInfoMapperKt.mapAsync(
                    customerInfo,
                    map -> {
                        invokeChannelMethodOnUiThread(CUSTOMER_INFO_UPDATED, map);
                        return Unit.INSTANCE;
                    }
            );
        });
    }

    @SuppressWarnings("deprecation")
    private void setAllowSharingAppStoreAccount(@Nullable Boolean allowSharingAppStoreAccount, Result result) {
        if (allowSharingAppStoreAccount != null) {
            CommonKt.setAllowSharingAppStoreAccount(allowSharingAppStoreAccount);
            result.success(null);
        } else {
            result.error(
                    INVALID_ARGS_ERROR_CODE,
                    "Missing allowSharing argument",
                    null);
        }
    }

    private void getOfferings(final Result result) {
        CommonKt.getOfferings(getOnResult(result));
    }

    private void getCurrentOfferingForPlacement(String placementIdentifier, final Result result) {
        CommonKt.getCurrentOfferingForPlacement(placementIdentifier, getOnNullableResult(result));
    }

    private void syncAttributesAndOfferingsIfNeeded(final Result result) {
        CommonKt.syncAttributesAndOfferingsIfNeeded(getOnResult(result));
    }

    private void getProductInfo(ArrayList<String> productIDs, String type, final Result result) {
        CommonKt.getProductInfo(productIDs, type, new OnResultList() {
            @Override
            public void onReceived(List<Map<String, ?>> map) {
                result.success(map);
            }

            @Override
            public void onError(ErrorContainer errorContainer) {
                reject(errorContainer, result);
            }
        });
    }

    private void purchaseProduct(final String productIdentifier,
            final String type,
            final String googleOldProductId,
            @Nullable final Integer googleProrationMode,
            @Nullable final Boolean googleIsPersonalizedPrice,
            @Nullable final Map<String, Object> presentedOfferingContext,
            final Result result) {
        CommonKt.purchaseProduct(
                activity,
                productIdentifier,
                type,
                null,
                googleOldProductId,
                googleProrationMode,
                googleIsPersonalizedPrice,
                presentedOfferingContext,
                getOnResult(result));
    }

    private void purchasePackage(final String packageIdentifier,
            final Map<String, Object> presentedOfferingContext,
            final String googleOldProductId,
            @Nullable final Integer googleProrationMode,
            @Nullable final Boolean googleIsPersonalizedPrice,
            final Result result) {
        CommonKt.purchasePackage(
                activity,
                packageIdentifier,
                presentedOfferingContext,
                googleOldProductId,
                googleProrationMode,
                googleIsPersonalizedPrice,
                getOnResult(result));
    }

    private void purchaseSubscriptionOption(final String productIdentifier,
            final String optionIdentifier,
            final String googleOldProductId,
            @Nullable final Integer googleProrationMode,
            @Nullable final Boolean googleIsPersonalizedPrice,
            @Nullable final Map<String, Object> presentedOfferingContext,
            final Result result) {
        CommonKt.purchaseSubscriptionOption(
                activity,
                productIdentifier,
                optionIdentifier,
                googleOldProductId,
                googleProrationMode,
                googleIsPersonalizedPrice,
                presentedOfferingContext,
                getOnResult(result));
    }

    private void getAppUserID(final Result result) {
        result.success(CommonKt.getAppUserID());
    }

    private void getStorefront(final Result result) {
        CommonKt.getStorefront(new Function1<Map<String, ? extends Object>, Unit>() {
            @Override
            public Unit invoke(Map<String, ?> storefrontMap) {
                result.success(storefrontMap);
                return null;
            }
        });
    }

    private void restorePurchases(final Result result) {
        CommonKt.restorePurchases(getOnResult(result));
    }

    private void logOut(final Result result) {
        CommonKt.logOut(getOnResult(result));
    }

    private void logIn(String appUserID, final Result result) {
        CommonKt.logIn(appUserID, getOnResult(result));
    }

    private void setDebugLogsEnabled(boolean enabled, final Result result) {
        String logLevel = enabled ? "DEBUG" : "INFO";
        CommonKt.setLogLevel(logLevel);
        result.success(null);
    }

    private void syncAmazonPurchase(String productID,
            String receiptID,
            String amazonUserID,
            String isoCurrencyCode,
            Double price,
            final Result result) {
        Purchases.getSharedInstance().syncAmazonPurchase(productID, receiptID,
                amazonUserID, isoCurrencyCode, price);
        result.success(null);
    }

    private void setLogLevel(String level, final Result result) {
        CommonKt.setLogLevel(level);
        result.success(null);
    }

    private void setProxyURLString(String proxyURLString, final Result result) {
        CommonKt.setProxyURLString(proxyURLString);
        result.success(null);
    }

    private void getCustomerInfo(final Result result) {
        CommonKt.getCustomerInfo(getOnResult(result));
    }

    private void syncPurchases(final Result result) {
        CommonKt.syncPurchases();
        result.success(null);
    }

    private void isAnonymous(final Result result) {
        result.success(CommonKt.isAnonymous());
    }

    private void isConfigured(final Result result) {
        result.success(Purchases.isConfigured());
    }

    private void checkTrialOrIntroductoryPriceEligibility(ArrayList<String> productIDs, final Result result) {
        result.success(CommonKt.checkTrialOrIntroductoryPriceEligibility(productIDs));
    }

    private void invalidateCustomerInfoCache(Result result) {
        CommonKt.invalidateCustomerInfoCache();
        result.success(null);
    }

    // ================================================================================
    // Subscriber Attributes
    // ================================================================================

    private void setAttributes(Map<String, String> map, final Result result) {
        SubscriberAttributesKt.setAttributes(map);
        result.success(null);
    }

    private void setEmail(String email, final Result result) {
        SubscriberAttributesKt.setEmail(email);
        result.success(null);
    }

    private void setPhoneNumber(String phoneNumber, final Result result) {
        SubscriberAttributesKt.setPhoneNumber(phoneNumber);
        result.success(null);
    }

    private void setDisplayName(String displayName, final Result result) {
        SubscriberAttributesKt.setDisplayName(displayName);
        result.success(null);
    }

    private void setPushToken(String pushToken, final Result result) {
        SubscriberAttributesKt.setPushToken(pushToken);
        result.success(null);
    }

    private void setAdjustID(String adjustID, final Result result) {
        SubscriberAttributesKt.setAdjustID(adjustID);
        result.success(null);
    }

    private void setAppsflyerID(String appsflyerID, final Result result) {
        SubscriberAttributesKt.setAppsflyerID(appsflyerID);
        result.success(null);
    }

    private void setFBAnonymousID(String fbAnonymousID, final Result result) {
        SubscriberAttributesKt.setFBAnonymousID(fbAnonymousID);
        result.success(null);
    }

    private void setMparticleID(String mparticleID, final Result result) {
        SubscriberAttributesKt.setMparticleID(mparticleID);
        result.success(null);
    }

    private void setCleverTapID(String cleverTapID, final Result result) {
        SubscriberAttributesKt.setCleverTapID(cleverTapID);
        result.success(null);
    }

    private void setMixpanelDistinctID(String mixpanelDistinctID, final Result result) {
        SubscriberAttributesKt.setMixpanelDistinctID(mixpanelDistinctID);
        result.success(null);
    }

    private void setFirebaseAppInstanceID(String firebaseAppInstanceId, final Result result) {
        SubscriberAttributesKt.setFirebaseAppInstanceID(firebaseAppInstanceId);
        result.success(null);
    }

    private void setTenjinAnalyticsInstallationID(
        String tenjinAnalyticsInstallationID,
        final Result result
    ) {
        SubscriberAttributesKt.setTenjinAnalyticsInstallationID(tenjinAnalyticsInstallationID);
        result.success(null);
    }

    private void setOnesignalID(String onesignalID, final Result result) {
        SubscriberAttributesKt.setOnesignalID(onesignalID);
        result.success(null);
    }

    private void setAirshipChannelID(String airshipChannelID, final Result result) {
        SubscriberAttributesKt.setAirshipChannelID(airshipChannelID);
        result.success(null);
    }

    private void setMediaSource(String mediaSource, final Result result) {
        SubscriberAttributesKt.setMediaSource(mediaSource);
        result.success(null);
    }

    private void setCampaign(String campaign, final Result result) {
        SubscriberAttributesKt.setCampaign(campaign);
        result.success(null);
    }

    private void setAdGroup(String adGroup, final Result result) {
        SubscriberAttributesKt.setAdGroup(adGroup);
        result.success(null);
    }

    private void setAd(String ad, final Result result) {
        SubscriberAttributesKt.setAd(ad);
        result.success(null);
    }

    private void setKeyword(String keyword, final Result result) {
        SubscriberAttributesKt.setKeyword(keyword);
        result.success(null);
    }

    private void setCreative(String creative, final Result result) {
        SubscriberAttributesKt.setCreative(creative);
        result.success(null);
    }

    private void collectDeviceIdentifiers(final Result result) {
        SubscriberAttributesKt.collectDeviceIdentifiers();
        result.success(null);
    }

    private void canMakePayments(List<Integer> features, final Result result) {
        CommonKt.canMakePayments(applicationContext,
                features,
                new OnResultAny<Boolean>() {
                    @Override
                    public void onReceived(Boolean received) {
                        result.success(received);
                    }

                    @Override
                    public void onError(@Nullable ErrorContainer errorContainer) {
                        reject(errorContainer, result);
                    }
                });
    }

    private void close(final Result result) {
        try {
            Purchases.getSharedInstance().close();
        } catch (UninitializedPropertyAccessException e) {
            // there's no instance so all good
        }
        result.success(null);
    }

    private void setLogHandler(final Result result) {
        CommonKt.setLogHandler(logData -> {
            invokeChannelMethodOnUiThread(LOG_HANDLER_EVENT, logData);
            return null;
        });
        result.success(null);
    }

    private void showInAppMessages(final ArrayList<Integer> messageTypes, final Result result) {
        if (messageTypes == null) {
            CommonKt.showInAppMessagesIfNeeded(activity);
        } else {
            ArrayList<InAppMessageType> messageTypesList = new ArrayList<>();
            InAppMessageType[] inAppMessageTypes = InAppMessageType.values();
            for (int i = 0; i < messageTypes.size(); i++) {
                int messageTypeInt = messageTypes.get(i);
                InAppMessageType messageType = null;
                if (messageTypeInt < inAppMessageTypes.length) {
                    messageType = inAppMessageTypes[messageTypeInt];
                }
                if (messageType != null) {
                    messageTypesList.add(messageType);
                } else {
                    Log.e(TAG, "Unsupported in-app message type: " + messageTypeInt);
                }
            }
            CommonKt.showInAppMessagesIfNeeded(activity, messageTypesList);
        }
        result.success(null);
    }

    private void isWebPurchaseRedemptionURL(String urlString, final Result result) {
        if (urlString == null) {
            result.error(
                    INVALID_ARGS_ERROR_CODE,
                    "Missing urlString argument",
                    null
            );
            return;
        }
        result.success(CommonKt.isWebPurchaseRedemptionURL(urlString));
    }

    private void redeemWebPurchase(String redemptionLink, final Result result) {
        if (redemptionLink == null) {
            result.error(
                    INVALID_ARGS_ERROR_CODE,
                    "Missing redemptionLink argument",
                    null
            );
            return;
        }
        CommonKt.redeemWebPurchase(redemptionLink, getOnResult(result));
    }

    private void runOnUiThread(Runnable runnable) {
        handler.post(runnable);
    }

    @NotNull
    private OnResult getOnResult(final Result result) {
        return new OnResult() {
            @Override
            public void onReceived(@NotNull Map<String, ?> map) {
                result.success(map);
            }

            @Override
            public void onError(@NotNull ErrorContainer errorContainer) {
                reject(errorContainer, result);
            }
        };
    }

    @NotNull
    private OnNullableResult getOnNullableResult(final Result result) {
        return new OnNullableResult() {
            @Override
            public void onReceived(@Nullable Map<String, ?> map) {
                result.success(map);
            }

            @Override
            public void onError(@NotNull ErrorContainer errorContainer) {
                reject(errorContainer, result);
            }
        };
    }

    private void reject(ErrorContainer errorContainer, Result result) {
        result.error(String.valueOf(errorContainer.getCode()), errorContainer.getMessage(), errorContainer.getInfo());
    }

    private void invokeChannelMethodOnUiThread(String method, Object argumentsMap) {
        runOnUiThread(() -> {
            if (channel != null) {
                channel.invokeMethod(method, argumentsMap);
            }
        });
    }

}
