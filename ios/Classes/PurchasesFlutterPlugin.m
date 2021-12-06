#import "PurchasesFlutterPlugin.h"

@import StoreKit;

#import <PurchasesHybridCommon/PurchasesHybridCommon.h>


@interface PurchasesFlutterPlugin () <RCPurchasesDelegate>

@property (nonatomic, retain) FlutterMethodChannel *channel;
@property (nonatomic, retain) NSObject <FlutterPluginRegistrar> *registrar;

@end


NSString *RNPurchasesPurchaserInfoUpdatedEvent = @"Purchases-PurchaserInfoUpdated";


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
        BOOL observerMode = [arguments[@"observerMode"] boolValue];
        NSString * _Nullable userDefaultsSuiteName = arguments[@"userDefaultsSuiteName"];
        [self setupPurchases:apiKey
                   appUserID:appUserID
                observerMode:observerMode
       userDefaultsSuiteName:userDefaultsSuiteName
                      result:result];
    } else if ([@"setAllowSharingStoreAccount" isEqualToString:call.method]) {
        [self setAllowSharingStoreAccount:[arguments[@"allowSharing"] boolValue] result:result];
    } else if ([@"setFinishTransactions" isEqualToString:call.method]) {
        [self setFinishTransactions:[arguments[@"finishTransactions"] boolValue] result:result];
    } else if ([@"addAttributionData" isEqualToString:call.method]) {
        NSDictionary *data = arguments[@"data"];
        NSInteger network = [arguments[@"network"] integerValue];
        NSString *networkUserId = arguments[@"networkUserId"];
        [self addAttributionData:data
                     fromNetwork:(RCAttributionNetwork) network
                forNetworkUserId:networkUserId
                          result:result];
    } else if ([@"getOfferings" isEqualToString:call.method]) {
        [self getOfferingsWithResult:result];
    } else if ([@"getProductInfo" isEqualToString:call.method]) {
        [self getProductInfo:arguments[@"productIdentifiers"] result:result];
    } else if ([@"purchaseProduct" isEqualToString:call.method]) {
        [self purchaseProduct:arguments[@"productIdentifier"]
      signedDiscountTimestamp:arguments[@"signedDiscountTimestamp"]
                       result:result];
    } else if ([@"purchasePackage" isEqualToString:call.method]) {
        [self purchasePackage:arguments[@"packageIdentifier"]
                     offering:arguments[@"offeringIdentifier"]
      signedDiscountTimestamp:arguments[@"signedDiscountTimestamp"]
                       result:result];
    } else if ([@"getAppUserID" isEqualToString:call.method]) {
        [self getAppUserIDWithResult:result];
    } else if ([@"restoreTransactions" isEqualToString:call.method]) {
        [self restoreTransactionsWithResult:result];
    } else if ([@"logOut" isEqualToString:call.method]) {
        [self logOutWithResult:result];
    } else if ([@"reset" isEqualToString:call.method]) {
        [self resetWithResult:result];
    } else if ([@"logIn" isEqualToString:call.method]) {
        [self logInAppUserID:arguments[@"appUserID"] result:result];
    } else if ([@"identify" isEqualToString:call.method]) {
        [self identify:arguments[@"appUserID"] result:result];
    } else if ([@"createAlias" isEqualToString:call.method]) {
        [self createAlias:arguments[@"newAppUserID"] result:result];
    } else if ([@"setDebugLogsEnabled" isEqualToString:call.method]) {
        [self setDebugLogsEnabled:[arguments[@"enabled"] boolValue] result:result];
    } else if ([@"setSimulatesAskToBuyInSandbox" isEqualToString:call.method]) {
        [self setSimulatesAskToBuyInSandbox:[arguments[@"enabled"] boolValue] result:result];
    } else if ([@"setProxyURLString" isEqualToString:call.method]) {
        [self setProxyURLString:arguments[@"proxyURLString"] result:result];
    } else if ([@"getPurchaserInfo" isEqualToString:call.method]) {
        [self getPurchaserInfoWithResult:result];
    } else if ([@"syncPurchases" isEqualToString:call.method]) {
        [self syncPurchasesWithResult:result];
    } else if ([@"setAutomaticAppleSearchAdsAttributionCollection" isEqualToString:call.method]) {
        [self setAutomaticAppleSearchAdsAttributionCollection:[arguments[@"enabled"] boolValue] result:result];
    } else if ([@"isAnonymous" isEqualToString:call.method]) {
        [self isAnonymousWithResult:result];
    } else if ([@"isConfigured" isEqualToString:call.method]) {
        [self isConfiguredWithResult:result];
    } else if ([@"checkTrialOrIntroductoryPriceEligibility" isEqualToString:call.method]) {
        [self checkTrialOrIntroductoryPriceEligibility:arguments[@"productIdentifiers"] result:result];
    } else if ([@"invalidatePurchaserInfoCache" isEqualToString:call.method]) {
        [self invalidatePurchaserInfoCacheWithResult:result];
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
    } else if ([@"setOnesignalID" isEqualToString:call.method]) {
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
    } else if ([@"getPaymentDiscount" isEqualToString:call.method]) {
        NSString *productIdentifier = arguments[@"productIdentifier"];
        NSString *discountIdentifier = arguments[@"discountIdentifier"];
        [self paymentDiscountForProductIdentifier:productIdentifier
                               discountIdentifier:discountIdentifier
                                           result:result];
    } else if ([@"close" isEqualToString:call.method]) {
        [self closeWithResult:result];
    } else {
        result(FlutterMethodNotImplemented);
    }
}

