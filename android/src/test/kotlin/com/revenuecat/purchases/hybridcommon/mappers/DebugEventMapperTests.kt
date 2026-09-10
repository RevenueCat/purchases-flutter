package com.revenuecat.purchases.hybridcommon.mappers

import com.revenuecat.purchases.DebugEvent
import com.revenuecat.purchases.DebugEventName
import com.revenuecat.purchases.InternalRevenueCatAPI
import org.assertj.core.api.Assertions.assertThat
import org.junit.jupiter.api.Test

@OptIn(InternalRevenueCatAPI::class)
class DebugEventMapperTests {

    @Test
    fun `Debug maps correctly with all expected keys`() {
        // Create a real PaywallEvent instance
        val debugEvent = DebugEvent(
            name = DebugEventName.FLUSH_STARTED,
            properties = mapOf(
                "test1" to "testvalue1",
                "test2" to "testvalue2",
            ),
        )

        val resultMap = debugEvent.toMap()

        assertThat(resultMap["type"]).isEqualTo(DebugEventName.FLUSH_STARTED.name)
        assertThat(resultMap["test1"]).isEqualTo("testvalue1")
        assertThat(resultMap["test2"]).isEqualTo("testvalue2")
    }
}
