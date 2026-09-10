package com.revenuecat.purchases.hybridcommon

import com.revenuecat.purchases.hybridcommon.mappers.map
import org.assertj.core.api.Assertions.assertThat
import org.junit.jupiter.api.Test

internal class StoreTransactionMapperTests {

    @Test
    fun `Google purchase includes purchaseToken`() {
        val transaction = TestUtilities.createMockTransaction(
            productIdentifier = "product_id",
            transactionIdentifier = "order_id",
            purchaseDate = 1000L,
            purchaseToken = "google_purchase_token",
            signature = "google_signature",
            originalJson = """{"orderId":"order_id"}""",
        )
        val mapped = transaction.map()

        assertThat(mapped["purchaseToken"]).isEqualTo("google_purchase_token")
        assertThat(mapped["transactionIdentifier"]).isEqualTo("order_id")
        assertThat(mapped["productIdentifier"]).isEqualTo("product_id")
        assertThat(mapped["purchaseDateMillis"]).isEqualTo(1000L)
        assertThat(mapped["purchaseDate"]).isNotNull
        assertThat(mapped["signature"]).isEqualTo("google_signature")
        assertThat(mapped["originalJson"]).isEqualTo("""{"orderId":"order_id"}""")
    }

    @Test
    fun `Amazon purchase includes purchaseToken as receiptId`() {
        val transaction = TestUtilities.createMockAmazonTransaction(
            productIdentifier = "product_id",
            receiptId = "amazon_receipt_id",
            purchaseDate = 2000L,
        )
        val mapped = transaction.map()

        assertThat(mapped["purchaseToken"]).isEqualTo("amazon_receipt_id")
        assertThat(mapped["transactionIdentifier"]).isEqualTo("amazon_receipt_id")
        assertThat(mapped["productIdentifier"]).isEqualTo("product_id")
        assertThat(mapped["purchaseDateMillis"]).isEqualTo(2000L)
        assertThat(mapped["signature"]).isNull()
        assertThat(mapped["originalJson"]).isEqualTo("""{"receiptId":"amazon_receipt_id"}""")
    }
}
