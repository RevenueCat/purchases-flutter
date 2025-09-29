#import "PurchasesFlutterPlugin.h"

@import StoreKit;

@import PurchasesHybridCommon;

typedef void (^RCPurchaseCompletedBlock)(RCStoreTransaction * _Nullable,
                                         RCCustomerInfo * _Nullable,
                                         NSError * _Nullable,
                                         BOOL userCancelled);
typedef void (^RCStartPurchaseBlock)(RCPurchaseCompletedBlock);

@interface PurchasesFlutterPlugin () <RCPurchasesDelegate>

@property (nonatomic, retain) FlutterMethodChannel *channel;
@property (nonatomic, retain) NSObject <FlutterPluginRegistrar> *registrar;
@property (nonatomic, retain) NSMutableArray<RCStartPurchaseBlock> *startPurchaseBlocks;

@end

NSString *PurchasesCustomerInfoUpdatedEvent = @"Purchases-CustomerInfoUpdated";
NSString *PurchasesReadyForPromotedProductPurchaseEvent = @"Purchases-ReadyForPromotedProductPurchase";
NSString *PurchasesLogHandlerEvent = @"Purchases-LogHandlerEvent";

@implementation PurchasesFlutterPlugin

- (instancetype)initWithChannel:(FlutterMethodChannel *)channel
                      registrar:(NSObject <FlutterPluginRegistrar> *)registrar {
    self = [super init];
    NSAssert(self, @"super init cannot be nil");
    self.channel = channel;
    self.registrar = registrar;

    return self;
}

