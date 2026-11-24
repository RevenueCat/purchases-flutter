package com.revenuecat.purchases_ui_flutter

import com.revenuecat.purchases.hybridcommon.ui.CheckpointListener
import com.revenuecat.purchases.hybridcommon.ui.detachCheckpoint
import com.revenuecat.purchases.hybridcommon.ui.invalidateCheckpointPresentations
import com.revenuecat.purchases.hybridcommon.ui.presentCheckpoint
import com.revenuecat.purchases.ui.revenuecatui.InviteOnlyCheckpointsAPI
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.mockk.every
import io.mockk.just
import io.mockk.mockk
import io.mockk.mockkStatic
import io.mockk.runs
import io.mockk.slot
import io.mockk.unmockkStatic
import io.mockk.verify
import org.junit.After
import org.junit.Before
import org.junit.Test

@OptIn(InviteOnlyCheckpointsAPI::class)
class CheckpointHandlerTest {
    private val listener = slot<CheckpointListener>()
    private val result = mockk<MethodChannel.Result>(relaxed = true)

    @Before
    fun setUp() {
        mockkStatic(::presentCheckpoint)
        every { presentCheckpoint(any(), any(), any(), any(), any(), any(), capture(listener)) } just runs
        every { detachCheckpoint(any(), any()) } just runs
        every { invalidateCheckpointPresentations() } just runs
    }

    @After
    fun tearDown() = unmockkStatic(::presentCheckpoint)

    private fun handler() = CheckpointHandler(mockk(relaxed = true))

    private fun present(handler: CheckpointHandler, callId: String) {
        handler.present(MethodCall("checkpoint", mapOf("callId" to callId, "identifier" to "test")), result)
    }

    @Test
    fun backgroundEngineResetAndDisposalOnlyDetachItsOwnCalls() {
        val foreground = handler()
        val background = handler()
        present(foreground, "foreground")
        val foregroundListener = listener.captured
        present(background, "before restart")
        background.onMethodCall(MethodCall("initialize", null), result)
        present(background, "after restart")
        background.dispose()

        verify(exactly = 1) { detachCheckpoint("before restart", null) }
        verify(exactly = 1) { detachCheckpoint("after restart", null) }
        verify(exactly = 0) { detachCheckpoint("foreground", any()) }
        verify(exactly = 0) { invalidateCheckpointPresentations() }

        foregroundListener.onCheckpointPassed(emptyMap())
        foreground.dispose()
        verify { result.success(emptyMap<String, Any?>()) }
        verify(exactly = 0) { detachCheckpoint("foreground", any()) }
    }

    @Test
    fun engineDisposalCancelsPaywallPreservedByScreenDetach() {
        val engine = handler()
        present(engine, "call")
        listener.captured.onPaywallPresentationRequested("request", emptyMap())
        val detach = MethodCall("detachCheckpoint", mapOf("callId" to "call", "activePaywallRequestId" to "request"))
        engine.onMethodCall(detach, result)
        verify { detachCheckpoint("call", "request") }
        engine.dispose()
        verify { detachCheckpoint("call", null) }
    }
}
