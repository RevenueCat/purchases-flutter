import 'package:purchases_flutter/purchases_flutter.dart';

// ignore_for_file: unused_element
// ignore_for_file: unused_local_variable
// ignore_for_file: deprecated_member_use
class _PurchasesFlutterApiTest {
  void _checkSetup() {
    String apiKey = "fakeApiKey";
    String? userId = "fakeUserId";
    PurchasesAreCompletedBy purchasesAreCompletedBy =
        const PurchasesAreCompletedByRevenueCat();
    String? userDefaultsSuiteName = "fakeSuiteName";
    bool useAmazon = false;
    StoreKitVersion storeKitVersion = StoreKitVersion.storeKit2;

    Future<void> callback = Purchases.setup(apiKey);
    Future<void> callback2 = Purchases.setup(
      apiKey,
      appUserId: userId,
      purchasesAreCompletedBy: purchasesAreCompletedBy,
      userDefaultsSuiteName: userDefaultsSuiteName,
      storeKitVersion: storeKitVersion,
      useAmazon: useAmazon,
    );
  }

  void _checkConfigure() {
    PurchasesConfiguration configuration = PurchasesConfiguration("fakeApiKey");
    configuration.appUserID = "fakeUserId";
    configuration.purchasesAreCompletedBy =
        const PurchasesAreCompletedByRevenueCat();
    configuration.purchasesAreCompletedBy = PurchasesAreCompletedByMyApp(
      storeKitVersion: StoreKitVersion.defaultVersion,
    );
    configuration.shouldShowInAppMessagesAutomatically = true;
    configuration.store = Store.amazon;
    configuration.userDefaultsSuiteName = "fakeSuiteName";
    configuration.storeKitVersion = StoreKitVersion.defaultVersion;
    Future<void> callback = Purchases.configure(configuration);
  }

  void _checkSetAllowSharingStoreAccount() {
    bool allowSharing = false;
    Future<void> callback = Purchases.setAllowSharingStoreAccount(allowSharing);
  }

  void _checkAddCustomerInfoUpdateListener() {
    void customerInfolistener(CustomerInfo customerInfo) {}
    Purchases.addCustomerInfoUpdateListener(customerInfolistener);
  }

  void _checkRemoveCustomerInfoUpdateListener() {
    void customerInfolistener(CustomerInfo customerInfo) {}
    Purchases.removeCustomerInfoUpdateListener(customerInfolistener);
  }

  void _checkAddReadyForPromotedProductPurchaseListener() {
    void listener(String productIdentifier,
        Future<PromotedPurchaseResult> Function() startPurchase) {}
    Purchases.addReadyForPromotedProductPurchaseListener(listener);
  }

  void _checkRemoveReadyForPromotedProductPurchaseListener() {
    void listener(String productIdentifier,
        Future<PromotedPurchaseResult> Function() startPurchase) {}
    Purchases.removeReadyForPromotedProductPurchaseListener(listener);
  }

  void _checkGetOfferings() async {
    Offerings offerings = await Purchases.getOfferings();
  }

  void _checkGetCurrentOfferingForPlacement() async {
    Offering? offering = await Purchases.getCurrentOfferingForPlacement('');
  }

  void _checkSyncAttributesAndOfferingsIfNeeded() async {
    Offerings offerings = await Purchases.syncAttributesAndOfferingsIfNeeded();
  }

  void _checkGetProducts() async {
    List<String> productIdentifiers = List.empty();
    PurchaseType purchaseType = PurchaseType.subs;
    List<StoreProduct> products =
        await Purchases.getProducts(productIdentifiers);
    products =
        await Purchases.getProducts(productIdentifiers, type: purchaseType);
  }

  void _checkPurchaseProduct() async {
    String productIdentifier = "fakeProductId";
    UpgradeInfo? upgradeInfo;
    GoogleProductChangeInfo? googleProductChangeInfo;
    PurchaseType purchaseType = PurchaseType.subs;
    ProductCategory productType = ProductCategory.subscription;
    PurchaseResult purchaseResult = await Purchases.purchaseProduct(
        productIdentifier,
        type: purchaseType,
        upgradeInfo: upgradeInfo);
    purchaseResult = await Purchases.purchaseProduct(productIdentifier,
        upgradeInfo: upgradeInfo);
    purchaseResult = await Purchases.purchaseProduct(productIdentifier);
  }

