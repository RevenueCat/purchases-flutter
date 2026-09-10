package com.revenuecat.purchases.hybridcommon

import com.revenuecat.purchases.hybridcommon.mappers.PurchasesPeriod
import org.assertj.core.api.Assertions.assertThat
import org.junit.jupiter.api.Test

internal class PurchasesPeriodTests {

    @Test
    fun `when parsing an invalid PurchasesPeriod, there is no exception`() {
        mockLogs()

        val period = PurchasesPeriod.parse("365")
        assertThat(period).isNull()
    }

    @Test
    fun `when parsing a valid PurchasesPeriod, period is not null`() {
        val period = PurchasesPeriod.parse("P1D")
        assertThat(period).isNotNull
    }
}