- (void)setupPurchases:(NSString *)apiKey
             appUserID:(NSString *)appUserID
          observerMode:(BOOL)observerMode
 userDefaultsSuiteName:(nullable NSString *)userDefaultsSuiteName
                result:(FlutterResult)result {
    if ([appUserID isKindOfClass:NSNull.class]) {
        appUserID = nil;
    }
    if ([userDefaultsSuiteName isKindOfClass:NSNull.class]) {
        userDefaultsSuiteName = nil;
    }
    [RCPurchases configureWithAPIKey:apiKey
                           appUserID:appUserID
                        observerMode:observerMode
               userDefaultsSuiteName:userDefaultsSuiteName
                      platformFlavor:self.platformFlavor
               platformFlavorVersion:self.platformFlavorVersion];
    RCPurchases.sharedPurchases.delegate = self;
    [RCCommonFunctionality configure];
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

- (void)setFinishTransactions:(BOOL)finishTransactions
                       result:(FlutterResult)result {
    [RCCommonFunctionality setFinishTransactions:finishTransactions];
    result(nil);
}

- (void)addAttributionData:(NSDictionary *)data
               fromNetwork:(NSInteger)network
          forNetworkUserId:(NSString * _Nullable)networkUserId
                    result:(FlutterResult)result {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
    [RCCommonFunctionality addAttributionData:data network:network networkUserId:networkUserId];
    result(nil);
#pragma GCC diagnostic pop
}

- (void)getOfferingsWithResult:(FlutterResult)result {
    [RCCommonFunctionality getOfferingsWithCompletionBlock:[self getResponseCompletionBlock:result]];
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
               offering:(NSString *)offeringIdentifier
signedDiscountTimestamp:(nullable NSString *)discountTimestamp
                 result:(FlutterResult)result {
    [RCCommonFunctionality purchasePackage:packageIdentifier
                                  offering:offeringIdentifier
                   signedDiscountTimestamp:discountTimestamp
                           completionBlock:[self getResponseCompletionBlock:result]];
}

- (void)restoreTransactionsWithResult:(FlutterResult)result {
    [RCCommonFunctionality restoreTransactionsWithCompletionBlock:[self getResponseCompletionBlock:result]];
}

- (void)syncPurchasesWithResult:(FlutterResult)result {
    [RCCommonFunctionality syncPurchasesWithCompletionBlock:[self getResponseCompletionBlock:result]];
}

- (void)getAppUserIDWithResult:(FlutterResult)result {
    result([RCCommonFunctionality appUserID]);
}

- (void)createAlias:(NSString * _Nullable)newAppUserID
             result:(FlutterResult)result {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
    [RCCommonFunctionality createAlias:newAppUserID completionBlock:[self getResponseCompletionBlock:result]];
#pragma GCC diagnostic pop
}

- (void)logInAppUserID:(NSString * _Nullable)appUserID
                result:(FlutterResult)result {
    [RCCommonFunctionality logInWithAppUserID:appUserID completionBlock:[self getResponseCompletionBlock:result]];
}

- (void)identify:(NSString * _Nullable)appUserID
          result:(FlutterResult)result {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
    [RCCommonFunctionality identify:appUserID completionBlock:[self getResponseCompletionBlock:result]];
#pragma GCC diagnostic pop
}

- (void)resetWithResult:(FlutterResult)result {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
    [RCCommonFunctionality resetWithCompletionBlock:[self getResponseCompletionBlock:result]];
#pragma GCC diagnostic pop
}

- (void)logOutWithResult:(FlutterResult)result {
    [RCCommonFunctionality logOutWithCompletionBlock:[self getResponseCompletionBlock:result]];
}

- (void)setDebugLogsEnabled:(BOOL)enabled
                     result:(FlutterResult)result {
    [RCCommonFunctionality setDebugLogsEnabled:enabled];
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

- (void)getPurchaserInfoWithResult:(FlutterResult)result {
    [RCCommonFunctionality getPurchaserInfoWithCompletionBlock:[self getResponseCompletionBlock:result]];
}

- (void)setAutomaticAppleSearchAdsAttributionCollection:(BOOL)enabled
                                                 result:(FlutterResult)result {
    [RCCommonFunctionality setAutomaticAppleSearchAdsAttributionCollection:enabled];
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

- (void)invalidatePurchaserInfoCacheWithResult:(FlutterResult)result {
    [RCCommonFunctionality invalidatePurchaserInfoCache];
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

- (void)paymentDiscountForProductIdentifier:(NSString *)productIdentifier
                         discountIdentifier:(nullable NSString *)discountIdentifier
                                     result:(FlutterResult)result {
    [RCCommonFunctionality paymentDiscountForProductIdentifier:productIdentifier
                                                      discount:discountIdentifier
                                               completionBlock:^(NSDictionary * _Nullable responseDictionary,
                                                                 RCErrorContainer * _Nullable error) {
                                                   if (error) {
                                                       [self rejectWithResult:result error:error];
                                                   } else {
                                                       result(responseDictionary);
                                                   }
                                               }];
}

- (void)closeWithResult:(FlutterResult)result {
    result(nil);
}

#pragma mark -
#pragma mark Delegate Methods

- (void)purchases:(RCPurchases *)purchases didReceiveUpdatedPurchaserInfo:(RCPurchaserInfo *)purchaserInfo {
    [self.channel invokeMethod:RNPurchasesPurchaserInfoUpdatedEvent
                     arguments:purchaserInfo.dictionary];
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

- (NSString *)platformFlavor {
    return @"flutter";
}

- (NSString *)platformFlavorVersion { 
    return @"3.8.0";
}

@end
