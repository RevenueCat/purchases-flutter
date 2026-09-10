package com.revenuecat.purchases.hybridcommon

import android.app.Application
import android.content.Context
import com.revenuecat.purchases.DangerousSettings
import com.revenuecat.purchases.EntitlementVerificationMode
import com.revenuecat.purchases.ExperimentalPreviewRevenueCatPurchasesAPI
import com.revenuecat.purchases.Purchases
import com.revenuecat.purchases.PurchasesAreCompletedBy
import com.revenuecat.purchases.PurchasesConfiguration
import com.revenuecat.purchases.Store
import com.revenuecat.purchases.common.PlatformInfo
import com.revenuecat.purchases.galaxy.GalaxyBillingMode
import io.mockk.CapturingSlot
import io.mockk.every
import io.mockk.mockk
import io.mockk.mockkObject
import io.mockk.slot
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import kotlin.test.assertEquals
import kotlin.test.assertTrue

@OptIn(ExperimentalPreviewRevenueCatPurchasesAPI::class)
internal class ConfiguringUnitTests {
    private val mockPurchases = mockk<Purchases>()
    private val mockContext = mockk<Context>(relaxed = true)
    private val mockApplicationContext = mockk<Application>(relaxed = true)
    private val expectedPlatformInfo = PlatformInfo("flavor", "version")
    private val purchasesConfigurationSlot = slot<PurchasesConfiguration>()

    @BeforeEach
    fun setup() {
        every { mockContext.applicationContext } returns mockApplicationContext
        mockkObject(Purchases)
        every {
            Purchases.configure(any())
        } returns mockPurchases
        every {
            Purchases.configure(configuration = capture(purchasesConfigurationSlot))
        } returns mockPurchases

        mockLogs()
    }

