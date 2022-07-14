import 'package:purchases_flutter/purchases_flutter.dart';

// ignore_for_file: unused_element
// ignore_for_file: unused_local_variable
// ignore_for_file: deprecated_member_use
class _PurchasesFlutterApiTest {
  void _checkSetup() {
    String apiKey = "fakeApiKey";
    String? userId = "fakeUserId";
    bool observerMode = false;
    String? userDefaultsSuiteName = "fakeSuiteName";
    bool useAmazon = false;
    Future<void> callback = Purchases.setup(apiKey,
        appUserId: userId,
        observerMode: observerMode,
        userDefaultsSuiteName: userDefaultsSuiteName,
        useAmazon: useAmazon);
  }

  void _checkConfigure() {
    PurchasesConfiguration configuration = PurchasesConfiguration("fakeApiKey");
    Future<void> callback = Purchases.configure(configuration);
  }

  void _checkSetFinishTransactions() {
    bool finishTransactions = false;
    Future<void> callback = Purchases.setFinishTransactions(finishTransactions);
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
    PurchaseType purchaseType = PurchaseType.subs;
    CustomerInfo customerInfo = await Purchases.purchaseProduct(
        productIdentifier,
        upgradeInfo: upgradeInfo,
        type: purchaseType);
    customerInfo = await Purchases.purchaseProduct(productIdentifier,
        upgradeInfo: upgradeInfo);
  }

  void _checkPurchasePackage(Package package) async {
    UpgradeInfo? upgradeInfo;
    CustomerInfo customerInfo =
        await Purchases.purchasePackage(package, upgradeInfo: upgradeInfo);
  }

  void _checkPurchaseDiscountedProduct(
      StoreProduct product, PromotionalOffer offer) async {
    CustomerInfo customerInfo =
        await Purchases.purchaseDiscountedProduct(product, offer);
  }

  void _checkPurchaseDiscountedPackage(
      Package package, PromotionalOffer offer) async {
    CustomerInfo customerInfo =
        await Purchases.purchaseDiscountedPackage(package, offer);
  }

  void _checkRestorePurchases() async {
    CustomerInfo customerInfo = await Purchases.restorePurchases();
  }

  void _checkAppUserId() async {
    String appUserId = await Purchases.appUserID;
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

  void _checkSetAutomaticAppleSearchAdsAttributionCollection() {
    Future<void> future;
    bool enabled = false;
    future = Purchases.setAutomaticAppleSearchAdsAttributionCollection(enabled);
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

  void _checkProrationMode(ProrationMode prorationMode) {
    switch (prorationMode) {
      case ProrationMode.unknownSubscriptionUpgradeDowngradePolicy:
      case ProrationMode.immediateWithTimeProration:
      case ProrationMode.immediateAndChargeProratedPrice:
      case ProrationMode.immediateWithoutProration:
      case ProrationMode.deferred:
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
}
