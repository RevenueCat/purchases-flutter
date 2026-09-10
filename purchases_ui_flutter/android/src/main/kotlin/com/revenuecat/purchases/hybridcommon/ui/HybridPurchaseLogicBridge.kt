package com.revenuecat.purchases.hybridcommon.ui

import android.app.Activity
import android.os.Handler
import android.os.Looper
import android.util.Log
import com.revenuecat.purchases.CustomerInfo
import com.revenuecat.purchases.Package
import com.revenuecat.purchases.PurchasesError
import com.revenuecat.purchases.PurchasesErrorCode
import com.revenuecat.purchases.hybridcommon.mappers.map
import com.revenuecat.purchases.ui.revenuecatui.PurchaseLogic
import com.revenuecat.purchases.ui.revenuecatui.PurchaseLogicResult
import kotlinx.coroutines.CompletableDeferred
import java.util.UUID
import java.util.concurrent.ConcurrentHashMap

class HybridPurchaseLogicBridge(
    private val onPerformPurchase: ((eventData: Map<String, Any?>) -> Unit)?,
    private val onPerformRestore: ((eventData: Map<String, Any?>) -> Unit)?,
) : PurchaseLogic {

    companion object {
        const val EVENT_KEY_REQUEST_ID = "requestId"
        const val EVENT_KEY_PACKAGE_BEING_PURCHASED = "packageBeingPurchased"

        const val RESULT_SUCCESS = "SUCCESS"
        const val RESULT_CANCELLATION = "CANCELLATION"
        const val RESULT_ERROR = "ERROR"

        private const val TAG = "HybridPurchaseLogicBridge"

        private val pendingRequests = ConcurrentHashMap<String, PendingRequest>()

        @JvmStatic
        fun resolveResult(requestId: String, resultString: String, errorMessage: String? = null) {
            val request = pendingRequests.remove(requestId)

            if (request == null) {
                Log.w(
                    TAG,
                    "No pending callback for requestId '$requestId'. " +
                        "It may have already been resolved.",
                )
                return
            }

            val result = when (resultString) {
                RESULT_SUCCESS -> PurchaseLogicResult.Success
                RESULT_CANCELLATION -> PurchaseLogicResult.Cancellation
                RESULT_ERROR -> PurchaseLogicResult.Error(
                    PurchasesError(
                        PurchasesErrorCode.UnknownError,
                        errorMessage ?: "Operation failed",
                    ),
                )
                else -> PurchaseLogicResult.Error(
                    PurchasesError(
                        PurchasesErrorCode.UnknownError,
                        errorMessage ?: "Unknown result: $resultString",
                    ),
                )
            }

            request.deferred.complete(result)
        }
    }

    private sealed class PendingRequest(
        val deferred: CompletableDeferred<PurchaseLogicResult>,
        val owner: HybridPurchaseLogicBridge,
    ) {
        class Purchase(
            deferred: CompletableDeferred<PurchaseLogicResult>,
            owner: HybridPurchaseLogicBridge,
        ) : PendingRequest(deferred, owner)
        class Restore(
            deferred: CompletableDeferred<PurchaseLogicResult>,
            owner: HybridPurchaseLogicBridge,
        ) : PendingRequest(deferred, owner)
    }

    override suspend fun performPurchase(activity: Activity, rcPackage: Package): PurchaseLogicResult {
        val handler = onPerformPurchase
        if (handler == null) {
            Log.w(TAG, "No onPerformPurchase handler registered")
            return PurchaseLogicResult.Error(
                PurchasesError(
                    PurchasesErrorCode.UnknownError,
                    "No onPerformPurchase handler registered",
                ),
            )
        }

        val requestId = UUID.randomUUID().toString()
        val deferred = CompletableDeferred<PurchaseLogicResult>()
        pendingRequests[requestId] = PendingRequest.Purchase(deferred, this)

        val eventData = mapOf<String, Any?>(
            EVENT_KEY_REQUEST_ID to requestId,
            EVENT_KEY_PACKAGE_BEING_PURCHASED to rcPackage.map(),
        )

        Handler(Looper.getMainLooper()).post {
            handler(eventData)
        }

        return deferred.await()
    }

    override suspend fun performRestore(customerInfo: CustomerInfo): PurchaseLogicResult {
        val handler = onPerformRestore
        if (handler == null) {
            Log.w(TAG, "No onPerformRestore handler registered")
            return PurchaseLogicResult.Error(
                PurchasesError(
                    PurchasesErrorCode.UnknownError,
                    "No onPerformRestore handler registered",
                ),
            )
        }

        val requestId = UUID.randomUUID().toString()
        val deferred = CompletableDeferred<PurchaseLogicResult>()
        pendingRequests[requestId] = PendingRequest.Restore(deferred, this)

        val eventData = mapOf<String, Any?>(
            EVENT_KEY_REQUEST_ID to requestId,
        )

        Handler(Looper.getMainLooper()).post {
            handler(eventData)
        }

        return deferred.await()
    }

    fun cancelPending() {
        val iterator = pendingRequests.entries.iterator()
        while (iterator.hasNext()) {
            val entry = iterator.next()
            if (entry.value.owner === this) {
                iterator.remove()
                entry.value.deferred.complete(PurchaseLogicResult.Cancellation)
            }
        }
    }
}