+ (void)registerWithRegistrar:(NSObject <FlutterPluginRegistrar> *)registrar {
    FlutterMethodChannel *channel = [FlutterMethodChannel methodChannelWithName:@"purchases_flutter"
                                                                binaryMessenger:[registrar messenger]];
    PurchasesFlutterPlugin *instance = [[PurchasesFlutterPlugin alloc] initWithChannel:channel registrar:registrar];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall *)call
                  result:(FlutterResult)result {
    NSDictionary *arguments = call.arguments;
    if ([@"setupPurchases" isEqualToString:call.method]) {
        NSString *apiKey = arguments[@"apiKey"];
        NSString *appUserID = arguments[@"appUserId"];
        NSString *purchasesAreCompletedBy = arguments[@"purchasesAreCompletedBy"];
		BOOL shouldShowInAppMessagesAutomatically = YES;
        id object = arguments[@"shouldShowInAppMessagesAutomatically"];
        if (object != [NSNull null] && object != nil) {
            shouldShowInAppMessagesAutomatically = [object boolValue];
        }
        NSString * _Nullable verificationMode = arguments[@"entitlementVerificationMode"];
        NSString * _Nullable userDefaultsSuiteName = arguments[@"userDefaultsSuiteName"];
        NSString *storeKitVersion = arguments[@"storeKitVersion"];
        [self setupPurchases:apiKey
                   appUserID:appUserID
     purchasesAreCompletedBy:purchasesAreCompletedBy
       userDefaultsSuiteName:userDefaultsSuiteName
             storeKitVersion: storeKitVersion
shouldShowInAppMessagesAutomatically: shouldShowInAppMessagesAutomatically
            verificationMode:verificationMode
                      result:result];
    } else if ([@"setAllowSharingStoreAccount" isEqualToString:call.method]) {
        [self setAllowSharingStoreAccount:[arguments[@"allowSharing"] boolValue] result:result];
    } else if ([@"getOfferings" isEqualToString:call.method]) {
        [self getOfferingsWithResult:result];
    } else if ([@"getCurrentOfferingForPlacement" isEqualToString:call.method]) {
        [self getCurrentOfferingForPlacement:arguments[@"placementIdentifier"]
                                       result:result];
    } else if ([@"syncAttributesAndOfferingsIfNeeded" isEqualToString:call.method]) {
        [self syncAttributesAndOfferingsIfNeededWithResult:result];
    } else if ([@"getProductInfo" isEqualToString:call.method]) {
        [self getProductInfo:arguments[@"productIdentifiers"] result:result];
    } else if ([@"purchaseProduct" isEqualToString:call.method]) {
        [self purchaseProduct:arguments[@"productIdentifier"]
      signedDiscountTimestamp:arguments[@"signedDiscountTimestamp"]
                       result:result];
    } else if ([@"purchasePackage" isEqualToString:call.method]) {
        [self purchasePackage:arguments[@"packageIdentifier"]
     presentedOfferingContext:arguments[@"presentedOfferingContext"]
      signedDiscountTimestamp:arguments[@"signedDiscountTimestamp"]
                       result:result];
    } else if ([@"getAppUserID" isEqualToString:call.method]) {
        [self getAppUserIDWithResult:result];
    } else if ([@"getStorefront" isEqualToString:call.method]) {
        [self getStorefrontWithResult:result];
    } else if ([@"restorePurchases" isEqualToString:call.method]) {
        [self restorePurchasesWithResult:result];
    } else if ([@"logOut" isEqualToString:call.method]) {
        [self logOutWithResult:result];
    } else if ([@"logIn" isEqualToString:call.method]) {
        [self logInAppUserID:arguments[@"appUserID"] result:result];
    } else if ([@"setDebugLogsEnabled" isEqualToString:call.method]) {
        [self setDebugLogsEnabled:[arguments[@"enabled"] boolValue] result:result];
    } else if ([@"setLogLevel" isEqualToString:call.method]) {
        [self setLogLevel:arguments[@"level"] result:result];
    } else if ([@"setSimulatesAskToBuyInSandbox" isEqualToString:call.method]) {
        [self setSimulatesAskToBuyInSandbox:[arguments[@"enabled"] boolValue] result:result];
    } else if ([@"setProxyURLString" isEqualToString:call.method]) {
        [self setProxyURLString:arguments[@"proxyURLString"] result:result];
    } else if ([@"getCustomerInfo" isEqualToString:call.method]) {
        [self getCustomerInfoWithResult:result];
    } else if ([@"syncPurchases" isEqualToString:call.method]) {
        [self syncPurchasesWithResult:result];
    } else if ([@"enableAdServicesAttributionTokenCollection" isEqualToString:call.method]) {
        [self enableAdServicesAttributionTokenCollection:result];
    } else if ([@"recordPurchaseForProductID" isEqualToString:call.method]) {
        [self recordPurchaseForProductID:arguments[@"productIdentifier"] result:result];
    } else if ([@"isAnonymous" isEqualToString:call.method]) {
        [self isAnonymousWithResult:result];
    } else if ([@"isConfigured" isEqualToString:call.method]) {
        [self isConfiguredWithResult:result];
    } else if ([@"checkTrialOrIntroductoryPriceEligibility" isEqualToString:call.method]) {
        [self checkTrialOrIntroductoryPriceEligibility:arguments[@"productIdentifiers"] result:result];
    } else if ([@"invalidateCustomerInfoCache" isEqualToString:call.method]) {
        [self invalidateCustomerInfoCacheWithResult:result];
    } else if ([@"presentCodeRedemptionSheet" isEqualToString:call.method]) {
        [self presentCodeRedemptionSheetWithResult:result];
    } else if ([@"setAttributes" isEqualToString:call.method]) {
        NSDictionary *attributes = arguments[@"attributes"];
        [self setAttributes:attributes result:result];
    } else if ([@"setEmail" isEqualToString:call.method]) {
        NSString *email = arguments[@"email"];
        [self setEmail:email result:result];
    } else if ([@"setPhoneNumber" isEqualToString:call.method]) {
        NSString *phoneNumber = arguments[@"phoneNumber"];
        [self setPhoneNumber:phoneNumber result:result];
    } else if ([@"setDisplayName" isEqualToString:call.method]) {
        NSString *displayName = arguments[@"displayName"];
        [self setDisplayName:displayName result:result];
    } else if ([@"setPushToken" isEqualToString:call.method]) {
        NSString *pushToken = arguments[@"pushToken"];
        [self setPushToken:pushToken result:result];
    } else if ([@"setAdjustID" isEqualToString:call.method]) {
        NSString *adjustID = arguments[@"adjustID"];
        [self setAdjustID:adjustID result:result];
    } else if ([@"setAppsflyerID" isEqualToString:call.method]) {
        NSString *appsflyerID = arguments[@"appsflyerID"];
        [self setAppsflyerID:appsflyerID result:result];
    } else if ([@"setFBAnonymousID" isEqualToString:call.method]) {
        NSString *fbAnonymousID = arguments[@"fbAnonymousID"];
        [self setFBAnonymousID:fbAnonymousID result:result];
    } else if ([@"setMparticleID" isEqualToString:call.method]) {
        NSString *mparticleID = arguments[@"mparticleID"];
        [self setMparticleID:mparticleID result:result];
    } else if([@"setCleverTapID" isEqualToString:call.method]) {
        NSString *cleverTapID = arguments[@"cleverTapID"];
        [self setCleverTapID:cleverTapID result:result];
    } else if([@"setMixpanelDistinctID" isEqualToString:call.method]) {
        NSString *mixpanelDistinctID = arguments[@"mixpanelDistinctID"];
        [self setMixpanelDistinctID:mixpanelDistinctID result:result];
    } else if([@"setFirebaseAppInstanceID" isEqualToString:call.method]) {
        NSString *firebaseAppInstanceID = arguments[@"firebaseAppInstanceID"];
        [self setFirebaseAppInstanceID:firebaseAppInstanceID result:result];
    } else if([@"setTenjinAnalyticsInstallationID" isEqualToString:call.method]) {
        NSString *tenjinAnalyticsInstallationID = arguments[@"tenjinAnalyticsInstallationID"];
        [self setTenjinAnalyticsInstallationID:tenjinAnalyticsInstallationID result:result];
    }else if ([@"setOnesignalID" isEqualToString:call.method]) {
        NSString *onesignalID = arguments[@"onesignalID"];
        [self setOnesignalID:onesignalID result:result];
    } else if ([@"setAirshipChannelID" isEqualToString:call.method]) {
        NSString *airshipChannelID = arguments[@"airshipChannelID"];
        [self setAirshipChannelID:airshipChannelID result:result];
    } else if ([@"setMediaSource" isEqualToString:call.method]) {
        NSString *mediaSource = arguments[@"mediaSource"];
        [self setMediaSource:mediaSource result:result];
    } else if ([@"setCampaign" isEqualToString:call.method]) {
        NSString *campaign = arguments[@"campaign"];
        [self setCampaign:campaign result:result];
    } else if ([@"setAdGroup" isEqualToString:call.method]) {
        NSString *adGroup = arguments[@"adGroup"];
        [self setAdGroup:adGroup result:result];
    } else if ([@"setAd" isEqualToString:call.method]) {
        NSString *ad = arguments[@"ad"];
        [self setAd:ad result:result];
    } else if ([@"setKeyword" isEqualToString:call.method]) {
        NSString *keyword = arguments[@"keyword"];
        [self setKeyword:keyword result:result];
    } else if ([@"setCreative" isEqualToString:call.method]) {
        NSString *creative = arguments[@"creative"];
        [self setCreative:creative result:result];
    } else if ([@"collectDeviceIdentifiers" isEqualToString:call.method]) {
        [self collectDeviceIdentifiersWithResult:result];
    } else if ([@"canMakePayments" isEqualToString:call.method]) {
          NSArray<NSNumber*> *features = arguments[@"features"];
          [self canMakePaymentsWithFeatures:features result:result];
    } else if ([@"beginRefundRequestForActiveEntitlement" isEqualToString:call.method]) {
#if TARGET_OS_IPHONE
        [self beginRefundRequestForActiveEntitlementWithResult:result];
#else
        result(nil);
#endif
    } else if ([@"beginRefundRequestForProduct" isEqualToString:call.method]) {
#if TARGET_OS_IPHONE
        NSString *productID = arguments[@"productIdentifier"];
        [self beginRefundRequestForProduct:productID result:result];
#else
        result(nil);
#endif
    } else if ([@"beginRefundRequestForEntitlement" isEqualToString:call.method]) {
#if TARGET_OS_IPHONE
        NSString *entitlementID = arguments[@"entitlementIdentifier"];
        [self beginRefundRequestForEntitlement:entitlementID result:result];
#else
        result(nil);
#endif
    } else if ([@"getPromotionalOffer" isEqualToString:call.method]) {
        NSString *productIdentifier = arguments[@"productIdentifier"];
        NSString *discountIdentifier = arguments[@"discountIdentifier"];
        [self promotionalOfferForProductIdentifier:productIdentifier
                                discountIdentifier:discountIdentifier
                                            result:result];
    } else if ([@"startPromotedProductPurchase" isEqualToString:call.method]) {
        NSNumber *callbackID = arguments[@"callbackID"];
        [self startPromotedProductPurchase:callbackID
                                    result:result];
    } else if ([@"showInAppMessages" isEqualToString:call.method]) {
        NSArray<NSNumber*>* types = arguments[@"types"];
        [self showInAppMessages:types result:result];
    } else if ([@"close" isEqualToString:call.method]) {
        [self closeWithResult:result];
    } else if ([@"setLogHandler" isEqualToString:call.method]) {
        [self setLogHandlerWithResult:result];
    } else if ([@"syncAmazonPurchase" isEqualToString:call.method]) {
        // NOOP
        result(nil);
    } else if ([@"eligibleWinBackOffersForProduct" isEqualToString:call.method]) {
        [self eligibleWinBackOffersForProduct:arguments[@"productIdentifier"] result:result];
    } else if ([@"purchaseProductWithWinBackOffer" isEqualToString:call.method]) {
        [self purchaseProductWithWinBackOffer:arguments[@"productIdentifier"]
                       winBackOfferIdentifier:arguments[@"winBackOfferIdentifier"]
                                       result:result];
    } else if ([@"purchasePackageWithWinBackOffer" isEqualToString:call.method]) {
        [self purchasePackageWithWinBackOffer:arguments[@"packageIdentifier"]
                     presentedOfferingContext:arguments[@"presentedOfferingContext"]
                       winBackOfferIdentifier:arguments[@"winBackOfferIdentifier"]
                                     result:result];
    } else if ([@"isWebPurchaseRedemptionURL" isEqualToString:call.method]) {
        result([NSNumber numberWithBool:[RCCommonFunctionality isWebPurchaseRedemptionURL:arguments[@"urlString"]]]);
    } else if ([@"redeemWebPurchase" isEqualToString:call.method]) {
        [RCCommonFunctionality redeemWebPurchaseWithUrlString:arguments[@"redemptionLink"]
                                                   completion:[self getResponseCompletionBlock:result]];
    } else {
        result(FlutterMethodNotImplemented);
    }
}

