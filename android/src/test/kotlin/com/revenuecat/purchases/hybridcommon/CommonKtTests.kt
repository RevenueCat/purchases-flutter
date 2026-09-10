package com.revenuecat.purchases.hybridcommon

import android.app.Activity
import android.app.Application
import android.content.Context
import android.content.Intent
import android.net.Uri
import com.android.billingclient.api.ProductDetails
import com.revenuecat.purchases.CustomerInfo
import com.revenuecat.purchases.ExperimentalPreviewRevenueCatPurchasesAPI
import com.revenuecat.purchases.InternalRevenueCatAPI
import com.revenuecat.purchases.LogLevel
import com.revenuecat.purchases.Offering
import com.revenuecat.purchases.Offerings
import com.revenuecat.purchases.Package
import com.revenuecat.purchases.PackageType
import com.revenuecat.purchases.PresentedOfferingContext
import com.revenuecat.purchases.ProductType
import com.revenuecat.purchases.PurchaseParams
import com.revenuecat.purchases.Purchases
import com.revenuecat.purchases.PurchasesAreCompletedBy
import com.revenuecat.purchases.PurchasesError
import com.revenuecat.purchases.PurchasesErrorCode
import com.revenuecat.purchases.Store
import com.revenuecat.purchases.WebPurchaseRedemption
import com.revenuecat.purchases.common.PlatformInfo
import com.revenuecat.purchases.hybridcommon.mappers.MappedProductCategory
import com.revenuecat.purchases.hybridcommon.mappers.map
import com.revenuecat.purchases.hybridcommon.mappers.overrideMapperDispatcher
import com.revenuecat.purchases.interfaces.Callback
import com.revenuecat.purchases.interfaces.GetStoreProductsCallback
import com.revenuecat.purchases.interfaces.GetStorefrontCallback
import com.revenuecat.purchases.interfaces.GetVirtualCurrenciesCallback
import com.revenuecat.purchases.interfaces.LogInCallback
import com.revenuecat.purchases.interfaces.PurchaseCallback
import com.revenuecat.purchases.interfaces.ReceiveCustomerInfoCallback
import com.revenuecat.purchases.interfaces.ReceiveOfferingsCallback
import com.revenuecat.purchases.interfaces.RedeemWebPurchaseListener
import com.revenuecat.purchases.models.BillingFeature
import com.revenuecat.purchases.models.GoogleReplacementMode
import com.revenuecat.purchases.models.GoogleStoreProduct
import com.revenuecat.purchases.models.Price
import com.revenuecat.purchases.models.PurchasingData
import com.revenuecat.purchases.models.StoreProduct
import com.revenuecat.purchases.models.StoreReplacementMode
import com.revenuecat.purchases.models.SubscriptionOption
import com.revenuecat.purchases.models.SubscriptionOptions
import com.revenuecat.purchases.virtualcurrencies.VirtualCurrencies
import com.revenuecat.purchases.virtualcurrencies.VirtualCurrency
import io.mockk.Runs
import io.mockk.every
import io.mockk.just
import io.mockk.mockk
import io.mockk.mockkConstructor
import io.mockk.mockkObject
import io.mockk.mockkStatic
import io.mockk.runs
import io.mockk.slot
import io.mockk.unmockkConstructor
import io.mockk.unmockkStatic
import io.mockk.verify
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.test.UnconfinedTestDispatcher
import kotlinx.coroutines.test.resetMain
import kotlinx.coroutines.test.setMain
import org.assertj.core.api.Assertions
import org.assertj.core.api.Assertions.assertThat
import org.junit.jupiter.api.AfterEach
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.RepeatedTest
import org.junit.jupiter.api.Test
import java.net.URL
import kotlin.random.Random
import kotlin.test.assertEquals
import kotlin.test.assertFailsWith
import kotlin.test.assertIs
import kotlin.test.assertNotNull
import kotlin.test.assertNull
import kotlin.test.assertTrue
import kotlin.test.fail

@OptIn(ExperimentalCoroutinesApi::class)
internal class CommonKtTests {

    private val mockApplicationContext = mockk<Application>(relaxed = true)
    private val mockContext = mockk<Context>(relaxed = true)
    private val mockPurchases = mockk<Purchases>()
    private val mockActivity = mockk<Activity>(relaxed = true)

    @BeforeEach
    fun setup() {
        mockLogs()
        mockkObject(Purchases)
        every {
            Purchases.configure(configuration = any())
        } returns mockPurchases
        every { mockContext.applicationContext } returns mockApplicationContext
        every { Purchases.sharedInstance } returns mockPurchases
        every { mockPurchases.store } returns Store.PLAY_STORE
        val testDispatcher = UnconfinedTestDispatcher()
        overrideMapperDispatcher = testDispatcher
        Dispatchers.setMain(testDispatcher)
    }

    @AfterEach
    fun teardown() {
        Dispatchers.resetMain()
    }

    @Test
    fun `Calling setProxyURLString, sets the proxyURL correctly from a valid URL`() {
        assertEquals(Purchases.proxyURL, null)

        val urlString = "https://revenuecat.com"
        setProxyURLString(urlString)

        assertEquals(Purchases.proxyURL.toString(), urlString)
    }

    @Test
    fun `Calling setProxyURLString, sets the proxyURL to null from a null string`() {
        Purchases.proxyURL = URL("https://revenuecat.com")

        setProxyURLString(null)

        assertEquals(Purchases.proxyURL, null)
    }

    @Test
    fun `Calling setProxyURLString, raises exception if url string can't be parsed into a URL`() {
        assertFailsWith<java.net.MalformedURLException> {
            setProxyURLString("this is not a url")
        }
    }

    @RepeatedTest(5)
    fun `canMakePayments result successfully passed back`() {
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.MY_APP.name,
            platformInfo = PlatformInfo("flavor", "version"),
        )

        val receivedCanMakePayments = Random.nextBoolean()

        val capturedCallback = slot<Callback<Boolean>>()
        every {
            Purchases.canMakePayments(mockContext, listOf(), capture(capturedCallback))
        } answers {
            capturedCallback.captured.also {
                it.onReceived(receivedCanMakePayments)
            }
        }

        val onResult = mockk<OnResultAny<Boolean>>()
        val returnedResult = slot<Boolean>()
        every { onResult.onReceived(capture(returnedResult)) } just runs

        canMakePayments(
            mockContext,
            listOf(),
            onResult,
        )

