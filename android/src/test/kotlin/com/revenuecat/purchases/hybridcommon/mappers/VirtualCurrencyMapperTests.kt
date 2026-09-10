package com.revenuecat.purchases.hybridcommon.mappers

import com.revenuecat.purchases.InternalRevenueCatAPI
import com.revenuecat.purchases.virtualcurrencies.VirtualCurrency
import org.assertj.core.api.Assertions.assertThat
import org.junit.jupiter.api.Test

class VirtualCurrencyMapperTests {

    @OptIn(InternalRevenueCatAPI::class)
    @Test
    fun `VirtualCurrency with serverDescription maps to expected map`() {
        val balance = 100
        val name = "Gold"
        val code = "GLD"
        val serverDescription = "Lorem Ipsum"

        val virtualCurrency = VirtualCurrency(
            balance = balance,
            name = name,
            code = code,
            serverDescription = serverDescription,
        )

        val map = virtualCurrency.map()

        assertThat(map.size).isEqualTo(4)
        assertThat(map["balance"]).isEqualTo(balance)
        assertThat(map["name"]).isEqualTo(name)
        assertThat(map["code"]).isEqualTo(code)
        assertThat(map["serverDescription"]).isEqualTo(serverDescription)
    }

    @OptIn(InternalRevenueCatAPI::class)
    @Test
    fun `VirtualCurrency with null serverDescription maps to expected map`() {
        val balance = 100
        val name = "Gold"
        val code = "GLD"
        val serverDescription: String? = null

        val virtualCurrency = VirtualCurrency(
            balance = balance,
            name = name,
            code = code,
            serverDescription = serverDescription,
        )

        val map = virtualCurrency.map()

        assertThat(map.size).isEqualTo(4)
        assertThat(map["balance"]).isEqualTo(balance)
        assertThat(map["name"]).isEqualTo(name)
        assertThat(map["code"]).isEqualTo(code)
        assertThat(map["serverDescription"]).isEqualTo(serverDescription)
    }
}