- (void)setupPurchases:(NSString *)apiKey
             appUserID:(NSString *)appUserID
purchasesAreCompletedBy:(nullable NSString *)purchasesAreCompletedBy
 userDefaultsSuiteName:(nullable NSString *)userDefaultsSuiteName
       storeKitVersion:(nullable NSString *)storeKitVersion
shouldShowInAppMessagesAutomatically:(BOOL)shouldShowInAppMessagesAutomatically
      verificationMode:(nullable NSString *)verificationMode
                result:(FlutterResult)result {
    if ([appUserID isKindOfClass:NSNull.class]) {
        appUserID = nil;
    }
    if ([userDefaultsSuiteName isKindOfClass:NSNull.class]) {
        userDefaultsSuiteName = nil;
    }

    RCPurchases *purchases = [RCPurchases configureWithAPIKey:apiKey
                                                    appUserID:appUserID
                                      purchasesAreCompletedBy:purchasesAreCompletedBy
                                        userDefaultsSuiteName:userDefaultsSuiteName
                                               platformFlavor:self.platformFlavor
                                        platformFlavorVersion:self.platformFlavorVersion
                                              storeKitVersion:storeKitVersion
                                            dangerousSettings:nil
                         shouldShowInAppMessagesAutomatically:shouldShowInAppMessagesAutomatically
                                             verificationMode:verificationMode];
    purchases.delegate = self;

    result(nil);
}