  void _checkPurchaseStoreProduct(StoreProduct storeProduct) async {
    GoogleProductChangeInfo? googleProductChangeInfo;
    PurchaseResult purchaseResult = await Purchases.purchaseStoreProduct(
        storeProduct,
        googleProductChangeInfo: googleProductChangeInfo,
        googleIsPersonalizedPrice: true);
    purchaseResult = await Purchases.purchaseStoreProduct(storeProduct,
        googleIsPersonalizedPrice: true);
    purchaseResult = await Purchases.purchaseStoreProduct(storeProduct,
        googleProductChangeInfo: googleProductChangeInfo);
    purchaseResult = await Purchases.purchaseStoreProduct(storeProduct);
  }

  void _checkPurchasePackage(Package package) async {
    UpgradeInfo? upgradeInfo;
    GoogleProductChangeInfo? googleProductChangeInfo;
    PurchaseResult purchaseResult =
        await Purchases.purchasePackage(package, upgradeInfo: upgradeInfo);
    purchaseResult = await Purchases.purchasePackage(package,
        googleProductChangeInfo: googleProductChangeInfo,
        googleIsPersonalizedPrice: true);
    purchaseResult = await Purchases.purchasePackage(package,
        upgradeInfo: upgradeInfo, googleIsPersonalizedPrice: true);
    purchaseResult = await Purchases.purchasePackage(package,
        googleIsPersonalizedPrice: true);
  }

  void _checkPurchaseSubscriptionOption(SubscriptionOption subscriptionOption,
      GoogleProductChangeInfo? googleProductChangeInfo) async {
    PurchaseResult purchaseResult = await Purchases.purchaseSubscriptionOption(
        subscriptionOption,
        googleProductChangeInfo: googleProductChangeInfo);
    purchaseResult = await Purchases.purchaseSubscriptionOption(
        subscriptionOption,
        googleProductChangeInfo: googleProductChangeInfo,
        googleIsPersonalizedPrice: true);
    purchaseResult = await Purchases.purchaseSubscriptionOption(
        subscriptionOption,
        googleIsPersonalizedPrice: true);
    purchaseResult =
        await Purchases.purchaseSubscriptionOption(subscriptionOption);
  }

  void _checkPurchaseDiscountedProduct(
      StoreProduct product, PromotionalOffer offer) async {
    PurchaseResult purchaseResult =
        await Purchases.purchaseDiscountedProduct(product, offer);
  }

  void _checkPurchaseDiscountedPackage(
      Package package, PromotionalOffer offer) async {
    PurchaseResult purchaseResult =
        await Purchases.purchaseDiscountedPackage(package, offer);
  }

  void _checkRestorePurchases() async {
    CustomerInfo customerInfo = await Purchases.restorePurchases();
  }

  void _checkAppUserId() async {
    String appUserId = await Purchases.appUserID;
  }

  void _checkStorefront() async {
    Storefront? storefront = await Purchases.storefront;
  }

  void _checkLogIn() async {
    LogInResult logInResult = await Purchases.logIn("fakeUserId");
  }

  void _checkLogOut() async {
    CustomerInfo customerInfo = await Purchases.logOut();
  }

  void _checkSetDebugLogsEnabled() {
    bool setDebugLogsEnabled = false;
    Future<void> setDebugLogsEnabledFuture =
        Purchases.setDebugLogsEnabled(setDebugLogsEnabled);
  }

  void _checkSetLogLevel() {
    LogLevel logLevel = LogLevel.debug;
    Future<void> setLogLevelFuture = Purchases.setLogLevel(logLevel);
  }

  void _checkLogLevels(LogLevel level) {
    switch (level) {
      case LogLevel.verbose:
      case LogLevel.debug:
      case LogLevel.info:
      case LogLevel.warn:
      case LogLevel.error:
        break;
    }
  }

  void _checkLogHandler(LogHandler logHandler) {
    Future<void> setLogHandler =
        Purchases.setLogHandler((LogLevel logLevel, String message) {});
    Purchases.setLogHandler(logHandler);
  }

  void _checkSetSimulatesAskToBuyInSandbox() {
    bool setSimulatesAskToBuyInSandbox = false;
    Future<void> future =
        Purchases.setSimulatesAskToBuyInSandbox(setSimulatesAskToBuyInSandbox);
  }

  void _checkSetProxyUrl() {
    String proxyUrl = "fakeProxyUrl";
    Future<void> future = Purchases.setProxyURL(proxyUrl);
  }