        assertEquals(receivedCanMakePayments, returnedResult.captured)
    }

    @Test
    fun `calling canMakePayments with empty list correctly passes through to Purchases`() {
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.MY_APP.name,
            platformInfo = PlatformInfo("flavor", "version"),
        )

        every {
            Purchases.canMakePayments(mockContext, any(), any())
        } just Runs

        val onResult = mockk<OnResultAny<Boolean>>()
        every { onResult.onReceived(any()) } just Runs

        canMakePayments(
            mockContext,
            listOf(),
            onResult,
        )

        verify(exactly = 1) {
            Purchases.canMakePayments(
                mockContext,
                listOf(),
                any(),
            )
        }
    }

    @Test
    fun `canMakePayments correctly maps all integer values to BillingFeature enum type`() {
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.MY_APP.name,
            platformInfo = PlatformInfo("flavor", "version"),
        )

        every { Purchases.canMakePayments(mockContext, any(), any()) } just runs

        val onResult = mockk<OnResultAny<Boolean>>()
        every { onResult.onReceived(any()) } just runs

        val billingFeatureValues = BillingFeature.values()

        billingFeatureValues.forEachIndexed { index, billingFeature ->
            canMakePayments(
                mockContext,
                listOf(index),
                onResult,
            )

            verify(exactly = 1) {
                Purchases.canMakePayments(
                    mockContext,
                    listOf(billingFeature),
                    any(),
                )
            }
        }
    }

    @Test
    fun `calling canMakePayments with invalid integer results in error`() {
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.MY_APP.name,
            platformInfo = PlatformInfo("flavor", "version"),
        )

        every { Purchases.canMakePayments(mockContext, any(), any()) } just runs

        val onResultAny = mockk<OnResultAny<Boolean>>()
        every { onResultAny.onError(any()) } just runs

        canMakePayments(
            mockContext,
            listOf(8),
            onResultAny,
        )

        verify(exactly = 1) {
            onResultAny.onError(any())
        }
    }

    @Test
    fun `calling getStorefront correctly passes call to Purchases`() {
        val callback = slot<GetStorefrontCallback>()
        every { mockPurchases.getStorefrontCountryCode(capture(callback)) } just Runs

        var receivedStorefront: Map<String, *>? = null

        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.MY_APP.name,
            platformInfo = PlatformInfo("flavor", "version"),
        )

        // Calling with a success return value returns value correctly
        getStorefront {
            receivedStorefront = it
        }
        callback.captured.onReceived("USA")

        Assertions.assertThat(receivedStorefront).isEqualTo(mapOf("countryCode" to "USA"))
        verify(exactly = 1) { mockPurchases.getStorefrontCountryCode(any()) }

        // Calling with a failure return value returns null
        getStorefront {
            receivedStorefront = it
        }
        callback.captured.onError(PurchasesError(PurchasesErrorCode.UnknownError))

        Assertions.assertThat(receivedStorefront).isEqualTo(null)
        verify(exactly = 2) { mockPurchases.getStorefrontCountryCode(any()) }
    }

    @Test
    fun `calling logIn correctly passes call to Purchases`() {
        val appUserID = "appUserID"

        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.MY_APP.name,
            platformInfo = PlatformInfo("flavor", "version"),
        )

        every { mockPurchases.logIn(appUserID, any()) } just runs

        logIn(
            appUserID = appUserID,
            onResult = object : OnResult {
                override fun onReceived(map: Map<String, *>) {}
                override fun onError(errorContainer: ErrorContainer) {}
            },
        )

        verify(exactly = 1) { mockPurchases.logIn(appUserID, any()) }
    }

    @Test
    fun `calling logIn correctly calls onReceived`() {
        val appUserID = "appUserID"

        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.MY_APP.name,
            platformInfo = PlatformInfo("flavor", "version"),
        )

        val mockInfo = mockk<CustomerInfo>(relaxed = true)
        val mockCreated = Random.nextBoolean()

        val logInCallback = slot<LogInCallback>()
        every {
            mockPurchases.logIn(
                newAppUserID = appUserID,
                capture(logInCallback),
            )
        } just runs

        val onResult = mockk<OnResult>(relaxed = true)

        logIn(appUserID = appUserID, onResult = onResult)
        logInCallback.captured.onReceived(mockInfo, mockCreated)

        val mockInfoMap = mockInfo.mapBlocking()

        verify(exactly = 1) {
            onResult.onReceived(
                mapOf(
                    "created" to mockCreated,
                    "customerInfo" to mockInfoMap,
                ),
            )
        }
    }

    @Test
    fun `calling logIn with error calls onError`() {
        val appUserID = "appUserID"

        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.MY_APP.name,
            platformInfo = PlatformInfo("flavor", "version"),
        )

        val mockError = mockk<PurchasesError>(relaxed = true)

        val logInCallback = slot<LogInCallback>()
        every {
            mockPurchases.logIn(
                newAppUserID = appUserID,
                capture(logInCallback),
            )
        } just runs

        val onResult = mockk<OnResult>()
        every { onResult.onReceived(any()) } just runs
        every { onResult.onError(any()) } just runs

        logIn(appUserID = appUserID, onResult = onResult)
        logInCallback.captured.onError(mockError)

        val mockErrorMap = mockError.map()
        verify(exactly = 1) {
            onResult.onError(mockErrorMap)
        }
    }

    @OptIn(ExperimentalPreviewRevenueCatPurchasesAPI::class)
    @Test
    fun `redeemWebPurchase with error result emits a serializable error map, not an ErrorContainer`() {
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.MY_APP.name,
            platformInfo = PlatformInfo("flavor", "version"),
        )

        mockkStatic(Uri::class)
        every { Uri.parse(any()) } returns mockk(relaxed = true)
        mockkConstructor(Intent::class)

        val mockRedemption = mockk<WebPurchaseRedemption>()
        every { Purchases.parseAsWebPurchaseRedemption(any<Intent>()) } returns mockRedemption

        val listenerSlot = slot<RedeemWebPurchaseListener>()
        every { mockPurchases.redeemWebPurchase(any(), capture(listenerSlot)) } just runs

        val mockError = mockk<PurchasesError>(relaxed = true)

        val capturedMap = slot<Map<String, *>>()
        val onResult = mockk<OnResult>()
        every { onResult.onReceived(capture(capturedMap)) } just runs
        every { onResult.onError(any()) } just runs

        try {
            redeemWebPurchase(
                urlString = "https://revenuecat.com/redeem?redemption_token=token",
                onResult = onResult,
            )
            listenerSlot.captured.handleResult(RedeemWebPurchaseListener.Result.Error(mockError))

            val receivedMap = capturedMap.captured
            assertThat(receivedMap["result"]).isEqualTo("ERROR")
            // Regression: the error value must be the flat, serializable info map (as consumers parse),
            // never an ErrorContainer object, which platform codecs cannot encode (crash).
            assertThat(receivedMap["error"]).isInstanceOf(Map::class.java)
            assertThat(receivedMap["error"]).isEqualTo(mockError.map().info)
            verify(exactly = 0) { onResult.onError(any()) }
        } finally {
            unmockkConstructor(Intent::class)
            unmockkStatic(Uri::class)
        }
    }

    @OptIn(ExperimentalPreviewRevenueCatPurchasesAPI::class)
    @Test
    fun `redeemWebPurchase with invalid URL calls onError`() {
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.MY_APP.name,
            platformInfo = PlatformInfo("flavor", "version"),
        )

        mockkStatic(Uri::class)
        every { Uri.parse(any()) } returns mockk(relaxed = true)
        mockkConstructor(Intent::class)
        every { Purchases.parseAsWebPurchaseRedemption(any<Intent>()) } returns null

        val onResult = mockk<OnResult>()
        val errorSlot = slot<ErrorContainer>()
        every { onResult.onReceived(any()) } just runs
        every { onResult.onError(capture(errorSlot)) } just runs

        try {
            redeemWebPurchase(urlString = "not a valid url", onResult = onResult)

            verify(exactly = 1) { onResult.onError(any()) }
            verify(exactly = 0) { onResult.onReceived(any()) }
            assertThat(errorSlot.captured.code).isEqualTo(PurchasesErrorCode.UnsupportedError.code)
        } finally {
            unmockkConstructor(Intent::class)
            unmockkStatic(Uri::class)
        }
    }

    @Test
    fun `calling logOut correctly passes call to Purchases`() {
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.MY_APP.name,
            platformInfo = PlatformInfo("flavor", "version"),
        )

        every { mockPurchases.logOut(any() as ReceiveCustomerInfoCallback?) } just runs

        logOut(
            onResult = object : OnResult {
                override fun onReceived(map: Map<String, *>) {}
                override fun onError(errorContainer: ErrorContainer) {}
            },
        )

        verify(exactly = 1) { mockPurchases.logOut(any() as ReceiveCustomerInfoCallback?) }
    }

    @Test
    fun `calling logOut correctly calls onReceived`() {
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.MY_APP.name,
            platformInfo = PlatformInfo("flavor", "version"),
        )

        val mockInfo = mockk<CustomerInfo>(relaxed = true)
        val receiveCustomerInfoListener = slot<ReceiveCustomerInfoCallback>()

        every { mockPurchases.logOut(capture(receiveCustomerInfoListener)) } just runs
        val onResult = mockk<OnResult>()
        every { onResult.onReceived(any()) } just runs
        every { onResult.onError(any()) } just runs

        logOut(onResult)

        receiveCustomerInfoListener.captured.onReceived(mockInfo)

        val mockInfoMap = mockInfo.mapBlocking()
        verify(exactly = 1) { onResult.onReceived(mockInfoMap) }
    }

    @Test
    fun `calling logOut with error calls onError`() {
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.MY_APP.name,
            platformInfo = PlatformInfo("flavor", "version"),
        )

        val mockError = mockk<PurchasesError>(relaxed = true)
        val receiveCustomerInfoListener = slot<ReceiveCustomerInfoCallback>()

        every { mockPurchases.logOut(capture(receiveCustomerInfoListener)) } just runs
        val onResult = mockk<OnResult>()
        every { onResult.onReceived(any()) } just runs
        every { onResult.onError(any()) } just runs

        logOut(onResult)

        receiveCustomerInfoListener.captured.onError(mockError)

        val mockErrorMap = mockError.map()
        verify(exactly = 1) { onResult.onError(mockErrorMap) }
    }

    @Test
    fun `getPaymentDiscount returns an error`() {
        val error = getPromotionalOffer()
        assertEquals(PurchasesErrorCode.UnsupportedError.code, error.code)
        assertTrue(error.message.isNotEmpty())
    }

    @SuppressWarnings("LongMethod")
    @Test
    fun `purchaseProduct passes correct productIdentifier after a successful purchase`() {
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.MY_APP.name,
            platformInfo = PlatformInfo("flavor", "version"),
        )
        val expectedProductIdentifier = "product"
        val expectedTransactionIdentifier = "1"
        val expectedPurchaseDate: Long = 1000
        var receivedResponse: MutableMap<String, *>? = null

        val mockStoreProduct = TestUtilities.stubStoreProduct(expectedProductIdentifier)
        val mockTransaction = TestUtilities.createMockTransaction(expectedProductIdentifier)

        val capturedGetStoreProductsCallback = slot<GetStoreProductsCallback>()

        every {
            mockPurchases.getProducts(
                listOf(expectedProductIdentifier),
                ProductType.SUBS,
                capture(capturedGetStoreProductsCallback),
            )
        } answers {
            capturedGetStoreProductsCallback.captured.onReceived(listOf(mockStoreProduct))
        }

        val capturedPurchaseCallback = slot<PurchaseCallback>()
        every {
            mockPurchases.purchase(any<PurchaseParams>(), capture(capturedPurchaseCallback))
        } answers {
            val params = it.invocation.args.first() as PurchaseParams
            assertNull(params.isPersonalizedPrice)

            capturedPurchaseCallback.captured.onCompleted(mockTransaction, mockk(relaxed = true))
        }

        purchaseProduct(
            mockActivity,
            productIdentifier = expectedProductIdentifier,
            type = MappedProductCategory.SUBSCRIPTION.value,
            googleBasePlanId = null,
            googleOldProductId = null,
            googleReplacementModeInt = null,
            googleIsPersonalizedPrice = null,
            presentedOfferingContext = null,
            onResult = object : OnResult {
                override fun onReceived(map: MutableMap<String, *>) {
                    receivedResponse = map
                }

                override fun onError(errorContainer: ErrorContainer) {
                    fail("Should be success")
                }
            },
        )

        assertNotNull(receivedResponse)
        assertEquals(expectedProductIdentifier, receivedResponse?.get("productIdentifier"))

        val transaction = receivedResponse?.get("transaction")
        assertIs<Map<String, Any>>(transaction)

        assertEquals(expectedTransactionIdentifier, transaction["transactionIdentifier"])
        assertEquals(expectedProductIdentifier, transaction["productIdentifier"])
        assertEquals(expectedPurchaseDate, transaction["purchaseDateMillis"])
    }

    @Test
    fun `purchaseProduct passes correct productIdentifier and legacy product type after a successful purchase`() {
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.MY_APP.name,
            platformInfo = PlatformInfo("flavor", "version"),
        )
        val expectedProductIdentifier = "product"
        var receivedResponse: MutableMap<String, *>? = null

        val mockStoreProduct = TestUtilities.stubStoreProduct(expectedProductIdentifier)
        val mockTransaction = TestUtilities.createMockTransaction(expectedProductIdentifier)

        val capturedGetStoreProductsCallback = slot<GetStoreProductsCallback>()

        every {
            mockPurchases.getProducts(
                listOf(expectedProductIdentifier),
                ProductType.SUBS,
                capture(capturedGetStoreProductsCallback),
            )
        } answers {
            capturedGetStoreProductsCallback.captured.onReceived(listOf(mockStoreProduct))
        }

        val capturedPurchaseCallback = slot<PurchaseCallback>()
        every {
            mockPurchases.purchase(any<PurchaseParams>(), capture(capturedPurchaseCallback))
        } answers {
            val params = it.invocation.args.first() as PurchaseParams
            assertNull(params.isPersonalizedPrice)

            capturedPurchaseCallback.captured.onCompleted(mockTransaction, mockk(relaxed = true))
        }

        purchaseProduct(
            mockActivity,
            productIdentifier = expectedProductIdentifier,
            type = "subs",
            googleBasePlanId = null,
            googleOldProductId = null,
            googleReplacementModeInt = null,
            googleIsPersonalizedPrice = null,
            presentedOfferingContext = null,
            onResult = object : OnResult {
                override fun onReceived(map: MutableMap<String, *>) {
                    receivedResponse = map
                }

                override fun onError(errorContainer: ErrorContainer) {
                    fail("Should be success")
                }
            },
        )

        assertNotNull(receivedResponse)
        assertEquals(expectedProductIdentifier, receivedResponse?.get("productIdentifier"))
    }

    @Test
    fun `purchaseProduct passes productIdentifier after successful purchase with presented offering identifier`() {
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.MY_APP.name,
            platformInfo = PlatformInfo("flavor", "version"),
        )
        val expectedOfferingIdentifier = "my-offer"
        val expectedProductIdentifier = "product"

        var receivedResponse: MutableMap<String, *>? = null

        val mockStoreProduct = TestUtilities.stubStoreProduct(expectedProductIdentifier)
        val mockTransaction = TestUtilities.createMockTransaction(expectedProductIdentifier)

        val capturedGetStoreProductsCallback = slot<GetStoreProductsCallback>()

        every {
            mockPurchases.getProducts(
                listOf(expectedProductIdentifier),
                ProductType.SUBS,
                capture(capturedGetStoreProductsCallback),
            )
        } answers {
            capturedGetStoreProductsCallback.captured.onReceived(listOf(mockStoreProduct))
        }

        val capturedPurchaseCallback = slot<PurchaseCallback>()
        every {
            mockPurchases.purchase(any<PurchaseParams>(), capture(capturedPurchaseCallback))
        } answers {
            val params = it.invocation.args.first() as PurchaseParams
            assertNull(params.isPersonalizedPrice)

            val presentedOfferingContext = getPresentedOfferingContext(params)
            assertEquals(PresentedOfferingContext(expectedOfferingIdentifier), presentedOfferingContext)

            capturedPurchaseCallback.captured.onCompleted(mockTransaction, mockk(relaxed = true))
        }

        purchaseProduct(
            mockActivity,
            productIdentifier = expectedProductIdentifier,
            type = "subs",
            googleBasePlanId = null,
            googleOldProductId = null,
            googleReplacementModeInt = null,
            googleIsPersonalizedPrice = null,
            presentedOfferingContext = PresentedOfferingContext(expectedOfferingIdentifier).map(),
            onResult = object : OnResult {
                override fun onReceived(map: MutableMap<String, *>) {
                    receivedResponse = map
                }

                override fun onError(errorContainer: ErrorContainer) {
                    fail("Should be success")
                }
            },
        )

        assertNotNull(receivedResponse)
        assertEquals(expectedProductIdentifier, receivedResponse?.get("productIdentifier"))
    }

    @Test
    fun `purchaseProduct with base plan id in productIdentifier passes productIdentifier after successful purchase`() {
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.MY_APP.name,
            platformInfo = PlatformInfo("flavor", "version"),
        )
        val expectedProductIdentifier = "product"
        val expectedBasePlanIdentifier = "monthly"
        val expectedStoreProductIdentifier = "$expectedProductIdentifier:$expectedBasePlanIdentifier"

        var receivedResponse: MutableMap<String, *>? = null

        val mockTransaction = TestUtilities.createMockTransaction(expectedProductIdentifier)

        val capturedGetStoreProductsCallback = slot<GetStoreProductsCallback>()
        val mockStoreProduct = TestUtilities.stubStoreProduct(expectedStoreProductIdentifier)

        every {
            mockPurchases.getProducts(
                listOf(expectedProductIdentifier),
                ProductType.SUBS,
                capture(capturedGetStoreProductsCallback),
            )
        } answers {
            capturedGetStoreProductsCallback.captured.onReceived(listOf(mockStoreProduct))
        }

        val capturedPurchaseCallback = slot<PurchaseCallback>()
        every {
            mockPurchases.purchase(any<PurchaseParams>(), capture(capturedPurchaseCallback))
        } answers {
            val params = it.invocation.args.first() as PurchaseParams
            assertNull(params.isPersonalizedPrice)

            capturedPurchaseCallback.captured.onCompleted(mockTransaction, mockk(relaxed = true))
        }

        purchaseProduct(
            mockActivity,
            productIdentifier = expectedStoreProductIdentifier,
            type = "subs",
            googleBasePlanId = null,
            googleOldProductId = null,
            googleReplacementModeInt = null,
            googleIsPersonalizedPrice = null,
            presentedOfferingContext = null,
            onResult = object : OnResult {
                override fun onReceived(map: MutableMap<String, *>) {
                    receivedResponse = map
                }

                override fun onError(errorContainer: ErrorContainer) {
                    fail("Should be success")
                }
            },
        )

        assertNotNull(receivedResponse)
        assertEquals(expectedProductIdentifier, receivedResponse?.get("productIdentifier"))
    }

    @Test
    fun `purchaseProduct with base plan id passes correct productIdentifier after a successful purchase`() {
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.MY_APP.name,
            platformInfo = PlatformInfo("flavor", "version"),
        )
        val expectedProductIdentifier = "product"
        val expectedBasePlanIdentifier = "monthly"

        var receivedResponse: MutableMap<String, *>? = null

        val capturedGetStoreProductsCallback = slot<GetStoreProductsCallback>()

        val mockPurchasingData = mockk<PurchasingData>(relaxed = true)
        every { mockPurchasingData.productId } returns expectedProductIdentifier

        val mockSubscriptionOption = mockk<SubscriptionOption>(relaxed = true)
        every { mockSubscriptionOption.purchasingData } returns mockPurchasingData

        val mockStoreProduct = GoogleStoreProduct(
            productId = expectedProductIdentifier,
            basePlanId = expectedBasePlanIdentifier,
            type = ProductType.SUBS,
            price = Price("", 0, ""),
            title = "",
            description = "",
            period = null,
            subscriptionOptions = SubscriptionOptions(listOf(mockSubscriptionOption)),
            defaultOption = mockSubscriptionOption,
            productDetails = mockk<ProductDetails>(relaxed = true),
        )

        val mockTransaction = TestUtilities.createMockTransaction(expectedProductIdentifier)

        every {
            mockPurchases.getProducts(
                listOf(expectedProductIdentifier),
                ProductType.SUBS,
                capture(capturedGetStoreProductsCallback),
            )
        } answers {
            capturedGetStoreProductsCallback.captured.onReceived(listOf(mockStoreProduct))
        }

        val capturedPurchaseCallback = slot<PurchaseCallback>()
        every {
            mockPurchases.purchase(any<PurchaseParams>(), capture(capturedPurchaseCallback))
        } answers {
            val params = it.invocation.args.first() as PurchaseParams
            assertNull(params.isPersonalizedPrice)

            capturedPurchaseCallback.captured.onCompleted(mockTransaction, mockk(relaxed = true))
        }

        purchaseProduct(
            mockActivity,
            productIdentifier = expectedProductIdentifier,
            type = "subs",
            googleBasePlanId = expectedBasePlanIdentifier,
            googleOldProductId = null,
            googleReplacementModeInt = null,
            googleIsPersonalizedPrice = null,
            presentedOfferingContext = null,
            onResult = object : OnResult {
                override fun onReceived(map: MutableMap<String, *>) {
                    receivedResponse = map
                }

                override fun onError(errorContainer: ErrorContainer) {
                    fail("Should be success")
                }
            },
        )

        assertNotNull(receivedResponse)
        assertEquals(expectedProductIdentifier, receivedResponse?.get("productIdentifier"))
    }

    @Test
    fun `purchaseProduct passes correct productIdentifier after a successful purchase with isPersonalizedPrice`() {
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.MY_APP.name,
            platformInfo = PlatformInfo("flavor", "version"),
        )
        val expectedProductIdentifier = "product"
        var receivedResponse: MutableMap<String, *>? = null

        val capturedGetStoreProductsCallback = slot<GetStoreProductsCallback>()
        val mockStoreProduct = TestUtilities.stubStoreProduct(expectedProductIdentifier)

        val mockTransaction = TestUtilities.createMockTransaction(expectedProductIdentifier)

        every {
            mockPurchases.getProducts(
                listOf(expectedProductIdentifier),
                ProductType.SUBS,
                capture(capturedGetStoreProductsCallback),
            )
        } answers {
            capturedGetStoreProductsCallback.captured.onReceived(listOf(mockStoreProduct))
        }

        val capturedPurchaseCallback = slot<PurchaseCallback>()
        every {
            mockPurchases.purchase(any<PurchaseParams>(), capture(capturedPurchaseCallback))
        } answers {
            val params = it.invocation.args.first() as PurchaseParams
            assertEquals(true, params.isPersonalizedPrice)

            capturedPurchaseCallback.captured.onCompleted(mockTransaction, mockk(relaxed = true))
        }

        purchaseProduct(
            mockActivity,
            productIdentifier = expectedProductIdentifier,
            type = "subs",
            googleBasePlanId = null,
            googleOldProductId = null,
            googleReplacementModeInt = null,
            googleIsPersonalizedPrice = true,
            presentedOfferingContext = null,
            onResult = object : OnResult {
                override fun onReceived(map: MutableMap<String, *>) {
                    receivedResponse = map
                }

                override fun onError(errorContainer: ErrorContainer) {
                    fail("Should be success")
                }
            },
        )

        assertNotNull(receivedResponse)
        assertEquals(expectedProductIdentifier, receivedResponse?.get("productIdentifier"))
    }

    @Test
    fun `purchaseProduct sets replacementMode from storeReplacementModeString`() {
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.REVENUECAT.name,
            platformInfo = PlatformInfo("flavor", "version"),
        )
        val expectedProductIdentifier = "product"
        val expectedOldProductIdentifier = "old_product"
        var receivedResponse: MutableMap<String, *>? = null

        val capturedGetStoreProductsCallback = slot<GetStoreProductsCallback>()
        val mockStoreProduct = TestUtilities.stubStoreProduct(expectedProductIdentifier)
        val mockTransaction = TestUtilities.createMockTransaction(expectedProductIdentifier)

        every {
            mockPurchases.getProducts(
                listOf(expectedProductIdentifier),
                ProductType.SUBS,
                capture(capturedGetStoreProductsCallback),
            )
        } answers {
            capturedGetStoreProductsCallback.captured.onReceived(listOf(mockStoreProduct))
        }

        val capturedPurchaseCallback = slot<PurchaseCallback>()
        every {
            mockPurchases.purchase(any<PurchaseParams>(), capture(capturedPurchaseCallback))
        } answers {
            val params = it.invocation.args.first() as PurchaseParams
            assertEquals(expectedOldProductIdentifier, params.oldProductId)
            assertEquals(StoreReplacementMode.CHARGE_FULL_PRICE, params.replacementMode)

            capturedPurchaseCallback.captured.onCompleted(mockTransaction, mockk(relaxed = true))
        }

        purchaseProduct(
            mockActivity,
            productIdentifier = expectedProductIdentifier,
            type = "subs",
            googleBasePlanId = null,
            googleOldProductId = expectedOldProductIdentifier,
            googleReplacementModeInt = null,
            googleIsPersonalizedPrice = null,
            presentedOfferingContext = null,
            onResult = object : OnResult {
                override fun onReceived(map: MutableMap<String, *>) {
                    receivedResponse = map
                }

                override fun onError(errorContainer: ErrorContainer) {
                    fail("Should be success")
                }
            },
            storeReplacementModeString = StoreReplacementMode.CHARGE_FULL_PRICE.name,
        )

        val response = assertNotNull(receivedResponse)
        assertEquals(expectedProductIdentifier, response["productIdentifier"])
    }

    @Test
    fun `purchaseProduct sets replacementMode from googleReplacementModeInt`() {
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.REVENUECAT.name,
            platformInfo = PlatformInfo("flavor", "version"),
        )
        val expectedProductIdentifier = "product"
        val expectedOldProductIdentifier = "old_product"
        var receivedResponse: MutableMap<String, *>? = null

        val capturedGetStoreProductsCallback = slot<GetStoreProductsCallback>()
        val mockStoreProduct = TestUtilities.stubStoreProduct(expectedProductIdentifier)
        val mockTransaction = TestUtilities.createMockTransaction(expectedProductIdentifier)

        every {
            mockPurchases.getProducts(
                listOf(expectedProductIdentifier),
                ProductType.SUBS,
                capture(capturedGetStoreProductsCallback),
            )
        } answers {
            capturedGetStoreProductsCallback.captured.onReceived(listOf(mockStoreProduct))
        }

        val capturedPurchaseCallback = slot<PurchaseCallback>()
        every {
            mockPurchases.purchase(any<PurchaseParams>(), capture(capturedPurchaseCallback))
        } answers {
            val params = it.invocation.args.first() as PurchaseParams
            assertEquals(expectedOldProductIdentifier, params.oldProductId)
            assertEquals(StoreReplacementMode.DEFERRED, params.replacementMode)

            capturedPurchaseCallback.captured.onCompleted(mockTransaction, mockk(relaxed = true))
        }

        purchaseProduct(
            mockActivity,
            productIdentifier = expectedProductIdentifier,
            type = "subs",
            googleBasePlanId = null,
            googleOldProductId = expectedOldProductIdentifier,
            googleReplacementModeInt = GoogleReplacementMode.DEFERRED.playBillingClientMode,
            googleIsPersonalizedPrice = null,
            presentedOfferingContext = null,
            onResult = object : OnResult {
                override fun onReceived(map: MutableMap<String, *>) {
                    receivedResponse = map
                }

                override fun onError(errorContainer: ErrorContainer) {
                    fail("Should be success")
                }
            },
        )

        val response = assertNotNull(receivedResponse)
        assertEquals(expectedProductIdentifier, response["productIdentifier"])
    }

    @Test
    fun `purchasePackage sets replacementMode from storeReplacementModeString`() {
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.REVENUECAT.name,
            platformInfo = PlatformInfo("flavor", "version"),
        )
        val expectedProductIdentifier = "product"
        val expectedOldProductIdentifier = "old_product"
        var receivedResponse: MutableMap<String, *>? = null

        val capturedReceiveOfferingsCallback = slot<ReceiveOfferingsCallback>()
        val mockStoreProduct = TestUtilities.stubStoreProduct(expectedProductIdentifier)
        val mockTransaction = TestUtilities.createMockTransaction(expectedProductIdentifier)

        val (offeringIdentifier, packageToPurchase, offerings) = getOfferings(mockStoreProduct)

        every {
            mockPurchases.getOfferings(capture(capturedReceiveOfferingsCallback))
        } answers {
            capturedReceiveOfferingsCallback.captured.onReceived(offerings)
        }

        val capturedPurchaseCallback = slot<PurchaseCallback>()

        every {
            mockPurchases.purchase(any<PurchaseParams>(), capture(capturedPurchaseCallback))
        } answers {
            val params = it.invocation.args.first() as PurchaseParams
            assertEquals(expectedOldProductIdentifier, params.oldProductId)
            assertEquals(StoreReplacementMode.WITH_TIME_PRORATION, params.replacementMode)

            capturedPurchaseCallback.captured.onCompleted(mockTransaction, mockk(relaxed = true))
        }

        purchasePackage(
            mockActivity,
            packageIdentifier = packageToPurchase.identifier,
            googleOldProductId = expectedOldProductIdentifier,
            googleReplacementModeInt = null,
            googleIsPersonalizedPrice = null,
            onResult = object : OnResult {
                override fun onReceived(map: MutableMap<String, *>) {
                    receivedResponse = map
                }

                override fun onError(errorContainer: ErrorContainer) {
                    fail("Should be success")
                }
            },
            presentedOfferingContext = PresentedOfferingContext(offeringIdentifier).map(),
            storeReplacementModeString = StoreReplacementMode.WITH_TIME_PRORATION.name,
        )

        val response = assertNotNull(receivedResponse)
        assertEquals(expectedProductIdentifier, response["productIdentifier"])
    }

    @Test
    fun `purchasePackage sets replacementMode from googleReplacementModeInt`() {
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.REVENUECAT.name,
            platformInfo = PlatformInfo("flavor", "version"),
        )
        val expectedProductIdentifier = "product"
        val expectedOldProductIdentifier = "old_product"
        var receivedResponse: MutableMap<String, *>? = null

        val capturedReceiveOfferingsCallback = slot<ReceiveOfferingsCallback>()
        val mockStoreProduct = TestUtilities.stubStoreProduct(expectedProductIdentifier)
        val mockTransaction = TestUtilities.createMockTransaction(expectedProductIdentifier)

        val (offeringIdentifier, packageToPurchase, offerings) = getOfferings(mockStoreProduct)

        every {
            mockPurchases.getOfferings(capture(capturedReceiveOfferingsCallback))
        } answers {
            capturedReceiveOfferingsCallback.captured.onReceived(offerings)
        }

        val capturedPurchaseCallback = slot<PurchaseCallback>()

        every {
            mockPurchases.purchase(any<PurchaseParams>(), capture(capturedPurchaseCallback))
        } answers {
            val params = it.invocation.args.first() as PurchaseParams
            assertEquals(expectedOldProductIdentifier, params.oldProductId)
            assertEquals(StoreReplacementMode.CHARGE_FULL_PRICE, params.replacementMode)

            capturedPurchaseCallback.captured.onCompleted(mockTransaction, mockk(relaxed = true))
        }

        purchasePackage(
            mockActivity,
            packageIdentifier = packageToPurchase.identifier,
            googleOldProductId = expectedOldProductIdentifier,
            googleReplacementModeInt = GoogleReplacementMode.CHARGE_FULL_PRICE.playBillingClientMode,
            googleIsPersonalizedPrice = null,
            onResult = object : OnResult {
                override fun onReceived(map: MutableMap<String, *>) {
                    receivedResponse = map
                }

                override fun onError(errorContainer: ErrorContainer) {
                    fail("Should be success")
                }
            },
            presentedOfferingContext = PresentedOfferingContext(offeringIdentifier).map(),
        )

        val response = assertNotNull(receivedResponse)
        assertEquals(expectedProductIdentifier, response["productIdentifier"])
    }

    @Test
    fun `purchaseSubscriptionOption sets replacementMode from storeReplacementModeString`() {
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.MY_APP.name,
            platformInfo = PlatformInfo("flavor", "version"),
        )
        val expectedProductIdentifier = "product"
        val expectedOptionIdentifier = "monthly"
        val expectedOldProductIdentifier = "old_product"
        var receivedResponse: MutableMap<String, *>? = null

        val subscriptionOption = TestUtilities.stubSubscriptionOption(
            expectedOptionIdentifier,
            productId = expectedProductIdentifier,
        )

        val capturedGetStoreProductsCallback = slot<GetStoreProductsCallback>()
        val mockStoreProduct = TestUtilities.stubStoreProduct(
            expectedProductIdentifier,
            defaultOption = subscriptionOption,
        )
        val mockTransaction = TestUtilities.createMockTransaction(expectedProductIdentifier)

        every {
            mockPurchases.getProducts(
                listOf(expectedProductIdentifier),
                ProductType.SUBS,
                capture(capturedGetStoreProductsCallback),
            )
        } answers {
            capturedGetStoreProductsCallback.captured.onReceived(listOf(mockStoreProduct))
        }

        val capturedPurchaseCallback = slot<PurchaseCallback>()
        every {
            mockPurchases.purchase(any<PurchaseParams>(), capture(capturedPurchaseCallback))
        } answers {
            val params = it.invocation.args.first() as PurchaseParams
            assertEquals(expectedOldProductIdentifier, params.oldProductId)
            assertEquals(StoreReplacementMode.CHARGE_PRORATED_PRICE, params.replacementMode)

            capturedPurchaseCallback.captured.onCompleted(mockTransaction, mockk(relaxed = true))
        }

        purchaseSubscriptionOption(
            mockActivity,
            productIdentifier = expectedProductIdentifier,
            optionIdentifier = expectedOptionIdentifier,
            googleOldProductId = expectedOldProductIdentifier,
            googleReplacementModeInt = null,
            googleIsPersonalizedPrice = null,
            presentedOfferingContext = null,
            onResult = object : OnResult {
                override fun onReceived(map: MutableMap<String, *>) {
                    receivedResponse = map
                }

                override fun onError(errorContainer: ErrorContainer) {
                    fail("Should be success")
                }
            },
            storeReplacementModeString = StoreReplacementMode.CHARGE_PRORATED_PRICE.name,
        )

        val response = assertNotNull(receivedResponse)
        assertEquals(expectedProductIdentifier, response["productIdentifier"])
    }

    @Test
    fun `purchaseSubscriptionOption sets replacementMode from googleReplacementModeInt`() {
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.MY_APP.name,
            platformInfo = PlatformInfo("flavor", "version"),
        )
        val expectedProductIdentifier = "product"
        val expectedOptionIdentifier = "monthly"
        val expectedOldProductIdentifier = "old_product"
        var receivedResponse: MutableMap<String, *>? = null

        val subscriptionOption = TestUtilities.stubSubscriptionOption(
            expectedOptionIdentifier,
            productId = expectedProductIdentifier,
        )

        val capturedGetStoreProductsCallback = slot<GetStoreProductsCallback>()
        val mockStoreProduct = TestUtilities.stubStoreProduct(
            expectedProductIdentifier,
            defaultOption = subscriptionOption,
        )
        val mockTransaction = TestUtilities.createMockTransaction(expectedProductIdentifier)

        every {
            mockPurchases.getProducts(
                listOf(expectedProductIdentifier),
                ProductType.SUBS,
                capture(capturedGetStoreProductsCallback),
            )
        } answers {
            capturedGetStoreProductsCallback.captured.onReceived(listOf(mockStoreProduct))
        }

        val capturedPurchaseCallback = slot<PurchaseCallback>()
        every {
            mockPurchases.purchase(any<PurchaseParams>(), capture(capturedPurchaseCallback))
        } answers {
            val params = it.invocation.args.first() as PurchaseParams
            assertEquals(expectedOldProductIdentifier, params.oldProductId)
            assertEquals(StoreReplacementMode.WITH_TIME_PRORATION, params.replacementMode)

            capturedPurchaseCallback.captured.onCompleted(mockTransaction, mockk(relaxed = true))
        }

        purchaseSubscriptionOption(
            mockActivity,
            productIdentifier = expectedProductIdentifier,
            optionIdentifier = expectedOptionIdentifier,
            googleOldProductId = expectedOldProductIdentifier,
            googleReplacementModeInt = GoogleReplacementMode.WITH_TIME_PRORATION.playBillingClientMode,
            googleIsPersonalizedPrice = null,
            presentedOfferingContext = null,
            onResult = object : OnResult {
                override fun onReceived(map: MutableMap<String, *>) {
                    receivedResponse = map
                }

                override fun onError(errorContainer: ErrorContainer) {
                    fail("Should be success")
                }
            },
        )

        val response = assertNotNull(receivedResponse)
        assertEquals(expectedProductIdentifier, response["productIdentifier"])
    }

    @Test
    fun `purchase uses StoreReplacementMode from googleReplacementMode option`() {
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.REVENUECAT.name,
            platformInfo = PlatformInfo("flavor", "version"),
        )
        val expectedProductIdentifier = "product"
        val expectedOldProductIdentifier = "old_product"
        var receivedResponse: MutableMap<String, *>? = null

        val capturedGetStoreProductsCallback = slot<GetStoreProductsCallback>()
        val mockStoreProduct = TestUtilities.stubStoreProduct(expectedProductIdentifier)
        val mockTransaction = TestUtilities.createMockTransaction(expectedProductIdentifier)

        every {
            mockPurchases.getProducts(
                listOf(expectedProductIdentifier),
                ProductType.SUBS,
                capture(capturedGetStoreProductsCallback),
            )
        } answers {
            capturedGetStoreProductsCallback.captured.onReceived(listOf(mockStoreProduct))
        }

        val capturedPurchaseCallback = slot<PurchaseCallback>()
        every {
            mockPurchases.purchase(any<PurchaseParams>(), capture(capturedPurchaseCallback))
        } answers {
            val params = it.invocation.args.first() as PurchaseParams
            assertEquals(expectedOldProductIdentifier, params.oldProductId)
            assertEquals(StoreReplacementMode.DEFERRED, params.replacementMode)

            capturedPurchaseCallback.captured.onCompleted(mockTransaction, mockk(relaxed = true))
        }

        purchase(
            mockActivity,
            options = mapOf(
                "productIdentifier" to expectedProductIdentifier,
                "type" to "subs",
                "googleOldProductId" to expectedOldProductIdentifier,
                "googleReplacementMode" to GoogleReplacementMode.DEFERRED.playBillingClientMode,
            ),
            onResult = object : OnResult {
                override fun onReceived(map: MutableMap<String, *>) {
                    receivedResponse = map
                }

                override fun onError(errorContainer: ErrorContainer) {
                    fail("Should be success")
                }
            },
        )

        val response = assertNotNull(receivedResponse)
        assertEquals(expectedProductIdentifier, response["productIdentifier"])
    }

    @Test
    fun `purchase uses storeReplacementMode instead of googleReplacementMode when both are provided`() {
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.REVENUECAT.name,
            platformInfo = PlatformInfo("flavor", "version"),
        )
        val expectedProductIdentifier = "product"
        val expectedOldProductIdentifier = "old_product"
        var receivedResponse: MutableMap<String, *>? = null

        val capturedGetStoreProductsCallback = slot<GetStoreProductsCallback>()
        val mockStoreProduct = TestUtilities.stubStoreProduct(expectedProductIdentifier)
        val mockTransaction = TestUtilities.createMockTransaction(expectedProductIdentifier)

        every {
            mockPurchases.getProducts(
                listOf(expectedProductIdentifier),
                ProductType.SUBS,
                capture(capturedGetStoreProductsCallback),
            )
        } answers {
            capturedGetStoreProductsCallback.captured.onReceived(listOf(mockStoreProduct))
        }

        val capturedPurchaseCallback = slot<PurchaseCallback>()
        every {
            mockPurchases.purchase(any<PurchaseParams>(), capture(capturedPurchaseCallback))
        } answers {
            val params = it.invocation.args.first() as PurchaseParams
            assertEquals(expectedOldProductIdentifier, params.oldProductId)
            assertEquals(StoreReplacementMode.CHARGE_FULL_PRICE, params.replacementMode)

            capturedPurchaseCallback.captured.onCompleted(mockTransaction, mockk(relaxed = true))
        }

        purchase(
            mockActivity,
            options = mapOf(
                "productIdentifier" to expectedProductIdentifier,
                "type" to "subs",
                "googleOldProductId" to expectedOldProductIdentifier,
                "googleReplacementMode" to GoogleReplacementMode.DEFERRED.playBillingClientMode,
                "storeReplacementMode" to StoreReplacementMode.CHARGE_FULL_PRICE.name,
            ),
            onResult = object : OnResult {
                override fun onReceived(map: MutableMap<String, *>) {
                    receivedResponse = map
                }

                override fun onError(errorContainer: ErrorContainer) {
                    fail("Should be success")
                }
            },
        )

        val response = assertNotNull(receivedResponse)
        assertEquals(expectedProductIdentifier, response["productIdentifier"])
    }

    @Test
    fun `purchase package uses storeReplacementMode from options`() {
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.REVENUECAT.name,
            platformInfo = PlatformInfo("flavor", "version"),
        )
        val expectedProductIdentifier = "product"
        val expectedOldProductIdentifier = "old_product"
        var receivedResponse: MutableMap<String, *>? = null

        val capturedReceiveOfferingsCallback = slot<ReceiveOfferingsCallback>()
        val mockStoreProduct = TestUtilities.stubStoreProduct(expectedProductIdentifier)
        val mockTransaction = TestUtilities.createMockTransaction(expectedProductIdentifier)

        val (offeringIdentifier, packageToPurchase, offerings) = getOfferings(mockStoreProduct)

        every {
            mockPurchases.getOfferings(capture(capturedReceiveOfferingsCallback))
        } answers {
            capturedReceiveOfferingsCallback.captured.onReceived(offerings)
        }

        val capturedPurchaseCallback = slot<PurchaseCallback>()

        every {
            mockPurchases.purchase(any<PurchaseParams>(), capture(capturedPurchaseCallback))
        } answers {
            val params = it.invocation.args.first() as PurchaseParams
            assertEquals(expectedOldProductIdentifier, params.oldProductId)
            assertEquals(StoreReplacementMode.DEFERRED, params.replacementMode)

            capturedPurchaseCallback.captured.onCompleted(mockTransaction, mockk(relaxed = true))
        }

        purchase(
            mockActivity,
            options = mapOf(
                "packageIdentifier" to packageToPurchase.identifier,
                "presentedOfferingContext" to PresentedOfferingContext(offeringIdentifier).map(),
                "googleOldProductId" to expectedOldProductIdentifier,
                "storeReplacementMode" to StoreReplacementMode.DEFERRED.name,
            ),
            onResult = object : OnResult {
                override fun onReceived(map: MutableMap<String, *>) {
                    receivedResponse = map
                }

                override fun onError(errorContainer: ErrorContainer) {
                    fail("Should be success")
                }
            },
        )

        val response = assertNotNull(receivedResponse)
        assertEquals(expectedProductIdentifier, response["productIdentifier"])
    }

    @Test
    fun `purchase subscription option uses storeReplacementMode from options`() {
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.REVENUECAT.name,
            platformInfo = PlatformInfo("flavor", "version"),
        )
        val expectedProductIdentifier = "product"
        val expectedOptionIdentifier = "monthly"
        val expectedOldProductIdentifier = "old_product"
        var receivedResponse: MutableMap<String, *>? = null

        val subscriptionOption = TestUtilities.stubSubscriptionOption(
            expectedOptionIdentifier,
            productId = expectedProductIdentifier,
        )

        val capturedGetStoreProductsCallback = slot<GetStoreProductsCallback>()
        val mockStoreProduct = TestUtilities.stubStoreProduct(
            expectedProductIdentifier,
            defaultOption = subscriptionOption,
        )
        val mockTransaction = TestUtilities.createMockTransaction(expectedProductIdentifier)

        every {
            mockPurchases.getProducts(
                listOf(expectedProductIdentifier),
                ProductType.SUBS,
                capture(capturedGetStoreProductsCallback),
            )
        } answers {
            capturedGetStoreProductsCallback.captured.onReceived(listOf(mockStoreProduct))
        }

        val capturedPurchaseCallback = slot<PurchaseCallback>()
        every {
            mockPurchases.purchase(any<PurchaseParams>(), capture(capturedPurchaseCallback))
        } answers {
            val params = it.invocation.args.first() as PurchaseParams
            assertEquals(expectedOldProductIdentifier, params.oldProductId)
            assertEquals(StoreReplacementMode.WITHOUT_PRORATION, params.replacementMode)

            capturedPurchaseCallback.captured.onCompleted(mockTransaction, mockk(relaxed = true))
        }

        purchase(
            mockActivity,
            options = mapOf(
                "productIdentifier" to expectedProductIdentifier,
                "optionIdentifier" to expectedOptionIdentifier,
                "googleOldProductId" to expectedOldProductIdentifier,
                "storeReplacementMode" to StoreReplacementMode.WITHOUT_PRORATION.name,
            ),
            onResult = object : OnResult {
                override fun onReceived(map: MutableMap<String, *>) {
                    receivedResponse = map
                }

                override fun onError(errorContainer: ErrorContainer) {
                    fail("Should be success")
                }
            },
        )

        val response = assertNotNull(receivedResponse)
        assertEquals(expectedProductIdentifier, response["productIdentifier"])
    }

    @Test
    fun `purchasePackage passes correct productIdentifier after a successful purchase`() {
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.MY_APP.name,
            platformInfo = PlatformInfo("flavor", "version"),
        )
        val expectedProductIdentifier = "product"
        var receivedResponse: MutableMap<String, *>? = null

        val capturedReceiveOfferingsCallback = slot<ReceiveOfferingsCallback>()
        val mockStoreProduct = TestUtilities.stubStoreProduct(expectedProductIdentifier)
        val mockTransaction = TestUtilities.createMockTransaction(expectedProductIdentifier)

        val (offeringIdentifier, packageToPurchase, offerings) = getOfferings(mockStoreProduct)

        every {
            mockPurchases.getOfferings(capture(capturedReceiveOfferingsCallback))
        } answers {
            capturedReceiveOfferingsCallback.captured.onReceived(offerings)
        }

        val capturedPurchaseCallback = slot<PurchaseCallback>()

        every {
            mockPurchases.purchase(any<PurchaseParams>(), capture(capturedPurchaseCallback))
        } answers {
            val params = it.invocation.args.first() as PurchaseParams
            assertNull(params.isPersonalizedPrice)

            capturedPurchaseCallback.captured.onCompleted(mockTransaction, mockk(relaxed = true))
        }

        purchasePackage(
            mockActivity,
            packageIdentifier = "packageIdentifier",
            googleOldProductId = null,
            googleReplacementModeInt = null,
            googleIsPersonalizedPrice = null,
            onResult = object : OnResult {
                override fun onReceived(map: MutableMap<String, *>) {
                    receivedResponse = map
                }

                override fun onError(errorContainer: ErrorContainer) {
                    fail("Should be success")
                }
            },
            presentedOfferingContext = PresentedOfferingContext(offeringIdentifier).map(),
        )

        assertNotNull(receivedResponse)
        assertEquals(expectedProductIdentifier, receivedResponse?.get("productIdentifier"))
    }

    @Test
    fun `purchasePackage passes correct productIdentifier after a successful purchase with isPersonalizedPrice`() {
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.MY_APP.name,
            platformInfo = PlatformInfo("flavor", "version"),
        )
        val expectedProductIdentifier = "product"
        var receivedResponse: MutableMap<String, *>? = null

        val capturedReceiveOfferingsCallback = slot<ReceiveOfferingsCallback>()
        val mockStoreProduct = TestUtilities.stubStoreProduct(expectedProductIdentifier)
        val mockTransaction = TestUtilities.createMockTransaction(expectedProductIdentifier)

        val (offeringIdentifier, packageToPurchase, offerings) = getOfferings(mockStoreProduct)

        every {
            mockPurchases.getOfferings(capture(capturedReceiveOfferingsCallback))
        } answers {
            capturedReceiveOfferingsCallback.captured.onReceived(offerings)
        }

        val capturedPurchaseCallback = slot<PurchaseCallback>()

        every {
            mockPurchases.purchase(any<PurchaseParams>(), capture(capturedPurchaseCallback))
        } answers {
            val params = it.invocation.args.first() as PurchaseParams
            assertEquals(true, params.isPersonalizedPrice)

            capturedPurchaseCallback.captured.onCompleted(mockTransaction, mockk(relaxed = true))
        }

        purchasePackage(
            mockActivity,
            packageIdentifier = "packageIdentifier",
            googleOldProductId = null,
            googleReplacementModeInt = null,
            googleIsPersonalizedPrice = true,
            onResult = object : OnResult {
                override fun onReceived(map: MutableMap<String, *>) {
                    receivedResponse = map
                }

                override fun onError(errorContainer: ErrorContainer) {
                    fail("Should be success")
                }
            },
            presentedOfferingContext = PresentedOfferingContext(offeringIdentifier).map(),
        )

        assertNotNull(receivedResponse)
        assertEquals(expectedProductIdentifier, receivedResponse?.get("productIdentifier"))
    }

    @Test
    fun `purchaseSubscriptionOption passes correct productIdentifier after a successful purchase`() {
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.MY_APP.name,
            platformInfo = PlatformInfo("flavor", "version"),
        )
        val expectedProductIdentifier = "product"
        val expectedOptionIdentifier = "monthly"
        var receivedResponse: MutableMap<String, *>? = null

        val subscriptionOption = TestUtilities.stubSubscriptionOption(
            expectedOptionIdentifier,
            productId = expectedProductIdentifier,
        )

        val capturedGetStoreProductsCallback = slot<GetStoreProductsCallback>()
        val mockStoreProduct = TestUtilities.stubStoreProduct(
            expectedProductIdentifier,
            defaultOption = subscriptionOption,
        )
        val mockTransaction = TestUtilities.createMockTransaction(expectedProductIdentifier)

        every {
            mockPurchases.getProducts(
                listOf(expectedProductIdentifier),
                ProductType.SUBS,
                capture(capturedGetStoreProductsCallback),
            )
        } answers {
            capturedGetStoreProductsCallback.captured.onReceived(listOf(mockStoreProduct))
        }

        val capturedPurchaseCallback = slot<PurchaseCallback>()
        every {
            mockPurchases.purchase(any<PurchaseParams>(), capture(capturedPurchaseCallback))
        } answers {
            val params = it.invocation.args.first() as PurchaseParams
            assertNull(params.isPersonalizedPrice)

            capturedPurchaseCallback.captured.onCompleted(mockTransaction, mockk(relaxed = true))
        }

        purchaseSubscriptionOption(
            mockActivity,
            productIdentifier = expectedProductIdentifier,
            optionIdentifier = expectedOptionIdentifier,
            googleOldProductId = null,
            googleReplacementModeInt = null,
            googleIsPersonalizedPrice = null,
            presentedOfferingContext = null,
            onResult = object : OnResult {
                override fun onReceived(map: MutableMap<String, *>) {
                    receivedResponse = map
                }

                override fun onError(errorContainer: ErrorContainer) {
                    fail("Should be success")
                }
            },
        )

        assertNotNull(receivedResponse)
        assertEquals(expectedProductIdentifier, receivedResponse?.get("productIdentifier"))
    }

    @Test
    fun `purchaseSubscriptionOption passes productIdentifier after successful purchase with presented offeringId`() {
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.MY_APP.name,
            platformInfo = PlatformInfo("flavor", "version"),
        )
        val expectedOfferingIdentifier = "my-offers"

        val expectedProductIdentifier = "product"
        val expectedOptionIdentifier = "monthly"
        var receivedResponse: MutableMap<String, *>? = null

        val subscriptionOption = TestUtilities.stubSubscriptionOption(
            expectedOptionIdentifier,
            productId = expectedProductIdentifier,
        )

        val capturedGetStoreProductsCallback = slot<GetStoreProductsCallback>()
        val mockStoreProduct = TestUtilities.stubStoreProduct(
            expectedProductIdentifier,
            defaultOption = subscriptionOption,
        )
        val mockTransaction = TestUtilities.createMockTransaction(expectedProductIdentifier)

        every {
            mockPurchases.getProducts(
                listOf(expectedProductIdentifier),
                ProductType.SUBS,
                capture(capturedGetStoreProductsCallback),
            )
        } answers {
            capturedGetStoreProductsCallback.captured.onReceived(listOf(mockStoreProduct))
        }

        val capturedPurchaseCallback = slot<PurchaseCallback>()
        every {
            mockPurchases.purchase(any<PurchaseParams>(), capture(capturedPurchaseCallback))
        } answers {
            val params = it.invocation.args.first() as PurchaseParams
            assertNull(params.isPersonalizedPrice)

            val presentedOfferingContext = getPresentedOfferingContext(params)
            assertEquals(PresentedOfferingContext(expectedOfferingIdentifier), presentedOfferingContext)

            capturedPurchaseCallback.captured.onCompleted(mockTransaction, mockk(relaxed = true))
        }

        purchaseSubscriptionOption(
            mockActivity,
            productIdentifier = expectedProductIdentifier,
            optionIdentifier = expectedOptionIdentifier,
            googleOldProductId = null,
            googleReplacementModeInt = null,
            googleIsPersonalizedPrice = null,
            presentedOfferingContext = PresentedOfferingContext(expectedOfferingIdentifier).map(),
            onResult = object : OnResult {
                override fun onReceived(map: MutableMap<String, *>) {
                    receivedResponse = map
                }

                override fun onError(errorContainer: ErrorContainer) {
                    fail("Should be success")
                }
            },
        )

        assertNotNull(receivedResponse)
        assertEquals(expectedProductIdentifier, receivedResponse?.get("productIdentifier"))
    }

    @Test
    fun `purchaseSubscriptionOption errors when store is Amazon`() {
        every { mockPurchases.store } returns Store.AMAZON

        var receivedErrorContainer: ErrorContainer? = null

        purchaseSubscriptionOption(
            mockActivity,
            productIdentifier = "product",
            optionIdentifier = "option",
            googleOldProductId = null,
            googleReplacementModeInt = null,
            googleIsPersonalizedPrice = null,
            presentedOfferingContext = null,
            onResult = object : OnResult {
                override fun onReceived(map: MutableMap<String, *>) {
                    fail("Should be success")
                }

                override fun onError(errorContainer: ErrorContainer) {
                    receivedErrorContainer = errorContainer
                }
            },
        )

        assertNotNull(receivedErrorContainer)
    }

    @Test
    fun `logs are passed correctly to LogHandler`() {
        val expectedMessage = "a message"
        LogLevel.values().forEach { logLevel ->
            setLogHandler { logDetails ->
                assertEquals(logLevel.name.uppercase(), logDetails["logLevel"])
                assertEquals(expectedMessage, logDetails["message"])
            }
            when (logLevel) {
                LogLevel.VERBOSE -> Purchases.logHandler.v("Purchases", expectedMessage)
                LogLevel.DEBUG -> Purchases.logHandler.d("Purchases", expectedMessage)
                LogLevel.INFO -> Purchases.logHandler.i("Purchases", expectedMessage)
                LogLevel.WARN -> Purchases.logHandler.w("Purchases", expectedMessage)
                LogLevel.ERROR -> Purchases.logHandler.e("Purchases", expectedMessage, null)
            }
        }
    }

    @Test
    fun `logs are passed correctly to LogHandlerWithOnResult`() {
        val expectedMessage = "a message"
        LogLevel.values().forEach { logLevel ->
            setLogHandlerWithOnResult(object : OnResult {
                override fun onReceived(logDetails: MutableMap<String, *>) {
                    assertEquals(logLevel.name.uppercase(), logDetails["logLevel"])
                    assertEquals(expectedMessage, logDetails["message"])
                }

                override fun onError(errorContainer: ErrorContainer) {
                    fail("onError shouldn't be called")
                }
            })
            when (logLevel) {
                LogLevel.VERBOSE -> Purchases.logHandler.v("Purchases", expectedMessage)
                LogLevel.DEBUG -> Purchases.logHandler.d("Purchases", expectedMessage)
                LogLevel.INFO -> Purchases.logHandler.i("Purchases", expectedMessage)
                LogLevel.WARN -> Purchases.logHandler.w("Purchases", expectedMessage)
                LogLevel.ERROR -> Purchases.logHandler.e("Purchases", expectedMessage, null)
            }
        }
    }

    @Test
    fun `error logs include error in message`() {
        val expectedMessage = "a message"
        setLogHandler { logDetails ->
            assertEquals("ERROR", logDetails["logLevel"])
            assertEquals(
                "$expectedMessage. Throwable: java.lang.ClassCastException: what a pity",
                logDetails["message"],
            )
        }
        Purchases.logHandler.e("Purchases", expectedMessage, java.lang.ClassCastException("what a pity"))
    }

    @Test
    fun `getGoogleReplacementMode returns null if null replacementModeIndex`() {
        val replacementModeInt: Int? = null

        val mode = getGoogleReplacementMode(replacementModeInt)
        assertEquals(mode, null)
    }

    @Test
    fun `getGoogleReplacementMode returns WITHOUT_PRORATION for 3`() {
        val replacementModeInt: Int? = 3

        val mode = getGoogleReplacementMode(replacementModeInt)
        assertEquals(mode, GoogleReplacementMode.WITHOUT_PRORATION)
    }

    @Test
    fun `getGoogleReplacementMode returns IMMEDIATE_WITH_TIME_PRORATION for 1`() {
        val replacementModeInt: Int? = 1

        val mode = getGoogleReplacementMode(replacementModeInt)
        assertEquals(mode, GoogleReplacementMode.WITH_TIME_PRORATION)
    }

    @Test
    fun `getGoogleReplacementMode returns DEFERRED for 6`() {
        val replacementModeInt: Int? = 6

        val mode = getGoogleReplacementMode(replacementModeInt)
        assertEquals(mode, GoogleReplacementMode.DEFERRED)
    }

    @Test
    fun `getGoogleReplacementMode throws exception for negative out of bounds number`() {
        val replacementModeInt: Int? = -1

        var catchWasCalled = false
        try {
            val mode = getGoogleReplacementMode(replacementModeInt)
        } catch (e: InvalidReplacementModeException) {
            catchWasCalled = true
        }

        assertTrue(catchWasCalled)
    }

    @Test
    fun `getGoogleReplacementMode throws exception for position out of bounds number`() {
        val replacementModeInt: Int? = 1000

        var catchWasCalled = false
        try {
            val mode = getGoogleReplacementMode(replacementModeInt)
        } catch (e: InvalidReplacementModeException) {
            catchWasCalled = true
        }

        assertTrue(catchWasCalled)
    }

    @Test
    fun `getStoreReplacementMode works as expected for billing client mode ints`() {
        val expectations = mapOf(
            null to null,
            1 to StoreReplacementMode.WITH_TIME_PRORATION,
            2 to StoreReplacementMode.CHARGE_PRORATED_PRICE,
            3 to StoreReplacementMode.WITHOUT_PRORATION,
            // No 4 because that's undefined in BillingFlowParams' ReplacementMode
            5 to StoreReplacementMode.CHARGE_FULL_PRICE,
            6 to StoreReplacementMode.DEFERRED,
        )

        for (expectation in expectations) {
            val googleReplacementModeInt = expectation.key
            val expectedStoreReplacementMode = expectation.value
            val actualStoreReplacementMode = getStoreReplacementMode(googleReplacementModeInt)
            assertEquals(expectedStoreReplacementMode, actualStoreReplacementMode)
        }
    }

    @Test
    fun `getStoreReplacementMode throws exception for negative out of bounds number`() {
        val replacementModeInt = -1

        assertFailsWith<InvalidReplacementModeException> {
            getStoreReplacementMode(replacementModeInt)
        }
    }

    @Test
    fun `getStoreReplacementMode throws exception for position out of bounds number`() {
        val replacementModeInt = Int.MAX_VALUE

        assertFailsWith<InvalidReplacementModeException> {
            getStoreReplacementMode(replacementModeInt)
        }
    }

    @Test
    fun `getStoreReplacementMode works as expected for StoreReplacementMode strings`() {
        val expectations = mapOf(
            null to null,
            "WITH_TIME_PRORATION" to StoreReplacementMode.WITH_TIME_PRORATION,
            "CHARGE_PRORATED_PRICE" to StoreReplacementMode.CHARGE_PRORATED_PRICE,
            "WITHOUT_PRORATION" to StoreReplacementMode.WITHOUT_PRORATION,
            "CHARGE_FULL_PRICE" to StoreReplacementMode.CHARGE_FULL_PRICE,
            "DEFERRED" to StoreReplacementMode.DEFERRED,
        )

        for (expectation in expectations) {
            val storeReplacementModeString = expectation.key
            val expectedStoreReplacementMode = expectation.value
            val actualStoreReplacementMode = getStoreReplacementMode(storeReplacementModeString)
            assertEquals(expectedStoreReplacementMode, actualStoreReplacementMode)
        }
    }

    @Test
    fun `getStoreReplacementMode throws exception for unknown replacementModeString`() {
        assertFailsWith<InvalidReplacementModeException> {
            getStoreReplacementMode(storeReplacementModeString = "UNKNOWN_REPLACEMENT_MODE")
        }
    }

    @Test
    fun `getStoreReplacementMode throws exception for lowercase replacementModeString`() {
        assertFailsWith<InvalidReplacementModeException> {
            getStoreReplacementMode(storeReplacementModeString = "deferred")
        }
    }

    @Test
    fun `getStoreReplacementMode throws exception for empty replacementModeString`() {
        assertFailsWith<InvalidReplacementModeException> {
            getStoreReplacementMode(storeReplacementModeString = "")
        }
    }

    @Test
    fun `mapStringToProductType returns ProductType SUBS for subs`() {
        val productType = mapStringToProductType("subs")
        assertEquals(ProductType.SUBS, productType)
    }

    @Test
    fun `mapStringToProductType returns ProductType SUBS for SUBSCRIPTION`() {
        val productType = mapStringToProductType("SUBSCRIPTION")
        assertEquals(ProductType.SUBS, productType)
    }

    @Test
    fun `mapStringToProductType returns ProductType INAPP for inapp`() {
        val productType = mapStringToProductType("inapp")
        assertEquals(ProductType.INAPP, productType)
    }

    @Test
    fun `mapStringToProductType returns ProductType INAPP for NON_SUBSCRIPTION`() {
        val productType = mapStringToProductType("NON_SUBSCRIPTION")
        assertEquals(ProductType.INAPP, productType)
    }

    @Test
    fun `offerings maps with empty metadata`() {
        val productIdentifier = "product"
        val mockStoreProduct = TestUtilities.stubStoreProduct(productIdentifier)
        val (offeringIdentifier, packageToPurchase, offerings) = getOfferings(mockStoreProduct, metadata = emptyMap())

        val mappedOffering = offerings.mapBlocking()["current"] as Map<*, *>
        val mappedMetadata = mappedOffering["metadata"] as Map<*, *>

        assertEquals(emptyMap<String, Any>(), mappedMetadata)
    }

    @Test
    fun `offerings maps with metadata`() {
        val metadata = mapOf(
            "int" to 5,
            "double" to 5.5,
            "boolean" to true,
            "string" to "five",
            "array" to listOf("five"),
            "dictionary" to mapOf(
                "string" to "five",
            ),
        )

        val productIdentifier = "product"
        val mockStoreProduct = TestUtilities.stubStoreProduct(productIdentifier)
        val (offeringIdentifier, packageToPurchase, offerings) = getOfferings(mockStoreProduct, metadata = metadata)

        val mappedOffering = offerings.mapBlocking()["current"] as Map<*, *>
        val mappedMetadata = mappedOffering["metadata"] as Map<*, *>

        assertEquals(metadata, mappedMetadata)
    }

    @Test
    fun `calling getVirtualCurrencies correctly calls onReceived when the VC has a serverDescription`() {
        verifyGetVirtualCurrencyCorrectlyCallsOnReceived(
            mockedVCServerDescription = "Hello world",
        )
    }

    @Test
    fun `calling getVirtualCurrencies correctly calls onReceived when the VC has a null serverDescription`() {
        verifyGetVirtualCurrencyCorrectlyCallsOnReceived(
            mockedVCServerDescription = null,
        )
    }

    private fun verifyGetVirtualCurrencyCorrectlyCallsOnReceived(
        mockedVCServerDescription: String?,
    ) {
        val appUserID = "appUserID"
        val expectedBalance = 100
        val expectedName = "Coin"
        val expectedCode = "COIN"

        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = appUserID,
            purchasesAreCompletedBy = PurchasesAreCompletedBy.REVENUECAT.name,
            platformInfo = PlatformInfo("flavor", "version"),
        )

        val mockVirtualCurrency = mockk<VirtualCurrency>()
        every { mockVirtualCurrency.balance } returns expectedBalance
        every { mockVirtualCurrency.name } returns expectedName
        every { mockVirtualCurrency.code } returns expectedCode
        every { mockVirtualCurrency.serverDescription } returns mockedVCServerDescription

        val mockVirtualCurrencies = mockk<VirtualCurrencies>()
        every { mockVirtualCurrencies.all } returns mapOf(expectedCode to mockVirtualCurrency)

        val capturedCallback = slot<GetVirtualCurrenciesCallback>()
        every {
            mockPurchases.getVirtualCurrencies(capture(capturedCallback))
        } answers {
            capturedCallback.captured.onReceived(mockVirtualCurrencies)
        }

        val onResult = mockk<OnResult>(relaxed = true)

        getVirtualCurrencies(onResult = onResult)

        verify(exactly = 1) {
            onResult.onReceived(
                mapOf(
                    "all" to mapOf(
                        expectedCode to mapOf(
                            "balance" to expectedBalance,
                            "name" to expectedName,
                            "code" to expectedCode,
                            "serverDescription" to mockedVCServerDescription,
                        ),
                    ),
                ),
            )
        }

        verify(exactly = 0) {
            onResult.onError(any())
        }
    }

    @Test
    fun `calling getVirtualCurrencies with error calls onError`() {
        val appUserID = "appUserID"

        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = appUserID,
            purchasesAreCompletedBy = PurchasesAreCompletedBy.REVENUECAT.name,
            platformInfo = PlatformInfo("flavor", "version"),
        )

        val mockError = mockk<PurchasesError>(relaxed = true)
        val capturedCallback = slot<GetVirtualCurrenciesCallback>()

        every {
            mockPurchases.getVirtualCurrencies(capture(capturedCallback))
        } answers {
            capturedCallback.captured.onError(mockError)
        }

        val onResult = mockk<OnResult>()
        every { onResult.onReceived(any()) } just runs
        every { onResult.onError(any()) } just runs

        getVirtualCurrencies(onResult = onResult)

        val mockErrorMap = mockError.map()
        verify(exactly = 1) {
            onResult.onError(mockErrorMap)
        }

        verify(exactly = 0) {
            onResult.onReceived(any())
        }
    }

    @Test
    fun `calling invalidateVirtualCurrenciesCache calls invalidateVirtualCurrenciesCache`() {
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.REVENUECAT.name,
            platformInfo = PlatformInfo("flavor", "version"),
        )

        every { mockPurchases.invalidateVirtualCurrenciesCache() } just runs

        invalidateVirtualCurrenciesCache()

        verify(exactly = 1) {
            mockPurchases.invalidateVirtualCurrenciesCache()
        }
    }

    @Test
    fun `getCachedVirtualCurrencies returns cached VCs from native SDK when available`() {
        val expectedBalance = 100
        val expectedName = "Coin"
        val expectedCode = "COIN"
        val expectedServerDescription = "Cached VC"
        val expectedVirtualCurrenciesMap = mapOf(
            "all" to mapOf(
                expectedCode to mapOf(
                    "balance" to expectedBalance,
                    "name" to expectedName,
                    "code" to expectedCode,
                    "serverDescription" to expectedServerDescription,
                ),
            ),
        )

        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.REVENUECAT.name,
            platformInfo = PlatformInfo("flavor", "version"),
        )

        val mockVirtualCurrency = mockk<VirtualCurrency>()
        every { mockVirtualCurrency.balance } returns expectedBalance
        every { mockVirtualCurrency.name } returns expectedName
        every { mockVirtualCurrency.code } returns expectedCode
        every { mockVirtualCurrency.serverDescription } returns expectedServerDescription

        val mockVirtualCurrencies = mockk<VirtualCurrencies>()
        every { mockVirtualCurrencies.all } returns mapOf(expectedCode to mockVirtualCurrency)

        every { mockPurchases.cachedVirtualCurrencies } returns(mockVirtualCurrencies)

        val actualCachedVirtualCurrenciesMap = getCachedVirtualCurrencies()

        verify(exactly = 1) {
            mockPurchases.cachedVirtualCurrencies
        }

        assertThat(actualCachedVirtualCurrenciesMap).isEqualTo(expectedVirtualCurrenciesMap)
    }

    @Test
    fun `getCachedVirtualCurrencies returns null when there are no cached VCs`() {
        configure(
            context = mockContext,
            apiKey = "api_key",
            appUserID = "appUserID",
            purchasesAreCompletedBy = PurchasesAreCompletedBy.REVENUECAT.name,
            platformInfo = PlatformInfo("flavor", "version"),
        )

        every { mockPurchases.cachedVirtualCurrencies } returns(null)

        val actualCachedVirtualCurrenciesMap = getCachedVirtualCurrencies()

        verify(exactly = 1) {
            mockPurchases.cachedVirtualCurrencies
        }

        assertThat(actualCachedVirtualCurrenciesMap).isNull()
    }

    @OptIn(InternalRevenueCatAPI::class)
    private fun getOfferings(
        mockStoreProduct: StoreProduct,
        metadata: Map<String, Any> = emptyMap(),
    ): Triple<String, Package, Offerings> {
        val offeringIdentifier = "offering"
        val packageToPurchase = Package(
            identifier = "packageIdentifier",
            packageType = PackageType.ANNUAL,
            product = mockStoreProduct,
            offering = offeringIdentifier,
        )
        val offering = Offering(
            identifier = offeringIdentifier,
            serverDescription = "",
            availablePackages = listOf(packageToPurchase),
            metadata = metadata,
        )
        val offerings = Offerings(current = offering, all = mapOf(offeringIdentifier to offering))
        return Triple(offeringIdentifier, packageToPurchase, offerings)
    }
}

private fun getPresentedOfferingContext(purchaseParams: PurchaseParams): PresentedOfferingContext? {
    // Uses reflection to test presentedOfferingContext exists in purchasing params
    val prop = PurchaseParams::class.members.firstOrNull { member -> member.name == "presentedOfferingContext" }
    return prop!!.call(purchaseParams) as? PresentedOfferingContext?
}
