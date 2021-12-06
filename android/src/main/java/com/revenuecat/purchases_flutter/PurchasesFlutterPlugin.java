package com.revenuecat.purchases_flutter;

import android.app.Activity;
import android.content.Context;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.revenuecat.purchases.PurchaserInfo;
import com.revenuecat.purchases.Purchases;
import com.revenuecat.purchases.PurchasesErrorCode;
import com.revenuecat.purchases.common.PlatformInfo;
import com.revenuecat.purchases.hybridcommon.CommonKt;
import com.revenuecat.purchases.hybridcommon.ErrorContainer;
import com.revenuecat.purchases.hybridcommon.OnResult;
import com.revenuecat.purchases.hybridcommon.OnResultAny;
import com.revenuecat.purchases.hybridcommon.OnResultList;
import com.revenuecat.purchases.hybridcommon.SubscriberAttributesKt;
import com.revenuecat.purchases.hybridcommon.mappers.PurchaserInfoMapperKt;
import com.revenuecat.purchases.interfaces.UpdatedPurchaserInfoListener;

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

/**
 * PurchasesFlutterPlugin
 */
public class PurchasesFlutterPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
    private String INVALID_ARGS_ERROR_CODE = "invalidArgs";

    private static final String PURCHASER_INFO_UPDATED = "Purchases-PurchaserInfoUpdated";

    // Only set registrar for v1 embedder.
    @SuppressWarnings("deprecation")
    private io.flutter.plugin.common.PluginRegistry.Registrar registrar;
    // Only set activity for v2 embedder. Always access activity from getActivity() method.
    @Nullable private Context applicationContext;
    @Nullable private MethodChannel channel;
    @Nullable private Activity activity;

    private static final String PLATFORM_NAME = "flutter";
    private static final String PLUGIN_VERSION = "3.8.0";

    /**
     * Plugin registration.
     */
    @SuppressWarnings("deprecation")
    public static void registerWith(io.flutter.plugin.common.PluginRegistry.Registrar registrar) {
        PurchasesFlutterPlugin instance = new PurchasesFlutterPlugin();
        instance.onAttachedToEngine(registrar.messenger(), registrar.context());
        instance.registrar = registrar;
        registrar.addViewDestroyListener(new io.flutter.plugin.common.PluginRegistry.ViewDestroyListener() {
            @Override
            public boolean onViewDestroy(io.flutter.view.FlutterNativeView flutterNativeView) {
                try {
                    Purchases.getSharedInstance().close();
                } catch (UninitializedPropertyAccessException e) {
                    // there's no instance so all good
                }
                return false;
            }
        });
    }

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

    public Activity getActivity() {
        return registrar != null ? registrar.activity() : activity;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        switch (call.method) {
            case "setupPurchases":
                String apiKey = call.argument("apiKey");
                String appUserId = call.argument("appUserId");
                Boolean observerMode = call.argument("observerMode");
                //noinspection unused
                String userDefaultsSuiteName = call.argument("userDefaultsSuiteName"); // iOS-only, unused.
                setupPurchases(apiKey, appUserId, observerMode, result);
                break;
            case "setFinishTransactions":
                Boolean finishTransactions = call.argument("finishTransactions");
                setFinishTransactions(finishTransactions, result);
                break;
            case "setAllowSharingStoreAccount":
                Boolean allowSharing = call.argument("allowSharing");
                setAllowSharingAppStoreAccount(allowSharing, result);
                break;
            case "addAttributionData":
                Map<String, String> data = call.argument("data");
                int network = call.argument("network") != null ? (int) call.argument("network") : -1;
                String networkUserId = call.argument("networkUserId");
                addAttributionData(data, network, networkUserId, result);
                break;
            case "getOfferings":
                getOfferings(result);
                break;
            case "getProductInfo":
                ArrayList<String> productIdentifiers = call.argument("productIdentifiers");
                String type = call.argument("type");
                getProductInfo(productIdentifiers, type, result);
                break;
            case "purchaseProduct":
                String productIdentifier = call.argument("productIdentifier");
                String oldSKU = call.argument("oldSKU");
                Integer prorationMode = call.argument("prorationMode");
                type = call.argument("type");
                purchaseProduct(productIdentifier, oldSKU, prorationMode, type, result);
                break;
            case "purchasePackage":
                String packageIdentifier = call.argument("packageIdentifier");
                String offeringIdentifier = call.argument("offeringIdentifier");
                oldSKU = call.argument("oldSKU");
                prorationMode = call.argument("prorationMode");
                purchasePackage(packageIdentifier, offeringIdentifier, oldSKU, prorationMode, result);
                break;
            case "getAppUserID":
                getAppUserID(result);
                break;
            case "restoreTransactions":
                restoreTransactions(result);
                break;
            case "reset":
                reset(result);
                break;
            case "identify":
                String appUserID = call.argument("appUserID");
                identify(appUserID, result);
                break;
            case "createAlias":
                String newAppUserID = call.argument("newAppUserID");
                createAlias(newAppUserID, result);
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
            case "setProxyURLString":
                String proxyURLString = call.argument("proxyURLString");
                setProxyURLString(proxyURLString, result);
                break;
            case "getPurchaserInfo":
                getPurchaserInfo(result);
                break;
            case "syncPurchases":
                syncPurchases(result);
                break;
            case "setAutomaticAppleSearchAdsAttributionCollection":
                // NOOP
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
            case "invalidatePurchaserInfoCache":
                invalidatePurchaserInfoCache(result);
                break;
            case "presentCodeRedemptionSheet":
                // NOOP
                break;
            case "setSimulatesAskToBuyInSandbox":
                // NOOP
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
            default:
                result.notImplemented();
                break;
        }
    }

    private void setupPurchases(String apiKey, String appUserID, @Nullable Boolean observerMode, final Result result) {
        if (this.applicationContext != null) {
            PlatformInfo platformInfo = new PlatformInfo(PLATFORM_NAME, PLUGIN_VERSION);
            CommonKt.configure(this.applicationContext, apiKey, appUserID, observerMode, platformInfo);
            setupUpdatedPurchaserInfoListener();
            result.success(null);
        } else {
            result.error(
                    String.valueOf(PurchasesErrorCode.UnknownError.getCode()),
                    "Purchases can't be setup. There is no Application context",
                    null);
        }
    }

    private void setupUpdatedPurchaserInfoListener() {
        Purchases.getSharedInstance().setUpdatedPurchaserInfoListener(new UpdatedPurchaserInfoListener() {
            @Override
            public void onReceived(@NonNull PurchaserInfo purchaserInfo) {
                if (channel != null) {
                    channel.invokeMethod(PURCHASER_INFO_UPDATED, PurchaserInfoMapperKt.map(purchaserInfo));
                }
            }
        });
    }

    private void setFinishTransactions(@Nullable Boolean finishTransactions, Result result) {
        if (finishTransactions != null) {
            CommonKt.setFinishTransactions(finishTransactions);
            result.success(null);
        } else {
            result.error(
                    INVALID_ARGS_ERROR_CODE,
                    "Missing finishTransactions argument",
                    null);
        }
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

    private void addAttributionData(Map<String, String> data, int network,
                                    @Nullable String networkUserId, Result result) {
        SubscriberAttributesKt.addAttributionData(data, network, networkUserId);
        result.success(null);
    }

    private void getOfferings(final Result result) {
        CommonKt.getOfferings(getOnResult(result));
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

    private void purchaseProduct(final String productIdentifier, final String oldSKU,
                                 @Nullable final Integer prorationMode, final String type,
                                 final Result result) {
        CommonKt.purchaseProduct(
                getActivity(),
                productIdentifier,
                oldSKU,
                prorationMode,
                type,
                getOnResult(result)
        );
    }

    private void purchasePackage(final String packageIdentifier,
                                 final String offeringIdentifier,
                                 @Nullable final String oldSKU,
                                 @Nullable final Integer prorationMode,
                                 final Result result) {
        CommonKt.purchasePackage(
                getActivity(),
                packageIdentifier,
                offeringIdentifier,
                oldSKU,
                prorationMode,
                getOnResult(result)
        );
    }


    private void getAppUserID(final Result result) {
        result.success(CommonKt.getAppUserID());
    }

    private void restoreTransactions(final Result result) {
        CommonKt.restoreTransactions(getOnResult(result));
    }

    @SuppressWarnings("deprecation")
    private void reset(final Result result) {
        CommonKt.reset(getOnResult(result));
    }

    @SuppressWarnings("deprecation")
    private void identify(String appUserID, final Result result) {
        CommonKt.identify(appUserID, getOnResult(result));
    }

    private void logOut(final Result result) {
        CommonKt.logOut(getOnResult(result));
    }

    private void logIn(String appUserID, final Result result) {
        CommonKt.logIn(appUserID, getOnResult(result));
    }

    @SuppressWarnings("deprecation")
    private void createAlias(String newAppUserID, final Result result) {
        CommonKt.createAlias(newAppUserID, getOnResult(result));
    }

    private void setDebugLogsEnabled(boolean enabled, final Result result) {
        CommonKt.setDebugLogsEnabled(enabled);
        result.success(null);
    }

    private void setProxyURLString(String proxyURLString, final Result result) {
        CommonKt.setProxyURLString(proxyURLString);
        result.success(null);
    }

    private void getPurchaserInfo(final Result result) {
        CommonKt.getPurchaserInfo(getOnResult(result));
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

    private void invalidatePurchaserInfoCache(Result result) {
        CommonKt.invalidatePurchaserInfoCache();
        result.success(null);
    }

    //================================================================================
    // Subscriber Attributes
    //================================================================================

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

    @NotNull
    private OnResult getOnResult(final Result result) {
        return new OnResult() {
            @Override
            public void onReceived(Map<String, ?> map) {
                result.success(map);
            }

            @Override
            public void onError(ErrorContainer errorContainer) {
                reject(errorContainer, result);
            }
        };
    }

    private void reject(ErrorContainer errorContainer, Result result) {
        result.error(String.valueOf(errorContainer.getCode()), errorContainer.getMessage(), errorContainer.getInfo());
    }

}
