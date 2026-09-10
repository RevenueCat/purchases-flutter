package com.revenuecat.purchases.hybridcommon

import com.revenuecat.purchases.PurchasesError
import com.revenuecat.purchases.PurchasesErrorCode
import com.revenuecat.purchases.hybridcommon.mappers.map
import com.revenuecat.purchases.hybridcommon.mappers.toMillis
import org.assertj.core.api.Assertions.assertThat
import org.junit.jupiter.api.Test
import java.text.SimpleDateFormat
import java.util.*

internal class MappersTests {

    @Test
    fun `parsing simple date format returns the correct date`() {
        val dateFormat = SimpleDateFormat("dd-MM-yyyy")
        dateFormat.timeZone = TimeZone.getTimeZone("UTC")

        val date1: Date? = dateFormat.parse("14-01-2021")
        assertThat(date1?.toMillis()).isEqualTo(1610582400000L)

        val date2: Date? = dateFormat.parse("03-03-2019")
        assertThat(date2?.toMillis()).isEqualTo(1551571200000L)

        val date3: Date? = dateFormat.parse("31-07-1990")
        assertThat(date3?.toMillis()).isEqualTo(649382400000L)
    }

    @Test
    fun `purchasesErrors are mapped correctly`() {
        PurchasesErrorCode.values().forEach { errorCode ->
            val error = PurchasesError(errorCode, "")
            val errorContainer = error.map()

            assertThat(errorContainer.code).isEqualTo(errorCode.code)
        }
    }
}
