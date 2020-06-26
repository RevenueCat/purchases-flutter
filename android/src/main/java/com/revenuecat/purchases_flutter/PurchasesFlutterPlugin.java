package com.revenuecat.purchases_flutter;

import android.app.Activity;
import android.content.Context;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.revenuecat.purchases.PlatformInfo;
import com.revenuecat.purchases.PurchaserInfo;
import com.revenuecat.purchases.Purchases;
import com.revenuecat.purchases.common.CommonKt;
import com.revenuecat.purchases.common.ErrorContainer;
import com.revenuecat.purchases.common.MappersKt;
import com.revenuecat.purchases.common.OnResult;
import com.revenuecat.purchases.common.OnResultList;
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
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import io.flutter.view.FlutterNativeView;
import kotlin.UninitializedPropertyAccessException;

/**
 * PurchasesFlutterPlugin
 */
public class PurchasesFlutterPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {

    private static final String PURCHASER_INFO_UPDATED = "Purchases-PurchaserInfoUpdated";

    // Only set registrar for v1 embedder.
    private PluginRegistry.Registrar registrar;
    // Only set activity for v2 embedder. Always access activity from getActivity() method.
    private Context applicationContext;
    private MethodChannel channel;
    private Activity activity;

    private static final String PLATFORM_NAME = "flutter";
    private static final String PLUGIN_VERSION = "1.2.0-SNAPSHOT";

    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        PurchasesFlutterPlugin instance = new PurchasesFlutterPlugin();
        instance.onAttachedToEngine(registrar.messenger(), registrar.context());
        instance.registrar = registrar;
        registrar.addViewDestroyListener(new PluginRegistry.ViewDestroyListener() {
            @Override
            public boolean onViewDestroy(FlutterNativeView flutterNativeView) {
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
        try {
            Purchases.getSharedInstance().close();
        } catch (UninitializedPropertyAccessException e) {
            // there's no instance so all good
        }
        channel.setMethodCallHandler(null);
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
    public void onMethodCall(MethodCall call, Result result) {
        switch (call.method) {
            case "setupPurchases":
                String apiKey = call.argument("apiKey");
                String appUserId = call.argument("appUserId");
                Boolean observerMode = call.argument("observerMode");
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
            case "checkTrialOrIntroductoryPriceEligibility":
                productIdentifiers = call.argument("productIdentifiers");
                checkTrialOrIntroductoryPriceEligibility(productIdentifiers, result);
                break;
            case "invalidatePurchaserInfoCache":
                invalidatePurchaserInfoCache(result);
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
            default:
                result.notImplemented();
                break;
        }
    }

    private void sendEvent(String eventName, @Nullable Map<String, Object> params) {
        channel.invokeMethod(eventName, params);
    }

    private void setupPurchases(String apiKey, String appUserID, @Nullable Boolean observerMode, final Result result) {
        PlatformInfo platformInfo = new PlatformInfo(PLATFORM_NAME, PLUGIN_VERSION);
        CommonKt.configure(this.applicationContext, apiKey, appUserID, observerMode, platformInfo);

        Purchases.getSharedInstance().setUpdatedPurchaserInfoListener(new UpdatedPurchaserInfoListener() {
            @Override
            public void onReceived(@NonNull PurchaserInfo purchaserInfo) {
                sendEvent(PURCHASER_INFO_UPDATED, MappersKt.map(purchaserInfo));
            }
        });
        result.success(null);
    }

    private void setFinishTransactions(boolean finishTransactions, Result result) {
        CommonKt.setFinishTransactions(finishTransactions);
        result.success(null);
    }

    private void setAllowSharingAppStoreAccount(boolean allowSharingAppStoreAccount, Result result) {
        CommonKt.setAllowSharingAppStoreAccount(allowSharingAppStoreAccount);
        result.success(null);
    }

    private void addAttributionData(Map<String, String> data, int network,
                                    @Nullable String networkUserId, Result result) {
        CommonKt.addAttributionData(data, network, networkUserId);
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

    private void reset(final Result result) {
        CommonKt.reset(getOnResult(result));
    }

    private void identify(String appUserID, final Result result) {
        CommonKt.identify(appUserID, getOnResult(result));
    }

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
        CommonKt.setAttributes(map);
        result.success(null);
    }

    private void setEmail(String email, final Result result) {
        CommonKt.setEmail(email);
        result.success(null);
    }

    private void setPhoneNumber(String phoneNumber, final Result result) {
        CommonKt.setPhoneNumber(phoneNumber);
        result.success(null);
    }

    private void setDisplayName(String displayName, final Result result) {
        CommonKt.setDisplayName(displayName);
        result.success(null);
    }

    private void setPushToken(String pushToken, final Result result) {
        CommonKt.setPushToken(pushToken);
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