  void _checkGetCustomerInfo() async {
    CustomerInfo customerInfo = await Purchases.getCustomerInfo();
  }

  void _checkSyncPurchases() {
    Future<void> future = Purchases.syncPurchases();
  }

  void _checkRecordPurchase() async {
    String productIdentifier = "product_id";
    Future<void> future = Purchases.recordPurchase(productIdentifier);
  }

  void _checkEnableAdServicesAttributionTokenCollection() {
    Future<void> future =
        Purchases.enableAdServicesAttributionTokenCollection();
  }

  void _checkIsAnonymous() async {
    bool isAnonymous = await Purchases.isAnonymous;
  }

  void _checkIsConfigured() async {
    bool isConfigured = await Purchases.isConfigured;
  }

  void _checkCheckTrialOrIntroductoryPriceEligibility() async {
    List<String> productIdentifiers = List.empty();
    Map<String, IntroEligibility> result;
    result = await Purchases.checkTrialOrIntroductoryPriceEligibility(
        productIdentifiers);
  }

  void _checkInvalidateCustomerInfoCache() {
    Future<void> future = Purchases.invalidateCustomerInfoCache();
  }

  void _checkPresentCodeRedemptionSheet() {
    Future<void> future = Purchases.presentCodeRedemptionSheet();
  }

  void _checkSetAttributes() {
    Map<String, String> attributes = Map.identity();
    Future<void> future = Purchases.setAttributes(attributes);
  }

  void _checkSetEmail() {
    String email = "fakeEmail";
    Future<void> future = Purchases.setEmail(email);
  }

  void _checkSetPhoneNumber() {
    String phoneNumber = "fakePhoneNumber";
    Future<void> future = Purchases.setPhoneNumber(phoneNumber);
  }

  void _checkSetDisplayName() {
    String displayName = "fakeDisplayName";
    Future<void> future = Purchases.setDisplayName(displayName);
  }

  void _checkSetPushToken() {
    String pushToken = "fakePushToken";
    Future<void> future = Purchases.setPushToken(pushToken);
  }

  void _checkSetAdjustId() {
    String id = "fakeId";
    Future<void> future = Purchases.setAdjustID(id);
  }

  void _checkSetAppsflyerId() {
    String id = "fakeId";
    Future<void> future = Purchases.setAppsflyerID(id);
  }

  void _checkSetFBAnonymousId() {
    String id = "fakeId";
    Future<void> future = Purchases.setFBAnonymousID(id);
  }

  void _checkSetMparticleId() {
    String id = "fakeId";
    Future<void> future = Purchases.setMparticleID(id);
  }

  void _checkSetCleverTapID() {
    String id = "fakeId";
    Future<void> future = Purchases.setCleverTapID(id);
  }

  void _checkSetMixpanelDistinctID() {
    String id = "fakeId";
    Future<void> future = Purchases.setMixpanelDistinctID(id);
  }

  void _checkSetFirebaseAppInstanceId() {
    String id = "fakeId";
    Future<void> future = Purchases.setFirebaseAppInstanceId(id);
  }

  void _checkSetTenjinAnalyticsInstallationId() {
    String id = "fakeId";
    Future<void> future = Purchases.setTenjinAnalyticsInstallationID(id);
  }

  void _checkSetOnesignalId() {
    String id = "fakeId";
    Future<void> future = Purchases.setOnesignalID(id);
  }

  void _checkSetAirshipChannelId() async {
    String id = "fakeId";
    await Purchases.setAirshipChannelID(id);
  }

  void _checkSetMediaSource() {
    String mediaSource = "fakeMediaSource";
    Future<void> future = Purchases.setMediaSource(mediaSource);
  }

  void _checkSetCampaign() {
    String campaign = "fakeCampaign";
    Future<void> future = Purchases.setCampaign(campaign);
  }

  void _checkSetAdGroup() {
    String adGroup = "fakeAdGroup";
    Future<void> future = Purchases.setAdGroup(adGroup);
  }

  void _checkSetAd() {
    String ad = "fakeAd";
    Future<void> future = Purchases.setAd(ad);
  }

  void _checkSetKeyWord() {
    String keyword = "fakeKeyword";
    Future<void> future = Purchases.setKeyword(keyword);
  }

  void _checkSetCreative() {
    String creative = "fakeCreative";
    Future<void> future = Purchases.setCreative(creative);
  }