    @Test
    fun `calling configure with observer mode false should configure the Android SDK with observer mode false`() {
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.REVENUECAT.name,
            platformInfo = expectedPlatformInfo,
            store = Store.PLAY_STORE,
        )
        assertConfiguration(
            purchasesConfigurationSlot,
            expectedContext = mockApplicationContext,
            expectedApiKey = "api_key",
            expectedAppUserID = "appUserID",
            expectedPurchasesAreCompletedBy = PurchasesAreCompletedBy.REVENUECAT,
        )
    }

    @Test
    fun `calling configure with observer mode true, should configure the Android SDK with observer mode true`() {
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.MY_APP.name,
            platformInfo = expectedPlatformInfo,
            store = Store.PLAY_STORE,
        )
        assertConfiguration(
            purchasesConfigurationSlot,
            expectedContext = mockApplicationContext,
            expectedApiKey = "api_key",
            expectedAppUserID = "appUserID",
            expectedPurchasesAreCompletedBy = PurchasesAreCompletedBy.MY_APP,
        )
    }

    @Test
    fun `calling configure with null expectedPurchasesAreCompletedBy configures the Android SDK`() {
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = null,
            platformInfo = expectedPlatformInfo,
            store = Store.PLAY_STORE,
        )
        assertConfiguration(
            purchasesConfigurationSlot,
            expectedContext = mockApplicationContext,
            expectedApiKey = "api_key",
            expectedAppUserID = "appUserID",
            expectedPurchasesAreCompletedBy = PurchasesAreCompletedBy.REVENUECAT,
        )
    }

    @Test
    fun `calling configure with a null app user ID, should configure the Android SDK with null app user ID`() {
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = null,
            platformInfo = expectedPlatformInfo,
            store = Store.PLAY_STORE,
        )
        assertConfiguration(
            purchasesConfigurationSlot,
            expectedContext = mockApplicationContext,
            expectedApiKey = "api_key",
            expectedAppUserID = null,
            expectedPurchasesAreCompletedBy = PurchasesAreCompletedBy.REVENUECAT,
        )
    }

    @Test
    fun `calling configure with a platform info, should configure the Android SDK with that platform info`() {
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.REVENUECAT.name,
            platformInfo = expectedPlatformInfo,
            store = Store.PLAY_STORE,
        )

        assertEquals(expectedPlatformInfo, Purchases.platformInfo)
    }

    @Test
    fun `calling configure with no verification mode`() {
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.REVENUECAT.name,
            platformInfo = expectedPlatformInfo,
            verificationMode = null,
        )
        assertEquals(EntitlementVerificationMode.INFORMATIONAL, purchasesConfigurationSlot.captured.verificationMode)
    }

    @Test
    fun `calling configure with verification mode disabled`() {
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.REVENUECAT.name,
            platformInfo = expectedPlatformInfo,
            verificationMode = "DISABLED",
        )
        assertEquals(EntitlementVerificationMode.DISABLED, purchasesConfigurationSlot.captured.verificationMode)
    }

    @Test
    fun `calling configure with verification mode informational`() {
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.REVENUECAT.name,
            platformInfo = expectedPlatformInfo,
            verificationMode = "INFORMATIONAL",
        )
        assertEquals(EntitlementVerificationMode.INFORMATIONAL, purchasesConfigurationSlot.captured.verificationMode)
    }

    @Test
    fun `calling configure with verification mode enforced`() {
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.REVENUECAT.name,
            platformInfo = expectedPlatformInfo,
            verificationMode = "ENFORCED",
        )
        // Enforced is not available yet
        assertEquals(EntitlementVerificationMode.INFORMATIONAL, purchasesConfigurationSlot.captured.verificationMode)
    }

    @Test
    fun `calling configure without dangerous settings defaults to autosync on`() {
        val expectedDangerousSettings = DangerousSettings(autoSyncPurchases = true)
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.REVENUECAT.name,
            platformInfo = expectedPlatformInfo,
            store = Store.PLAY_STORE,
        )
        assertEquals(expectedDangerousSettings, purchasesConfigurationSlot.captured.dangerousSettings)
    }

    @Test
    fun `calling configure passing dangerous settings on`() {
        val expectedDangerousSettings = DangerousSettings(autoSyncPurchases = false)
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.REVENUECAT.name,
            platformInfo = expectedPlatformInfo,
            store = Store.PLAY_STORE,
            dangerousSettings = expectedDangerousSettings,
        )
        assertEquals(expectedDangerousSettings, purchasesConfigurationSlot.captured.dangerousSettings)
    }

    @Test
    fun `calling configure passing preferred locale with es-ES`() {
        val expectedLocale = "es-ES"
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.REVENUECAT.name,
            platformInfo = expectedPlatformInfo,
            store = Store.PLAY_STORE,
            preferredLocale = expectedLocale,
        )
        assertEquals(expectedLocale, purchasesConfigurationSlot.captured.preferredUILocaleOverride)
    }

    @Test
    fun `calling configure with Galaxy store configures the Android SDK with Galaxy store`() {
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.REVENUECAT.name,
            platformInfo = expectedPlatformInfo,
            store = Store.GALAXY,
        )
        assertEquals(Store.GALAXY, purchasesConfigurationSlot.captured.store)
    }

    @Test
    fun `calling configure with Galaxy store defaults Galaxy billing mode to production`() {
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.REVENUECAT.name,
            platformInfo = expectedPlatformInfo,
            store = Store.GALAXY,
        )
        assertEquals(GalaxyBillingMode.PRODUCTION, purchasesConfigurationSlot.captured.galaxyBillingMode)
    }

    @Test
    fun `calling configure with Galaxy billing mode test forwards it to Android SDK`() {
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.REVENUECAT.name,
            platformInfo = expectedPlatformInfo,
            store = Store.GALAXY,
            galaxyBillingMode = "TEST",
        )
        assertEquals(GalaxyBillingMode.TEST, purchasesConfigurationSlot.captured.galaxyBillingMode)
    }

    @Test
    fun `calling configure with Galaxy billing mode always fail forwards it to Android SDK`() {
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.REVENUECAT.name,
            platformInfo = expectedPlatformInfo,
            store = Store.GALAXY,
            galaxyBillingMode = "ALWAYS_FAIL",
        )
        assertEquals(GalaxyBillingMode.ALWAYS_FAIL, purchasesConfigurationSlot.captured.galaxyBillingMode)
    }

    @Test
    fun `calling configure with unknown Galaxy billing mode defaults to production`() {
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.REVENUECAT.name,
            platformInfo = expectedPlatformInfo,
            store = Store.GALAXY,
            galaxyBillingMode = "UNKNOWN",
        )
        assertEquals(GalaxyBillingMode.PRODUCTION, purchasesConfigurationSlot.captured.galaxyBillingMode)
    }

    private fun assertConfiguration(
        purchasesConfigurationSlot: CapturingSlot<PurchasesConfiguration>,
        expectedContext: Context,
        expectedApiKey: String,
        expectedAppUserID: String?,
        expectedPurchasesAreCompletedBy: PurchasesAreCompletedBy,
    ) {
        assertTrue(purchasesConfigurationSlot.isCaptured)
        purchasesConfigurationSlot.captured.let { captured ->
            assertEquals(expectedContext, captured.context)
            assertEquals(expectedApiKey, captured.apiKey)
            assertEquals(expectedAppUserID, captured.appUserID)
            assertEquals(expectedPurchasesAreCompletedBy, captured.purchasesAreCompletedBy)
        }
    }
}