- (void)setAllowSharingStoreAccount:(BOOL)allowSharingStoreAccount
                             result:(FlutterResult)result {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
    [RCCommonFunctionality setAllowSharingStoreAccount:allowSharingStoreAccount];
#pragma GCC diagnostic pop
    result(nil);
}

- (void)getOfferingsWithResult:(FlutterResult)result {
    [RCCommonFunctionality getOfferingsWithCompletionBlock:[self getResponseCompletionBlock:result]];
}

- (void)getCurrentOfferingForPlacement:(NSString *)placement
                             result:(FlutterResult)result {
    [RCCommonFunctionality getCurrentOfferingForPlacement:placement 
                                          completionBlock:[self getResponseCompletionBlock:result]];
}

- (void)syncAttributesAndOfferingsIfNeededWithResult:(FlutterResult)result {
    [RCCommonFunctionality syncAttributesAndOfferingsIfNeededWithCompletionBlock:[self getResponseCompletionBlock:result]];
}

- (void)getProductInfo:(NSArray *)products
                result:(FlutterResult)result {
    [RCCommonFunctionality getProductInfo:products completionBlock:^(NSArray<NSDictionary *> *productObjects) {
        result(productObjects);
    }];
}

- (void)purchaseProduct:(NSString *)productIdentifier
signedDiscountTimestamp:(nullable NSString *)discountTimestamp
                 result:(FlutterResult)result {
    [RCCommonFunctionality purchaseProduct:productIdentifier
                   signedDiscountTimestamp:discountTimestamp
                           completionBlock:[self getResponseCompletionBlock:result]];
}

