package com.revenuecat.purchases_flutter;

import android.app.Activity;
import android.content.Context;
import android.util.Pair;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.android.billingclient.api.Purchase;
import com.android.billingclient.api.SkuDetails;
import com.revenuecat.purchases.Entitlement;
import com.revenuecat.purchases.PurchaserInfo;
import com.revenuecat.purchases.Purchases;
import com.revenuecat.purchases.PurchasesError;
import com.revenuecat.purchases.PurchasesErrorCode;
import com.revenuecat.purchases.interfaces.GetSkusResponseListener;
import com.revenuecat.purchases.interfaces.MakePurchaseListener;
import com.revenuecat.purchases.interfaces.ReceiveEntitlementsListener;
import com.revenuecat.purchases.interfaces.ReceivePurchaserInfoListener;
import com.revenuecat.purchases.interfaces.UpdatedPurchaserInfoListener;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import io.flutter.view.FlutterNativeView;
import kotlin.UninitializedPropertyAccessException;

import static com.revenuecat.purchases_flutter.Mappers.mapEntitlements;
import static com.revenuecat.purchases_flutter.Mappers.mapPurchaserInfo;
import static com.revenuecat.purchases_flutter.Mappers.mapSkuDetails;

/** PurchasesFlutterPlugin */
public class PurchasesFlutterPlugin implements MethodCallHandler {

  private List<SkuDetails> products = new ArrayList<>();
  private static final String PURCHASER_INFO_UPDATED = "Purchases-PurchaserInfoUpdated";

  private final Activity activity;
  private final Context context;
  private final MethodChannel channel;

  public PurchasesFlutterPlugin(Registrar registrar, MethodChannel channel) {
    this.activity = registrar.activity();
    this.context = registrar.context();
    this.channel = channel;
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

  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "purchases_flutter");
    channel.setMethodCallHandler(new PurchasesFlutterPlugin(registrar, channel));
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    switch (call.method) {
    case "setupPurchases":
      String apiKey = call.argument("apiKey");
      String appUserId = call.argument("appUserId");
      Boolean observerMode = call.argument("observerMode");
        setupPurchases(apiKey, appUserId, observerMode, result);
      break;
    case "setAllowSharingStoreAccount":
      Boolean allowSharing = call.argument("allowSharing");
      setAllowSharingAppStoreAccount(allowSharing, result);
      break;
    case "addAttributionData":
      Map<String, String> data = call.argument("data");
      int network = call.argument("network") != null ? (int) call.argument("network") : -1;
      String networkUserId = call.argument("networkUserId");
      addAttributionData(data, network, networkUserId);
      break;
    case "getEntitlements":
      getEntitlements(result);
      break;
    case "getProductInfo":
      ArrayList<String> productIdentifiers = call.argument("productIdentifiers");
      String type = call.argument("type");
      getProductInfo(productIdentifiers, type, result);
      break;
    case "makePurchase":
      String productIdentifier = call.argument("productIdentifier");
      String oldSKU = call.argument("oldSKU");
      String type1 = call.argument("type");
      makePurchase(productIdentifier, oldSKU, type1, result);
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
    case "getPurchaserInfo":
      getPurchaserInfo(result);
      break;
    case "syncPurchases":
      syncPurchases(result);
      break;
    case "setAutomaticAttributionCollection":
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
    if (observerMode != null) {
      Purchases.configure(this.context, apiKey, appUserID, observerMode);
    } else {
      Purchases.configure(this.context, apiKey, appUserID);
    }
    Purchases.getSharedInstance().setUpdatedPurchaserInfoListener(new UpdatedPurchaserInfoListener() {
      @Override
      public void onReceived(@NonNull PurchaserInfo purchaserInfo) {
        sendEvent(PURCHASER_INFO_UPDATED, mapPurchaserInfo(purchaserInfo));
      }
    });
    result.success(null);
  }

