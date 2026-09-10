package com.revenuecat.purchases.hybridcommon.mappers

import com.revenuecat.purchases.InternalRevenueCatAPI
import com.revenuecat.purchases.PresentedOfferingContext
import com.revenuecat.purchases.customercenter.CustomerCenterConfigData
import com.revenuecat.purchases.customercenter.events.CustomerCenterDisplayMode
import com.revenuecat.purchases.customercenter.events.CustomerCenterImpressionEvent
import com.revenuecat.purchases.customercenter.events.CustomerCenterSurveyOptionChosenEvent
import com.revenuecat.purchases.paywalls.events.PaywallEvent
import com.revenuecat.purchases.paywalls.events.PaywallEventType
import org.assertj.core.api.Assertions.assertThat
import org.junit.jupiter.api.Test
import java.util.Date
import java.util.UUID

@OptIn(InternalRevenueCatAPI::class)
class FeatureEventMapperTests {

    @Test
    fun `PaywallEvent maps correctly with all expected keys`() {
        // Create a real PaywallEvent instance
        val eventId = UUID.randomUUID()
        val eventDate = Date(1234567890L)
        val sessionId = UUID.randomUUID()

        val paywallEvent = PaywallEvent(
            creationData = PaywallEvent.CreationData(
                id = eventId,
                date = eventDate,
            ),
            data = PaywallEvent.Data(
                presentedOfferingContext = PresentedOfferingContext("test_offering"),
                paywallIdentifier = "test_paywall_id",
                paywallRevision = 5,
                sessionIdentifier = sessionId,
                displayMode = "fullscreen",
                localeIdentifier = "en_US",
                darkMode = false,
            ),
            type = PaywallEventType.IMPRESSION,
        )

        val resultMap = paywallEvent.toMap()

        assertThat(resultMap["discriminator"]).isEqualTo("paywalls")
        assertThat(resultMap["type"]).isEqualTo(PaywallEventType.IMPRESSION.value)
        assertThat(resultMap["id"]).isEqualTo(eventId.toString())
        assertThat(resultMap["timestamp"]).isEqualTo(1234567890L)
        assertThat(resultMap["offering_id"]).isEqualTo("test_offering")
        assertThat(resultMap["paywall_revision"]).isEqualTo(5)
        assertThat(resultMap["session_id"]).isEqualTo(sessionId.toString())
        assertThat(resultMap["display_mode"]).isEqualTo("fullscreen")
        assertThat(resultMap["locale"]).isEqualTo("en_US")
        assertThat(resultMap["dark_mode"]).isEqualTo(false)
    }

    @Test
    fun `PaywallEvent with dark mode enabled maps correctly`() {
        val eventId = UUID.randomUUID()
        val sessionId = UUID.randomUUID()

        val paywallEvent = PaywallEvent(
            creationData = PaywallEvent.CreationData(
                id = eventId,
                date = Date(9876543210L),
            ),
            data = PaywallEvent.Data(
                presentedOfferingContext = PresentedOfferingContext("premium_offering"),
                paywallIdentifier = "test_paywall_id",
                paywallRevision = 10,
                sessionIdentifier = sessionId,
                displayMode = "card",
                localeIdentifier = "es_ES",
                darkMode = true,
            ),
            type = PaywallEventType.CANCEL,
        )

        val resultMap = paywallEvent.toMap()

        assertThat(resultMap["dark_mode"]).isEqualTo(true)
        assertThat(resultMap["type"]).isEqualTo(PaywallEventType.CANCEL.value)
        assertThat(resultMap["offering_id"]).isEqualTo("premium_offering")
        assertThat(resultMap["paywall_revision"]).isEqualTo(10)
        assertThat(resultMap["locale"]).isEqualTo("es_ES")
    }

    @Test
    fun `CustomerCenterImpressionEvent maps correctly with all expected keys`() {
        val eventId = UUID.randomUUID()
        val eventDate = Date(1111111111L)

        val event = CustomerCenterImpressionEvent(
            creationData = CustomerCenterImpressionEvent.CreationData(
                id = eventId,
                date = eventDate,
            ),
            data = CustomerCenterImpressionEvent.Data(
                darkMode = false,
                locale = "en_GB",
                displayMode = CustomerCenterDisplayMode.FULL_SCREEN,
                revisionID = 123,
                timestamp = eventDate,
            ),
        )

        val resultMap = event.toMap()

        assertThat(resultMap["discriminator"]).isEqualTo("customer_center")
        assertThat(resultMap["type"]).isEqualTo("customer_center_impression")
        assertThat(resultMap["id"]).isEqualTo(eventId.toString())
        assertThat(resultMap["timestamp"]).isEqualTo(1111111111L)
        assertThat(resultMap["dark_mode"]).isEqualTo(false)
        assertThat(resultMap["locale"]).isEqualTo("en_GB")
        assertThat(resultMap["display_mode"]).isEqualTo("FULL_SCREEN")
        assertThat(resultMap["revision_id"]).isEqualTo(123)
    }

    @Test
    fun `CustomerCenterSurveyOptionChosenEvent maps correctly with all expected keys`() {
        val eventId = UUID.randomUUID()
        val eventDate = Date(2222222222L)

        val event = CustomerCenterSurveyOptionChosenEvent(
            creationData = CustomerCenterSurveyOptionChosenEvent.CreationData(
                id = eventId,
                date = eventDate,
            ),
            data = CustomerCenterSurveyOptionChosenEvent.Data(
                darkMode = true,
                locale = "fr_FR",
                displayMode = CustomerCenterDisplayMode.FULL_SCREEN,
                surveyOptionID = "option_456",
                path = CustomerCenterConfigData.HelpPath.PathType.CANCEL,
                url = "https://example.com/survey",
                revisionID = 456,
                timestamp = eventDate,
            ),
        )

        val resultMap = event.toMap()

        assertThat(resultMap["discriminator"]).isEqualTo("customer_center")
        assertThat(resultMap["type"]).isEqualTo("customer_center_survey_option_chosen")
        assertThat(resultMap["id"]).isEqualTo(eventId.toString())
        assertThat(resultMap["timestamp"]).isEqualTo(2222222222L)
        assertThat(resultMap["dark_mode"]).isEqualTo(true)
        assertThat(resultMap["locale"]).isEqualTo("fr_FR")
        assertThat(resultMap["display_mode"]).isEqualTo("FULL_SCREEN")
        assertThat(resultMap["survey_option_id"]).isEqualTo("option_456")
        assertThat(resultMap["path"]).isEqualTo("CANCEL")
        assertThat(resultMap["url"]).isEqualTo("https://example.com/survey")
        assertThat(resultMap["revision_id"]).isEqualTo(456)
    }
}