- (void)purchasePackage:(NSString *)packageIdentifier
presentedOfferingContext:(NSDictionary *)presentedOfferingContext
signedDiscountTimestamp:(nullable NSString *)discountTimestamp
                 result:(FlutterResult)result {
    [RCCommonFunctionality purchasePackage:packageIdentifier
                  presentedOfferingContext:presentedOfferingContext
                   signedDiscountTimestamp:discountTimestamp
                           completionBlock:[self getResponseCompletionBlock:result]];
}

- (void)restorePurchasesWithResult:(FlutterResult)result {
    [RCCommonFunctionality restorePurchasesWithCompletionBlock:[self getResponseCompletionBlock:result]];
}

- (void)syncPurchasesWithResult:(FlutterResult)result {
    [RCCommonFunctionality syncPurchasesWithCompletionBlock:[self getResponseCompletionBlock:result]];
}

- (void)recordPurchaseForProductID:(NSString*)productId
                            result:(FlutterResult)result {
    if (@available(iOS 15.0, macOS 12.0, *)) {
        [RCCommonFunctionality recordPurchaseForProductID:productId
                                               completion:^(NSDictionary<NSString *,id> * _Nullable responseDictionary, RCErrorContainer * _Nullable error) {
            if (error) {
                [self rejectWithResult:result error:error];
            } else {
                result(responseDictionary);
            }
        }];
    } else {
        // Fallback on earlier versions
        NSLog(@"[Purchases] Warning: tried to call recordPurchaseForProductID, but it's only available on iOS 15.0 and macOS 12.0 or greater.");
        result(nil);
    }
}

- (void)getAppUserIDWithResult:(FlutterResult)result {
    result([RCCommonFunctionality appUserID]);
}

- (void)getStorefrontWithResult:(FlutterResult)result {
    [RCCommonFunctionality getStorefrontWithCompletion:^(NSDictionary<NSString *,id> * _Nullable storefrontMap) {
        result(storefrontMap);
    }];
}

- (void)logInAppUserID:(NSString * _Nullable)appUserID
                result:(FlutterResult)result {
    [RCCommonFunctionality logInWithAppUserID:appUserID completionBlock:[self getResponseCompletionBlock:result]];
}

- (void)logOutWithResult:(FlutterResult)result {
    [RCCommonFunctionality logOutWithCompletionBlock:[self getResponseCompletionBlock:result]];
}

- (void)setDebugLogsEnabled:(BOOL)enabled
                     result:(FlutterResult)result {
    [RCCommonFunctionality setDebugLogsEnabled:enabled];
    result(nil);
}

- (void)setLogLevel:(NSString *)level
             result:(FlutterResult)result {
    [RCCommonFunctionality setLogLevel:level];
    result(nil);
}

- (void)setProxyURLString:(nullable NSString *)proxyURLString
                   result:(FlutterResult)result {
    [RCCommonFunctionality setProxyURLString:proxyURLString];
    result(nil);
}

- (void)setSimulatesAskToBuyInSandbox:(BOOL)enabled
                               result:(FlutterResult)result {
    [RCCommonFunctionality setSimulatesAskToBuyInSandbox:enabled];
    result(nil);
}

- (void)getCustomerInfoWithResult:(FlutterResult)result {
    [RCCommonFunctionality getCustomerInfoWithCompletionBlock:[self getResponseCompletionBlock:result]];
}

- (void)enableAdServicesAttributionTokenCollection:(FlutterResult)result {
    if (@available(iOS 14.3, macOS 11.1, macCatalyst 14.3, *)) {
        [RCCommonFunctionality enableAdServicesAttributionTokenCollection];
    } else {
        NSLog(@"[Purchases] Warning: tried to enable AdServices attribution token collection, but it's only available on iOS 14.3 or greater or macOS 11.1 or greater.");
    }
    result(nil);
}

- (void)isAnonymousWithResult:(FlutterResult)result {
    result(@([RCCommonFunctionality isAnonymous]));
}

- (void)isConfiguredWithResult:(FlutterResult)result {
    result(@(RCPurchases.isConfigured));
}

- (void)checkTrialOrIntroductoryPriceEligibility:(NSArray *)products
                                          result:(FlutterResult)result {
    [RCCommonFunctionality checkTrialOrIntroductoryPriceEligibility:products
                                                    completionBlock:^(NSDictionary<NSString *, NSDictionary *> *_Nonnull responseDictionary) {
                      result([NSDictionary dictionaryWithDictionary:responseDictionary]);
    }];
}

- (void)invalidateCustomerInfoCacheWithResult:(FlutterResult)result {
    [RCCommonFunctionality invalidateCustomerInfoCache];
    result(nil);
}