  void _checkCollectDeviceIdentifiers() {
    Future<void> future = Purchases.collectDeviceIdentifiers();
  }

  void _checkCanMakePayments() async {
    List<BillingFeature> features = List.empty();
    await Purchases.canMakePayments();
    await Purchases.canMakePayments(features);
  }

  void _checkGetPromotionalOffer(
      StoreProduct product, StoreProductDiscount discount) async {
    PromotionalOffer offer =
        await Purchases.getPromotionalOffer(product, discount);
  }

  void _checkClose() {
    Future<void> future = Purchases.close();
  }

  void _checkUpgradeInfo() {
    String oldSku = "fakeOldSku";
    ProrationMode? prorationMode;

    UpgradeInfo purchaseInfo = UpgradeInfo(oldSku);
    purchaseInfo = UpgradeInfo(oldSku, prorationMode: prorationMode);
    String storedOldSku = purchaseInfo.oldSKU;
    ProrationMode? storedProrationMode = purchaseInfo.prorationMode;
  }

  void _checkGoogleProductChangeInfoInfo() {
    String oldProductIdentifier = "fakeOldProductIdentifier";
    GoogleProrationMode? prorationMode;

    GoogleProductChangeInfo purchaseInfo =
        GoogleProductChangeInfo(oldProductIdentifier);
    purchaseInfo = GoogleProductChangeInfo(oldProductIdentifier,
        prorationMode: prorationMode);
    String storedOldProductIdentifier = purchaseInfo.oldProductIdentifier;
    GoogleProrationMode? storedProrationMode = purchaseInfo.prorationMode;
  }

  void _checkProrationMode(ProrationMode prorationMode) {
    switch (prorationMode) {
      case ProrationMode.unknownSubscriptionUpgradeDowngradePolicy:
      case ProrationMode.immediateWithTimeProration:
      case ProrationMode.immediateAndChargeProratedPrice:
      case ProrationMode.immediateWithoutProration:
      case ProrationMode.immediateAndChargeFullPrice:
        break;
    }
  }

  void _checkGoogleProrationMode(GoogleProrationMode prorationMode) {
    switch (prorationMode) {
      case GoogleProrationMode.immediateWithTimeProration:
      case GoogleProrationMode.immediateWithoutProration:
      case GoogleProrationMode.immediateAndChargeFullPrice:
      case GoogleProrationMode.immediateAndChargeProratedPrice:
      case GoogleProrationMode.deferred:
        break;
    }
  }

  void _checkProductCategory(ProductCategory type) {
    switch (type) {
      case ProductCategory.subscription:
      case ProductCategory.nonSubscription:
        break;
    }
  }

  void _checkPurchaseType(PurchaseType type) {
    switch (type) {
      case PurchaseType.subs:
      case PurchaseType.inapp:
        break;
    }
  }

  void _checkBillingFeature(BillingFeature feature) {
    switch (feature) {
      case BillingFeature.subscriptions:
      case BillingFeature.subscriptionsUpdate:
      case BillingFeature.inAppItemsOnVr:
      case BillingFeature.subscriptionsOnVr:
      case BillingFeature.priceChangeConfirmation:
        break;
    }
  }

  void _checkIntroEligibilityStatus(IntroEligibilityStatus status) {
    switch (status) {
      case IntroEligibilityStatus.introEligibilityStatusUnknown:
      case IntroEligibilityStatus.introEligibilityStatusIneligible:
      case IntroEligibilityStatus.introEligibilityStatusEligible:
      case IntroEligibilityStatus.introEligibilityStatusNoIntroOfferExists:
        break;
    }
  }

  void _checkInAppMessageType(InAppMessageType messageType) {
    switch (messageType) {
      case InAppMessageType.billingIssue:
      case InAppMessageType.priceIncreaseConsent:
      case InAppMessageType.generic:
      case InAppMessageType.winBackOffer:
        break;
    }
  }

  void _checkIntroEligibility() {
    Map<String, dynamic> json = Map.identity();
    IntroEligibility introEligibility = IntroEligibility.fromJson(json);
    IntroEligibilityStatus status = introEligibility.status;
    String description = introEligibility.description;
  }

  void _checkLogInResult(CustomerInfo customerInfo) {
    bool created = false;
    LogInResult logInResult =
        LogInResult(created: created, customerInfo: customerInfo);
    bool storedCreated = logInResult.created;
    CustomerInfo storedCustomerInfo = logInResult.customerInfo;
  }

