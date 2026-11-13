package com.revenuecat.purchases_ui_flutter

import com.revenuecat.purchases.hybridcommon.ui.CheckpointListener
import com.revenuecat.purchases.hybridcommon.ui.presentCheckpoint
import com.revenuecat.purchases.ui.revenuecatui.InviteOnlyCheckpointsAPI
import io.flutter.plugin.common.MethodChannel.Result
import java.util.UUID

internal class CheckpointHandler {
    @OptIn(InviteOnlyCheckpointsAPI::class)
    fun present(
        result: Result,
        identifier: String?,
        customVariables: Map<String, Any?>?,
        presentationMode: String?,
    ) {
        if (identifier == null) {
            result.error("BAD_ARGS", "Missing identifier in checkpoint", null)
            return
        }
        val flutterResult = result
        // Replies at most once, and only when the checkpoint passes: backing out never invokes the callback.
        presentCheckpoint(
            identifier = identifier,
            callId = UUID.randomUUID().toString(),
            customVariables = customVariables,
            presentationMode = presentationMode,
            useCustomPaywallPresenter = false,
            hasErrorDialogFactory = false,
            listener = object : CheckpointListener {
                override fun onCheckpointPassed(result: Map<String, Any?>) {
                    flutterResult.success(result)
                }

                override fun onCheckpointError(code: String, message: String) {
                    flutterResult.error(code, message, null)
                }
            },
        )
    }
}
