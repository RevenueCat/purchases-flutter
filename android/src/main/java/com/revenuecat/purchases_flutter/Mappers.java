package com.revenuecat.purchases_flutter;

import android.util.Pair;

import com.android.billingclient.api.SkuDetails;
import com.revenuecat.purchases.Entitlement;
import com.revenuecat.purchases.Offering;
import com.revenuecat.purchases.PurchaserInfo;
import com.revenuecat.purchases.util.Iso8601Utils;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Mappers {

    private Mappers() {
    }

    static Map<String, Object> mapSkuDetails(final SkuDetails detail) {
        Map<String, Object> map = new HashMap<>();

        map.put("identifier", detail.getSku());
        map.put("description", detail.getDescription());
        map.put("title", detail.getTitle());
        map.put("price", detail.getPriceAmountMicros() / 1000000d);
        map.put("price_string", detail.getPrice());
        String introductoryPriceAmountMicros = detail.getIntroductoryPriceAmountMicros();
        if (introductoryPriceAmountMicros != null && !introductoryPriceAmountMicros.isEmpty()) {
            map.put("intro_price", String.valueOf(Long.parseLong(introductoryPriceAmountMicros) / 1000000d));
        } else {
            map.put("intro_price", "");
        }
        map.put("intro_price_string", detail.getIntroductoryPrice());
        map.put("intro_price_period", detail.getIntroductoryPricePeriod());
        map.put("intro_price_cycles", detail.getIntroductoryPriceCycles());

        map.put("currency_code", detail.getPriceCurrencyCode());

        return map;
    }

    static Map<String, Object> mapPurchaserInfo(PurchaserInfo purchaserInfo) {
        Map<String, Object> map = new HashMap<>();
        map.put("activeEntitlements", new ArrayList<>(purchaserInfo.getActiveEntitlements()));
        map.put("activeSubscriptions", new ArrayList<>(purchaserInfo.getActiveSubscriptions()));
        map.put("allPurchasedProductIdentifiers", new ArrayList<>(purchaserInfo.getAllPurchasedSkus()));

        Date latest = purchaserInfo.getLatestExpirationDate();
        if (latest != null) {
            map.put("latestExpirationDate", Iso8601Utils.format(latest));
        } else {
            map.put("latestExpirationDate", null);
        }

        Map<String, String> allExpirationDates = new HashMap<>();
        Map<String, Date> dates = purchaserInfo.getAllExpirationDatesByProduct();
        for (String key : dates.keySet()) {
            Date date = dates.get(key);
            if (date != null) {
                allExpirationDates.put(key, Iso8601Utils.format(date));
            } else {
                allExpirationDates.put(key, null);
            }
        }
        map.put("allExpirationDates", allExpirationDates);

        Map<String, String> allEntitlementExpirationDates = new HashMap<>();

        for (String entitlementId : purchaserInfo.getActiveEntitlements()) {
            Date date = purchaserInfo.getExpirationDateForEntitlement(entitlementId);
            if (date != null) {
                allEntitlementExpirationDates.put(entitlementId, Iso8601Utils.format(date));
            } else {
                allEntitlementExpirationDates.put(entitlementId, null);
            }
        }
        map.put("expirationsForActiveEntitlements", allEntitlementExpirationDates);

        Map<String, String> purchaseDatesForActiveEntitlements = new HashMap<>();

        for (String entitlementId : purchaserInfo.getActiveEntitlements()) {
            Date date = purchaserInfo.getPurchaseDateForEntitlement(entitlementId);
            if (date != null) {
                purchaseDatesForActiveEntitlements.put(entitlementId, Iso8601Utils.format(date));
            } else {
                purchaseDatesForActiveEntitlements.put(entitlementId, null);
            }
        }
        map.put("purchaseDatesForActiveEntitlements", purchaseDatesForActiveEntitlements);

        return map;
    }

    static Pair<Map<String, Object>, List<SkuDetails>> mapEntitlements(Map<String, Entitlement> entitlementMap) {
        List<SkuDetails> products = new ArrayList<>();
        Map<String, Object> response = new HashMap<>();
        for (String entId : entitlementMap.keySet()) {
            Entitlement ent = entitlementMap.get(entId);
            Map<String, Object> offeringsMap = new HashMap<>();
            if (ent != null) {
                Map<String, Offering> offerings = ent.getOfferings();
                for (String offeringId : offerings.keySet()) {
                    Offering offering = offerings.get(offeringId);
                    if (offering != null) {
                        SkuDetails skuDetails = offering.getSkuDetails();
                        if (skuDetails != null) {
                            products.add(skuDetails);
                            Map<String, Object> skuMap = mapSkuDetails(skuDetails);
                            offeringsMap.put(offeringId, skuMap);
                        } else {
                            offeringsMap.put(offeringId, null);
                        }
                    }
                }
            }

            response.put(entId, offeringsMap);
        }

        return new Pair<>(response, products);
    }
}
