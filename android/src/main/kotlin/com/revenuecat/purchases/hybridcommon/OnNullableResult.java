package com.revenuecat.purchases.hybridcommon;

import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.util.Map;

public interface OnNullableResult {
    void onReceived(@Nullable Map<String, ?> map);
    void onError(@NotNull ErrorContainer errorContainer);
}