- (void)presentCodeRedemptionSheetWithResult:(FlutterResult)result {
#if TARGET_OS_IOS
    if (@available(iOS 14.0, *)) {
        [RCCommonFunctionality presentCodeRedemptionSheet];
    } else {
        NSLog(@"[Purchases] Warning: tried to present codeRedemptionSheet, but it's only available on iOS 14.0 or greater.");
    }
#else
    NSLog(@"[Purchases] Warning: tried to present codeRedemptionSheet, but it's only available on iOS 14.0 or greater.");
#endif
    result(nil);
}

#pragma mark Subscriber Attributes

- (void)setAttributes:(NSDictionary *)attributes result:(FlutterResult)result {
    [RCCommonFunctionality setAttributes:attributes];
    result(nil);
}

- (void)setEmail:(NSString *)email result:(FlutterResult)result {
    [RCCommonFunctionality setEmail:email];
    result(nil);
}

- (void)setPhoneNumber:(NSString *)phoneNumber result:(FlutterResult)result {
    [RCCommonFunctionality setPhoneNumber:phoneNumber];
    result(nil);
}

- (void)setDisplayName:(NSString *)displayName result:(FlutterResult)result {
    [RCCommonFunctionality setDisplayName:displayName];
    result(nil);
}

- (void)setPushToken:(NSString *)pushToken result:(FlutterResult)result {
    [RCCommonFunctionality setPushToken:pushToken];
    result(nil);
}

- (void)setAdjustID:(nullable NSString *)adjustID result:(FlutterResult)result {
    [RCCommonFunctionality setAdjustID:adjustID];
    result(nil);
}

- (void)setAppsflyerID:(nullable NSString *)appsflyerID result:(FlutterResult)result {
    [RCCommonFunctionality setAppsflyerID:appsflyerID];
    result(nil);
}

- (void)setFBAnonymousID:(nullable NSString *)fbAnonymousID result:(FlutterResult)result {
    [RCCommonFunctionality setFBAnonymousID:fbAnonymousID];
    result(nil);
}

- (void)setMparticleID:(nullable NSString *)mparticleID result:(FlutterResult)result {
    [RCCommonFunctionality setMparticleID:mparticleID];
    result(nil);
}

- (void)setCleverTapID:(nullable NSString *)cleverTapID result:(FlutterResult)result {
    [RCCommonFunctionality setCleverTapID:cleverTapID];
    result(nil);
}

- (void)setMixpanelDistinctID:(nullable NSString *)mixpanelDistinctID result:(FlutterResult)result {
    [RCCommonFunctionality setMixpanelDistinctID:mixpanelDistinctID];
    result(nil);
}

- (void)setFirebaseAppInstanceID:(nullable NSString *)firebaseAppInstanceId result:(FlutterResult)result {
    [RCCommonFunctionality setFirebaseAppInstanceID:firebaseAppInstanceId];
    result(nil);
}

- (void)setTenjinAnalyticsInstallationID:(nullable NSString *)tenjinAnalyticsInstallationID
                                  result:(FlutterResult)result {
    [RCCommonFunctionality setTenjinAnalyticsInstallationID:tenjinAnalyticsInstallationID];
    result(nil);
}

- (void)setOnesignalID:(nullable NSString *)onesignalID result:(FlutterResult)result {
    [RCCommonFunctionality setOnesignalID:onesignalID];
    result(nil);
}

- (void)setAirshipChannelID:(nullable NSString *)airshipChannelID result:(FlutterResult)result {
    [RCCommonFunctionality setAirshipChannelID:airshipChannelID];
    result(nil);
}

- (void)setMediaSource:(nullable NSString *)mediaSource result:(FlutterResult)result {
    [RCCommonFunctionality setMediaSource:mediaSource];
    result(nil);
}

- (void)setCampaign:(nullable NSString *)campaign result:(FlutterResult)result {
    [RCCommonFunctionality setCampaign:campaign];
    result(nil);
}

- (void)setAdGroup:(nullable NSString *)adGroup result:(FlutterResult)result {
    [RCCommonFunctionality setAdGroup:adGroup];
    result(nil);
}

- (void)setAd:(nullable NSString *)ad result:(FlutterResult)result {
    [RCCommonFunctionality setAd:ad];
    result(nil);
}

- (void)setKeyword:(nullable NSString *)keyword result:(FlutterResult)result {
    [RCCommonFunctionality setKeyword:keyword];
    result(nil);
}

- (void)setCreative:(nullable NSString *)creative result:(FlutterResult)result {
    [RCCommonFunctionality setCreative:creative];
    result(nil);
}