  void _checkPromotedPurchaseResult(CustomerInfo customerInfo) {
    String productIdentifier = "fakeProductId";
    PromotedPurchaseResult purchaseResult = PromotedPurchaseResult(
        productIdentifier: productIdentifier, customerInfo: customerInfo);
    String storedProductIdentifier = purchaseResult.productIdentifier;
    CustomerInfo storedCustomerInfo = purchaseResult.customerInfo;
  }

  void _checkRefundRequestStatus(RefundRequestStatus status) {
    switch (status) {
      case RefundRequestStatus.success:
      case RefundRequestStatus.userCancelled:
      case RefundRequestStatus.error:
        break;
    }
    int statusCode = 0;
    RefundRequestStatus processedStatus =
        RefundRequestStatusExtension.from(statusCode);
  }

  void _checkBeginRefundRequestForActiveEntitlement() async {
    RefundRequestStatus status =
        await Purchases.beginRefundRequestForActiveEntitlement();
  }

  void _checkBeginRefundRequestForProduct(StoreProduct product) async {
    RefundRequestStatus status =
        await Purchases.beginRefundRequestForProduct(product);
  }

  void _checkBeginRefundRequestForEntitlement(
      EntitlementInfo entitlement) async {
    RefundRequestStatus status =
        await Purchases.beginRefundRequestForEntitlement(entitlement);
  }

  void _checkSyncObserverModeAmazonPurchase(String productID, String receiptID,
      String amazonUserID, String? isoCurrencyCode, double? price) async {
    Future<void> future = Purchases.syncObserverModeAmazonPurchase(
        productID, receiptID, amazonUserID, isoCurrencyCode, price);
  }

  void _checkSyncAmazonPurchase(String productID, String receiptID,
      String amazonUserID, String? isoCurrencyCode, double? price) async {
    Future<void> future = Purchases.syncAmazonPurchase(
        productID, receiptID, amazonUserID, isoCurrencyCode, price);
  }

  void _showInAppMessages() async {
    Future<void> future = Purchases.showInAppMessages(types: {
      InAppMessageType.billingIssue,
      InAppMessageType.priceIncreaseConsent,
      InAppMessageType.generic,
      InAppMessageType.winBackOffer
    });
  }

  void _checkStoreKitVersion(StoreKitVersion storeKitVersion) {
    switch (storeKitVersion) {
      case StoreKitVersion.storeKit1:
      case StoreKitVersion.storeKit2:
      case StoreKitVersion.defaultVersion:
        break;
    }
  }

  void _checkPurchasesAreCompletedBy() {
    PurchasesAreCompletedBy myApp = PurchasesAreCompletedByMyApp(
      storeKitVersion: StoreKitVersion.defaultVersion,
    );
    PurchasesAreCompletedBy revenueCat =
        const PurchasesAreCompletedByRevenueCat();
  }

  void _checkWebPurchaseRedemption(String urlString) async {
    WebPurchaseRedemption? webPurchaseRedemption = await Purchases.parseAsWebPurchaseRedemption(urlString);
    WebPurchaseRedemptionResult? result = await Purchases.redeemWebPurchase(webPurchaseRedemption!);
  }

  void _checkGetVirtualCurrencies() async {
    VirtualCurrencies virtualCurrencies = await Purchases.getVirtualCurrencies();
  }

  void _checkInvalidateVirtualCurrenciesCache() {
    Future<void> future = Purchases.invalidateVirtualCurrenciesCache();
  }

  void _checkGetCachedVirtualCurrencies() async {
    VirtualCurrencies? virtualCurrencies = await Purchases.getCachedVirtualCurrencies();
  }
}

Future<PurchaseResult> _checkFetchAndPurchaseWinBackOffersForProduct(
    StoreProduct product) async {
  List<WinBackOffer>? offers =
      await Purchases.getEligibleWinBackOffersForProduct(product);

  return await Purchases.purchaseProductWithWinBackOffer(product, offers[0]);
}

Future<PurchaseResult> _checkFetchAndPurchaseWinBackOffersForPackage(
    Package package) async {
  List<WinBackOffer>? offers =
      await Purchases.getEligibleWinBackOffersForPackage(package);

  return await Purchases.purchasePackageWithWinBackOffer(package, offers[0]);
}
