package com.revenuecat.purchases.hybridcommon.mappers

import com.revenuecat.purchases.InternalRevenueCatAPI
import com.revenuecat.purchases.virtualcurrencies.VirtualCurrencies
import com.revenuecat.purchases.virtualcurrencies.VirtualCurrency
import org.assertj.core.api.Assertions.assertThat
import org.junit.jupiter.api.Test

class VirtualCurrenciesMapperTest {

    @OptIn(InternalRevenueCatAPI::class)
    @Suppress("UNCHECKED_CAST")
    @Test
    fun `VirtualCurrencies map has the right format when there are VCs`() {
        val virtualCurrency1 = VirtualCurrency(
            balance = 100,
            name = "Coin",
            code = "COIN",
            serverDescription = "Hello world",
        )

        val virtualCurrency2 = VirtualCurrency(
            balance = 100,
            name = "Gem",
            code = "GEM",
            serverDescription = null,
        )

        val virtualCurrencies = VirtualCurrencies(
            all = mapOf(
                virtualCurrency1.code to virtualCurrency1,
                virtualCurrency2.code to virtualCurrency2,
            ),
        )

        val map = virtualCurrencies.map()
        assertThat(map.size).isEqualTo(1)

        val all: Map<String, Any>? = map["all"] as? Map<String, Any>
        assertThat(all).isNotNull()
        assertThat(all!!.size).isEqualTo(2)

        val vc1 = all[virtualCurrency1.code] as? Map<String, Any>
        assertThat(vc1).isNotNull()
        assertThat(vc1!!["balance"]).isEqualTo(virtualCurrency1.balance)
        assertThat(vc1["name"]).isEqualTo(virtualCurrency1.name)
        assertThat(vc1["code"]).isEqualTo(virtualCurrency1.code)
        assertThat(vc1["serverDescription"]).isEqualTo(virtualCurrency1.serverDescription)

        val vc2 = all[virtualCurrency2.code] as? Map<String, Any>
        assertThat(vc2).isNotNull()
        assertThat(vc2!!["balance"]).isEqualTo(virtualCurrency2.balance)
        assertThat(vc2["name"]).isEqualTo(virtualCurrency2.name)
        assertThat(vc2["code"]).isEqualTo(virtualCurrency2.code)
        assertThat(vc2["serverDescription"]).isNull()
    }

    @OptIn(InternalRevenueCatAPI::class)
    @Suppress("UNCHECKED_CAST")
    @Test
    fun `VirtualCurrencies map has the right format when there are no VCs`() {
        val virtualCurrencies = VirtualCurrencies(all = emptyMap())

        val map = virtualCurrencies.map()

        assertThat(map.size).isEqualTo(1)

        val all: Map<String, Any>? = map["all"] as? Map<String, Any>
        assertThat(all).isNotNull()
        assertThat(all!!.isEmpty()).isTrue()
    }
}