  private void setAllowSharingAppStoreAccount(boolean allowSharingAppStoreAccount, Result result) {
    Purchases.getSharedInstance().setAllowSharingPlayStoreAccount(allowSharingAppStoreAccount);
    result.success(null);
  }

  private void addAttributionData(Map<String, String> data, int network, @Nullable String networkUserId) {
    for (Purchases.AttributionNetwork attributionNetwork : Purchases.AttributionNetwork.values()) {
      if (attributionNetwork.getServerValue() == network) {
        Purchases.addAttributionData(data, attributionNetwork, networkUserId);
      }
    }
  }

  private void getEntitlements(final Result result) {
    Purchases.getSharedInstance().getEntitlements(new ReceiveEntitlementsListener() {
      @Override
      public void onReceived(@NonNull Map<String, Entitlement> entitlementMap) {
        result.success(mapEntitlementsAndCacheProducts(entitlementMap));
      }

      @Override
      public void onError(@NonNull PurchasesError error) {
        reject(result, error);
      }
    });
  }

  private Map<String, Object> mapEntitlementsAndCacheProducts(@NonNull Map<String, Entitlement> entitlementMap) {
    Pair<Map<String, Object>, List<SkuDetails>> pairResponseProducts = mapEntitlements(entitlementMap);
    products = pairResponseProducts.second;
    return pairResponseProducts.first;
  }

  private void getProductInfo(ArrayList<String> productIDs, String type, final Result result) {
    GetSkusResponseListener listener = new GetSkusResponseListener() {
      @Override
      public void onReceived(@NonNull List<SkuDetails> skus) {
        ArrayList<Map> products = new ArrayList<>();
        for (SkuDetails detail : skus) {
          products.add(mapSkuDetails(detail));
        }

        result.success(products);
      }

      @Override
      public void onError(@NonNull PurchasesError error) {
        reject(result, error);
      }

    };

    if (type.toLowerCase().equals("subs")) {
      Purchases.getSharedInstance().getSubscriptionSkus(productIDs, listener);
    } else {
      Purchases.getSharedInstance().getNonSubscriptionSkus(productIDs, listener);
    }
  }

  private void makePurchase(final String productIdentifier, final String oldSku, final String type,
                            final Result result) {
    if (this.activity != null) {
      if (products.isEmpty()) {
        Purchases.getSharedInstance().getEntitlements(new ReceiveEntitlementsListener() {
          @Override
          public void onReceived(@NonNull Map<String, Entitlement> entitlementMap) {
            mapEntitlementsAndCacheProducts(entitlementMap);
            makePurchase(activity, oldSku, type, productIdentifier, result);
          }

          @Override
          public void onError(@NonNull PurchasesError error) {
            reject(result, error);
          }
        });
      } else {
        makePurchase(activity, oldSku, type, productIdentifier, result);
      }
    } else {
      reject(result, new PurchasesError(
              PurchasesErrorCode.PurchaseInvalidError,
              "There is no current Activity"));
    }
  }

  @Nullable
  private SkuDetails findProduct(String productIdentifier, String type) {
    for (SkuDetails product : products) {
      if (product.getSku().equals(productIdentifier) && product.getType().equalsIgnoreCase(type)) {
        return product;
      }
    }
    return null;
  }

  private void makePurchase(final Activity currentActivity, final String oldSku, final String type,
                            final String productIdentifier, final Result result) {
    SkuDetails productToBuy = findProduct(productIdentifier, type);
    if (productToBuy != null) {
      MakePurchaseListener listener = new MakePurchaseListener() {
        @Override
        public void onCompleted(@NonNull Purchase purchase, @NonNull PurchaserInfo purchaserInfo) {
          result.success(mapPurchaserInfo(purchaserInfo));
        }

        @Override
        public void onError(@NonNull PurchasesError error, Boolean userCancelled) {
          HashMap<String, Object> map = new HashMap<>();
          map.put("userCancelled", userCancelled);
          reject(result, error);
        }
      };
      if (oldSku == null || oldSku.isEmpty()) {
        Purchases.getSharedInstance().makePurchase(currentActivity, productToBuy, listener);
      } else {
        Purchases.getSharedInstance().makePurchase(currentActivity, productToBuy, oldSku, listener);
      }
    } else {
      reject(result, new PurchasesError(
              PurchasesErrorCode.ProductNotAvailableForPurchaseError,
              "Couldn't find product."));
    }
  }

