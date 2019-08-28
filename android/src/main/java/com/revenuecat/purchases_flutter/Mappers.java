package com.revenuecat.purchases_flutter;

import android.util.Pair;

import com.android.billingclient.api.SkuDetails;
import com.revenuecat.purchases.Entitlement;
import com.revenuecat.purchases.EntitlementInfo;
import com.revenuecat.purchases.EntitlementInfos;
import com.revenuecat.purchases.Offering;
import com.revenuecat.purchases.PurchaserInfo;
import com.revenuecat.purchases.util.Iso8601Utils;

import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Currency;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Mappers {

    private Mappers() {
    }

    static Map<String, Object> map(final SkuDetails detail) {
        Map<String, Object> map = new HashMap<>();

        map.put("identifier", detail.getSku());
        map.put("description", detail.getDescription());
        map.put("title", detail.getTitle());
        map.put("price", detail.getPriceAmountMicros() / 1000000d);
        map.put("price_string", detail.getPrice());
        putIntroPrice(detail, map);
        map.put("currency_code", detail.getPriceCurrencyCode());
        return map;
    }

    private static void putIntroPrice(SkuDetails detail, Map<String, Object> map) {
        if (detail.getFreeTrialPeriod().isEmpty()) {
            String introductoryPriceAmountMicros = detail.getIntroductoryPriceAmountMicros();
            if (introductoryPriceAmountMicros != null && !introductoryPriceAmountMicros.isEmpty()) {
                map.put("intro_price", String.valueOf(Long.parseLong(introductoryPriceAmountMicros) / 1000000d));
            } else {
                map.put("intro_price", "");
            }
            map.put("intro_price_string", detail.getIntroductoryPrice());
            map.put("intro_price_period", detail.getIntroductoryPricePeriod());
            if (detail.getIntroductoryPricePeriod() != null && !detail.getIntroductoryPricePeriod().isEmpty()) {
                PurchasesPeriod period = PurchasesPeriod.parse(detail.getIntroductoryPricePeriod());
                if (period.years > 0) {
                    map.put("intro_price_period_unit", "YEAR");
                    map.put("intro_price_period_number_of_units", "" + period.years);
                } else if (period.months > 0) {
                    map.put("intro_price_period_unit", "MONTH");
                    map.put("intro_price_period_number_of_units", "" + period.months);
                } else if (period.days > 0) {
                    map.put("intro_price_period_unit", "DAY");
                    map.put("intro_price_period_number_of_units", "" + period.days);
                }
            } else {
                map.put("intro_price_period_unit", "");
                map.put("intro_price_period_number_of_units", "");
            }
            map.put("intro_price_cycles", detail.getIntroductoryPriceCycles());
        } else {
            map.put("intro_price", "0");
            // Format using device locale. iOS will format using App Store locale, but there's no way
            // to figure out how the price in the SKUDetails is being formatted.
            NumberFormat format = NumberFormat.getCurrencyInstance();
            format.setCurrency(Currency.getInstance(detail.getPriceCurrencyCode()));
            map.put("intro_price_string", format.format(0));
            map.put("intro_price_period", detail.getFreeTrialPeriod());
            PurchasesPeriod period = PurchasesPeriod.parse(detail.getIntroductoryPricePeriod());
            if (period.years > 0) {
                map.put("intro_price_period_unit", "YEAR");
                map.put("intro_price_period_number_of_units", "" + period.years);
            } else if (period.months > 0) {
                map.put("intro_price_period_unit", "MONTH");
                map.put("intro_price_period_number_of_units", "" + period.months);
            } else if (period.days > 0) {
                map.put("intro_price_period_unit", "DAY");
                map.put("intro_price_period_number_of_units", "" + period.days);
            }
            map.put("intro_price_cycles", "1");
        }
    }

    static Map<String, Object> map(PurchaserInfo purchaserInfo) {
        Map<String, Object> map = new HashMap<>();
        map.put("activeEntitlements", new ArrayList<>(purchaserInfo.getActiveEntitlements()));
        map.put("activeSubscriptions", new ArrayList<>(purchaserInfo.getActiveSubscriptions()));
        map.put("allPurchasedProductIdentifiers", new ArrayList<>(purchaserInfo.getAllPurchasedSkus()));

        Mappers.putNullableDate(map, "latestExpirationDate", purchaserInfo.getLatestExpirationDate());

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

        Map<String, Object> allEntitlementExpirationDates = new HashMap<>();

        for (String entitlementId : purchaserInfo.getActiveEntitlements()) {
            Date date = purchaserInfo.getExpirationDateForEntitlement(entitlementId);
            Mappers.putNullableDate(allEntitlementExpirationDates, entitlementId, date);
        }
        map.put("expirationsForActiveEntitlements", allEntitlementExpirationDates);

        Map<String, Object> purchaseDatesForActiveEntitlements = new HashMap<>();

        for (String entitlementId : purchaserInfo.getActiveEntitlements()) {
            Date date = purchaserInfo.getPurchaseDateForEntitlement(entitlementId);
            Mappers.putNullableDate(purchaseDatesForActiveEntitlements, entitlementId, date);
        }
        map.put("purchaseDatesForActiveEntitlements", purchaseDatesForActiveEntitlements);

        map.put("entitlements", Mappers.map(purchaserInfo.getEntitlements()));
        map.put("firstSeen", Iso8601Utils.format(purchaserInfo.getFirstSeen()));
        map.put("originalAppUserId",purchaserInfo.getOriginalAppUserId());

        return map;
    }

    static Pair<Map<String, Object>, List<SkuDetails>> map(Map<String, Entitlement> entitlementMap) {
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
                            Map<String, Object> skuMap = map(skuDetails);
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

    static Map<String, Object> map(EntitlementInfos data) {
        Map<String, Object> entitlementInfos = new HashMap<>();
        Map<String, Object> all = new HashMap<>();
        for (Map.Entry<String, EntitlementInfo> entry : data.getAll().entrySet()) {
            all.put(entry.getKey(), Mappers.map(entry.getValue()));
        }
        entitlementInfos.put("all", all);
        Map<String, Object> active = new HashMap<>();
        for (Map.Entry<String, EntitlementInfo> entry : data.getActive().entrySet()) {
            active.put(entry.getKey(), Mappers.map(entry.getValue()));
        }
        entitlementInfos.put("active", active);

        return entitlementInfos;
    }

    private static Map<String, Object> map(EntitlementInfo data) {
        Map<String, Object> entitlementInfo = new HashMap<>();
        entitlementInfo.put("identifier", data.getIdentifier());
        entitlementInfo.put("isActive", data.isActive());
        entitlementInfo.put("willRenew", data.getWillRenew());
        entitlementInfo.put("periodType", data.getPeriodType().name());
        entitlementInfo.put("latestPurchaseDate", Iso8601Utils.format(data.getLatestPurchaseDate()));
        entitlementInfo.put("originalPurchaseDate", Iso8601Utils.format(data.getOriginalPurchaseDate()));
        putNullableDate(entitlementInfo, "expirationDate", data.getExpirationDate());
        entitlementInfo.put("store", data.getStore().name());
        entitlementInfo.put("productIdentifier", data.getProductIdentifier());
        entitlementInfo.put("isSandbox", data.isSandbox());
        putNullableDate(entitlementInfo, "unsubscribeDetectedAt", data.getUnsubscribeDetectedAt());
        putNullableDate(entitlementInfo, "billingIssueDetectedAt", data.getBillingIssueDetectedAt());
        return entitlementInfo;
    }

    static void putNullableDate(Map<String, Object> map, String key, Date date) {
        if (date != null) {
            map.put(key, Iso8601Utils.format(date));
        } else {
            map.put(key, null);
        }
    }
}
