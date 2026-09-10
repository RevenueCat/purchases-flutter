package com.revenuecat.purchases.hybridcommon

import android.util.Log
import com.revenuecat.purchases.CustomerInfo
import com.revenuecat.purchases.Offerings
import com.revenuecat.purchases.hybridcommon.mappers.mapAsync
import io.mockk.every
import io.mockk.mockkStatic
import kotlinx.coroutines.runBlocking
import kotlin.coroutines.resume
import kotlin.coroutines.suspendCoroutine

fun mockLogs() {
    mockkStatic(Log::class)
    every { Log.v(any(), any()) } returns 0
    every { Log.d(any(), any()) } returns 0
    every { Log.i(any(), any()) } returns 0
    every { Log.w(any(), any<String>()) } returns 0
    every { Log.w(any(), any<Throwable>()) } returns 0
    every { Log.e(any(), any()) } returns 0
}

fun CustomerInfo.mapBlocking(): Map<String, Any?> = runBlocking {
    suspendCoroutine { continuation ->
        mapAsync { map ->
            continuation.resume(map)
        }
    }
}

fun Offerings.mapBlocking(): Map<String, Any?> = runBlocking {
    suspendCoroutine { continuation ->
        mapAsync { map ->
            continuation.resume(map)
        }
    }
}