  private void getAppUserID(final Result result) {
    result.success(Purchases.getSharedInstance().getAppUserID());
  }

  private void restoreTransactions(final Result result) {
    Purchases.getSharedInstance().restorePurchases(new ReceivePurchaserInfoListener() {
      @Override
      public void onReceived(@NonNull PurchaserInfo purchaserInfo) {
        result.success(mapPurchaserInfo(purchaserInfo));
      }

      @Override
      public void onError(@NonNull PurchasesError error) {
        reject(result, error);
      }
    });
  }

  private void reset(final Result result) {
    Purchases.getSharedInstance().reset(new ReceivePurchaserInfoListener() {
      @Override
      public void onReceived(@NonNull PurchaserInfo purchaserInfo) {
        result.success(mapPurchaserInfo(purchaserInfo));
      }

      @Override
      public void onError(@NonNull PurchasesError error) {
        reject(result, error);
      }
    });
  }

  private void identify(String appUserID, final Result result) {
    Purchases.getSharedInstance().identify(appUserID, new ReceivePurchaserInfoListener() {
      @Override
      public void onReceived(@NonNull PurchaserInfo purchaserInfo) {
        result.success(mapPurchaserInfo(purchaserInfo));
      }

      @Override
      public void onError(@NonNull PurchasesError error) {
        reject(result, error);
      }
    });
  }

  private void createAlias(String newAppUserID, final Result result) {
    Purchases.getSharedInstance().createAlias(newAppUserID, new ReceivePurchaserInfoListener() {
      @Override
      public void onReceived(@NonNull PurchaserInfo purchaserInfo) {
        result.success(mapPurchaserInfo(purchaserInfo));
      }

      @Override
      public void onError(@NonNull PurchasesError error) {
        reject(result, error);
      }
    });
  }

  private void setDebugLogsEnabled(boolean enabled, final Result result) {
    Purchases.setDebugLogsEnabled(enabled);
    result.success(null);
  }

  private void getPurchaserInfo(final Result result) {
    Purchases.getSharedInstance().getPurchaserInfo(new ReceivePurchaserInfoListener() {
      @Override
      public void onReceived(@NonNull PurchaserInfo purchaserInfo) {
        result.success(mapPurchaserInfo(purchaserInfo));
      }

      @Override
      public void onError(@NonNull PurchasesError error) {
        reject(result, error);
      }
    });
  }

  private void syncPurchases(final Result result) {
    Purchases.getSharedInstance().syncPurchases();
    result.success(null);
  }

  private static void reject(Result result, PurchasesError error) {
    reject(result, error, new HashMap<String, Object>());
  }

  private static void reject(Result result, PurchasesError error, Map<String, Object> extraPayload) {
    Map<String, Object> userInfoMap = errorPayload(error);
    userInfoMap.putAll(extraPayload);
    result.error(error.getCode().ordinal() + "", error.getMessage(), userInfoMap);
  }

  private static Map<String, Object> errorPayload(PurchasesError error) {
    Map<String, Object> userInfoMap = new HashMap<>();
    userInfoMap.put("readableErrorCode", error.getCode().name());
    if (error.getUnderlyingErrorMessage() != null && !error.getUnderlyingErrorMessage().isEmpty()) {
      userInfoMap.put("underlyingErrorMessage", error.getUnderlyingErrorMessage());
    }
    return userInfoMap;
  }

}