- (void)collectDeviceIdentifiersWithResult:(FlutterResult)result {
    [RCCommonFunctionality collectDeviceIdentifiers];
    result(nil);
}

- (void)canMakePaymentsWithFeatures:(NSArray <NSNumber *>*)features result:(FlutterResult)result {
    result(@([RCCommonFunctionality canMakePaymentsWithFeatures:features]));
}

- (void)promotionalOfferForProductIdentifier:(NSString *)productIdentifier
                          discountIdentifier:(nullable NSString *)discountIdentifier
                                      result:(FlutterResult)result {
    [RCCommonFunctionality promotionalOfferForProductIdentifier:productIdentifier
                                                       discount:discountIdentifier
                                                completionBlock:^(NSDictionary *_Nullable responseDictionary,
                                                        RCErrorContainer *_Nullable error) {
                                                    if (error) {
                                                        [self rejectWithResult:result error:error];
                                                    } else {
                                                        result(responseDictionary);
                                                    }
                                                }];
}

- (void)eligibleWinBackOffersForProduct:(NSString *)productIdentifier result:(FlutterResult)result {
    if (@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)) {
        [RCCommonFunctionality eligibleWinBackOffersForProductIdentifier:productIdentifier
                                                         completionBlock:^(NSArray<NSDictionary *> * _Nullable offers, RCErrorContainer * _Nullable errorContainer) {
            if (errorContainer) {
                [self rejectWithResult:result error:errorContainer];
            } else {
                result(offers);
            }
        }];
    } else {
        NSLog(@"[Purchases] Warning: Win-back offers are only available on iOS 18.0 or greater.");
        NSError *error = [self createUnsupportedErrorWithDescription:@"iOS win-back offers are only available on iOS 18.0 or greater."];
        RCErrorContainer *errorContainer = [[RCErrorContainer alloc] initWithError:error
                                                                    extraPayload:@{}];
        [self rejectWithResult:result error:errorContainer];
    }
}

- (void)purchaseProductWithWinBackOffer:(NSString *)productIdentifier
                 winBackOfferIdentifier:(NSString *)winBackOfferIdentifier
                                 result:(FlutterResult)result {
    if (@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)) {
        [RCCommonFunctionality purchaseProduct:productIdentifier
                                winBackOfferID:winBackOfferIdentifier
                               completionBlock:[self getResponseCompletionBlock:result]];
    } else {
        NSLog(@"[Purchases] Warning: Win-back offers are only available on iOS 18.0 or greater.");
        NSError *error = [self createUnsupportedErrorWithDescription:@"iOS win-back offers are only available on iOS 18.0 or greater."];
        RCErrorContainer *errorContainer = [[RCErrorContainer alloc] initWithError:error
                                                                    extraPayload:@{}];
        [self rejectWithResult:result error:errorContainer];
    }
}

- (void)purchasePackageWithWinBackOffer:(NSString *)packageIdentifier
               presentedOfferingContext:(NSDictionary *)presentedOfferingContext
                 winBackOfferIdentifier:(NSString *)winBackOfferIdentifier
                                 result:(FlutterResult)result {
    if (@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)) {
        [RCCommonFunctionality purchasePackage:packageIdentifier
                      presentedOfferingContext:presentedOfferingContext
                                winBackOfferID:winBackOfferIdentifier
                               completionBlock:[self getResponseCompletionBlock:result]];
    } else {
        NSLog(@"[Purchases] Warning: Win-back offers are only available on iOS 18.0 or greater.");
        NSError *error = [self createUnsupportedErrorWithDescription:@"iOS win-back offers are only available on iOS 18.0 or greater."];
        RCErrorContainer *errorContainer = [[RCErrorContainer alloc] initWithError:error
                                                                      extraPayload:@{}];
        [self rejectWithResult:result error:errorContainer];
    }
}

 #if TARGET_OS_IPHONE
- (void)beginRefundRequestForActiveEntitlementWithResult:(FlutterResult)result {
    if (@available(iOS 15, *)) {
        [RCCommonFunctionality beginRefundRequestForActiveEntitlementCompletion:[self getBeginRefundResponseCompletionBlock:result]];
    } else {
        result(nil);
    }
}

- (void)beginRefundRequestForProduct:(NSString *)productIdentifier result:(FlutterResult)result {
    if (@available(iOS 15, *)) {
        [RCCommonFunctionality beginRefundRequestProductId:productIdentifier
                                           completionBlock:[self getBeginRefundResponseCompletionBlock:result]];
    } else {
        result(nil);
    }
}

