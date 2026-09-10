package com.revenuecat.purchases.hybridcommon;

import org.jetbrains.annotations.NotNull;

import java.util.Map;

public interface OnResult {
    void onReceived(@NotNull Map<String, ?> map);
    void onError(@NotNull ErrorContainer errorContainer);
}