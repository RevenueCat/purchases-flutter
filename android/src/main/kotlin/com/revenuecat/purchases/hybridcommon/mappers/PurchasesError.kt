package com.revenuecat.purchases.hybridcommon.mappers

import com.revenuecat.purchases.PurchasesError
import com.revenuecat.purchases.hybridcommon.ErrorContainer

fun PurchasesError.map(
    extra: Map<String, Any?> = mapOf(),
): ErrorContainer =
    ErrorContainer(
        code.code,
        message,
        mapOf(
            "code" to code.code,
            "message" to message,
            "readableErrorCode" to code.name,
            "readable_error_code" to code.name,
            "underlyingErrorMessage" to (underlyingErrorMessage ?: ""),
        ) + extra,
    )