- (void)beginRefundRequestForEntitlement:(NSString *)entitlementIdentifier result:(FlutterResult)result {
    if (@available(iOS 15, *)) {
        [RCCommonFunctionality beginRefundRequestEntitlementId:entitlementIdentifier
                                               completionBlock:[self getBeginRefundResponseCompletionBlock:result]];
    } else {
        result(nil);
    }
}
#endif

- (void)startPromotedProductPurchase:(NSNumber *)callbackID
                              result:(FlutterResult)result {
    RCStartPurchaseBlock makePurchaseBlock = [self.startPurchaseBlocks objectAtIndex:[callbackID integerValue]];
    [RCCommonFunctionality makeDeferredPurchase:makePurchaseBlock
                                completionBlock:[self getResponseCompletionBlock:result]];
}

- (void)showInAppMessages:(NSArray<NSNumber*>*)rawValues result:(FlutterResult)result {
    #if TARGET_OS_IPHONE
    if (@available(iOS 16.0, *)) {
        if (rawValues == nil) {
            [RCCommonFunctionality showStoreMessagesCompletion:^{
                result(nil);
            }];
        } else {
            NSSet *types = [[NSSet alloc] initWithArray:rawValues];
            [RCCommonFunctionality showStoreMessagesForTypes:types completion:^{
                result(nil);
            }];
        }
    } else {
        NSLog(@"[Purchases] Warning: tried to show in-app messages, but it's only available on iOS 16.0 or greater.");
        result(nil);
    }
    #else
    NSLog(@"[Purchases] Warning: tried to show in-app messages, but it's only supported on iOS.");
    result(nil);
    #endif

}

- (void)closeWithResult:(FlutterResult)result {
    result(nil);
}

- (void)setLogHandlerWithResult:(FlutterResult)result {
    [RCCommonFunctionality setLogHanderOnLogReceived:^(NSDictionary<NSString *,NSString *> * _Nonnull logDetails) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.channel invokeMethod:PurchasesLogHandlerEvent
                             arguments:logDetails];
        });
    }];
    result(nil);
}

#pragma mark -
#pragma mark Delegate Methods

- (void)purchases:(RCPurchases *)purchases receivedUpdatedCustomerInfo:(RCCustomerInfo *)customerInfo {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.channel invokeMethod:PurchasesCustomerInfoUpdatedEvent
                         arguments:[RCCommonFunctionality encodeCustomerInfo:customerInfo]];
    });
}

- (void)      purchases:(RCPurchases *)purchases
readyForPromotedProduct:(RCStoreProduct *)product
               purchase:(RCStartPurchaseBlock)startPurchase {
    if (!self.startPurchaseBlocks) {
        self.startPurchaseBlocks = [NSMutableArray array];
    }

    [self.startPurchaseBlocks addObject:startPurchase];
    NSInteger position = [self.startPurchaseBlocks count] - 1;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.channel invokeMethod:PurchasesReadyForPromotedProductPurchaseEvent
                         arguments:@{@"callbackID": @(position),
                                     @"productID": product.productIdentifier
                                   }];
    });
}

#pragma mark -
#pragma mark Helper Methods

- (void)rejectWithResult:(FlutterResult)result error:(RCErrorContainer *)errorContainer {
    result([FlutterError errorWithCode:[NSString stringWithFormat:@"%ld", (long) errorContainer.code]
                               message:errorContainer.message
                               details:errorContainer.info]);
}

- (void (^)(NSDictionary *, RCErrorContainer *))getResponseCompletionBlock:(FlutterResult)result {
    return ^(NSDictionary * _Nullable resultDictionary, RCErrorContainer * _Nullable error) {
        if (error) {
            [self rejectWithResult:result error:error];
        } else {
            result(resultDictionary);
        }
    };
}

- (void (^)(RCErrorContainer *))getBeginRefundResponseCompletionBlock:(FlutterResult)result {
    return ^(RCErrorContainer * _Nullable error) {
        if (error == nil) {
            result(@0);
        } else if ([error.info[@"userCancelled"] isEqual: @YES]) {
            result(@1);
        } else {
            [self rejectWithResult:result error:error];
        }
    };
}

- (NSString *)platformFlavor {
    return @"flutter";
}

- (NSString *)platformFlavorVersion {
    return @"8.11.0";
}

- (NSError *)createUnsupportedErrorWithDescription:(NSString *)description {
    return [[NSError alloc] initWithDomain:RCPurchasesErrorCodeDomain
                                      code:RCUnsupportedError
                                  userInfo:@{NSLocalizedDescriptionKey : description}];
}

@end
