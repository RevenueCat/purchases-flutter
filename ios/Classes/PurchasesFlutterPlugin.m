#import "PurchasesFlutterPlugin.h"

@import StoreKit;

#import <PurchasesHybridCommon/PurchasesHybridCommon.h>

@interface PurchasesFlutterPlugin () <RCPurchasesDelegate>

@property(nonatomic, retain) FlutterMethodChannel *channel;
@property(nonatomic, retain) NSObject <FlutterPluginRegistrar> *registrar;

@end

NSString *RNPurchasesPurchaserInfoUpdatedEvent = @"Purchases-PurchaserInfoUpdated";

@implementation PurchasesFlutterPlugin

- (instancetype)initWithChannel:(FlutterMethodChannel *)channel
                      registrar:(NSObject <FlutterPluginRegistrar> *)registrar
{
    self = [super init];
    NSAssert(self, @"super init cannot be nil");
    self.channel = channel;
    self.registrar = registrar;
    return self;
}

+ (void)registerWithRegistrar:(NSObject <FlutterPluginRegistrar> *)registrar
{
    FlutterMethodChannel *channel = [FlutterMethodChannel
            methodChannelWithName:@"purchases_flutter"
                  binaryMessenger:[registrar messenger]];
    PurchasesFlutterPlugin *instance = [[PurchasesFlutterPlugin alloc] initWithChannel:channel registrar:registrar];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result
{
    NSDictionary *arguments = call.arguments;
    if ([@"setupPurchases" isEqualToString:call.method]) {
        NSString *apiKey = arguments[@"apiKey"];
        NSString *appUserID = arguments[@"appUserId"];
        BOOL observerMode = [arguments[@"observerMode"] boolValue];
        NSString * _Nullable userDefaultsSuiteName = arguments[@"userDefaultsSuiteName"];
        [self setupPurchases:apiKey appUserID:appUserID observerMode:observerMode userDefaultsSuiteName:userDefaultsSuiteName result:result];
    } else if ([@"setAllowSharingStoreAccount" isEqualToString:call.method]) {
        [self setAllowSharingStoreAccount:[arguments[@"allowSharing"] boolValue] result:result];
    } else if ([@"setFinishTransactions" isEqualToString:call.method]) {
              [self setFinishTransactions:[arguments[@"finishTransactions"] boolValue] result:result];
    } else if ([@"addAttributionData" isEqualToString:call.method]) {
        NSDictionary *data = arguments[@"data"];
        NSInteger network = [arguments[@"network"] integerValue];
        NSString *networkUserId = arguments[@"networkUserId"];
        [self addAttributionData:data fromNetwork:(RCAttributionNetwork) network forNetworkUserId:networkUserId result:result];
    } else if ([@"getOfferings" isEqualToString:call.method]) {
        [self getOfferingsWithResult:result];
    } else if ([@"getProductInfo" isEqualToString:call.method]) {
        [self getProductInfo:arguments[@"productIdentifiers"] result:result];
    } else if ([@"purchaseProduct" isEqualToString:call.method]) {
        [self purchaseProduct:arguments[@"productIdentifier"] result:result];
    } else if ([@"purchasePackage" isEqualToString:call.method]) {
        [self purchasePackage:arguments[@"packageIdentifier"] offering:arguments[@"offeringIdentifier"] result:result];
    } else if ([@"getAppUserID" isEqualToString:call.method]) {
        [self getAppUserIDWithResult:result];
    } else if ([@"restoreTransactions" isEqualToString:call.method]) {
        [self restoreTransactionsWithResult:result];
    } else if ([@"reset" isEqualToString:call.method]) {
        [self resetWithResult:result];
    } else if ([@"identify" isEqualToString:call.method]) {
        [self identify:arguments[@"appUserID"] result:result];
    } else if ([@"createAlias" isEqualToString:call.method]) {
        [self createAlias:arguments[@"newAppUserID"] result:result];
    } else if ([@"setDebugLogsEnabled" isEqualToString:call.method]) {
        [self setDebugLogsEnabled:[arguments[@"enabled"] boolValue] result:result];
    } else if ([@"setProxyURLString" isEqualToString:call.method]) {
        [self setProxyURLString:arguments[@"proxyURLString"] result:result];
    } else if ([@"getPurchaserInfo" isEqualToString:call.method]) {
        [self getPurchaserInfoWithResult:result];
    } else if ([@"syncPurchases" isEqualToString:call.method]) {
        // NOOP
    } else if ([@"setAutomaticAppleSearchAdsAttributionCollection" isEqualToString:call.method]) {
        [self setAutomaticAppleSearchAdsAttributionCollection:[arguments[@"enabled"] boolValue] result:result];
    } else if ([@"isAnonymous" isEqualToString:call.method]) {
        [self isAnonymousWithResult:result];
    } else if ([@"checkTrialOrIntroductoryPriceEligibility" isEqualToString:call.method]) {
        [self checkTrialOrIntroductoryPriceEligibility:arguments[@"productIdentifiers"] result:result];
    } else if ([@"invalidatePurchaserInfoCache" isEqualToString:call.method]) {
        [self invalidatePurchaserInfoCacheWithResult:result];
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
    } else {
        result(FlutterMethodNotImplemented);
    }
}

- (void)setupPurchases:(NSString *)apiKey
             appUserID:(NSString *)appUserID
          observerMode:(BOOL)observerMode
 userDefaultsSuiteName:(nullable NSString *)userDefaultsSuiteName
                result:(FlutterResult)result
{
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
    result(nil);
}

- (void)setAllowSharingStoreAccount:(BOOL)allowSharingStoreAccount
                             result:(FlutterResult)result
{
    [RCCommonFunctionality setAllowSharingStoreAccount:allowSharingStoreAccount];
    result(nil);
}

- (void)setFinishTransactions:(BOOL)finishTransactions
                       result:(FlutterResult)result
{
    [RCCommonFunctionality setFinishTransactions:finishTransactions];
    result(nil);
}

- (void)addAttributionData:(NSDictionary *)data
               fromNetwork:(NSInteger)network
          forNetworkUserId:(NSString *_Nullable)networkUserId
                    result:(FlutterResult)result
{
    [RCCommonFunctionality addAttributionData:data network:network networkUserId:networkUserId];
    result(nil);
}

- (void)getOfferingsWithResult:(FlutterResult)result
{
    [RCCommonFunctionality getOfferingsWithCompletionBlock:[self getResponseCompletionBlock:result]];
}

- (void)getProductInfo:(NSArray *)products
                result:(FlutterResult)result
{
    [RCCommonFunctionality getProductInfo:products completionBlock:^(NSArray<NSDictionary *> *productObjects) {
        result(productObjects);
    }];
}

- (void)purchaseProduct:(NSString *)productIdentifier
                 result:(FlutterResult)result
{
    [RCCommonFunctionality purchaseProduct:productIdentifier
                   signedDiscountTimestamp:nil
                           completionBlock:[self getResponseCompletionBlock:result]];
}

- (void)purchasePackage:(NSString *)packageIdentifier
               offering:(NSString *)offeringIdentifier
                 result:(FlutterResult)result
{
    [RCCommonFunctionality purchasePackage:packageIdentifier
                                  offering:offeringIdentifier
                   signedDiscountTimestamp:nil
                           completionBlock:[self getResponseCompletionBlock:result]];
}

- (void)restoreTransactionsWithResult:(FlutterResult)result
{
    [RCCommonFunctionality restoreTransactionsWithCompletionBlock:[self getResponseCompletionBlock:result]];
}

- (void)getAppUserIDWithResult:(FlutterResult)result
{
    result([RCCommonFunctionality appUserID]);
}

- (void)createAlias:(NSString *_Nullable)newAppUserID
             result:(FlutterResult)result
{
    [RCCommonFunctionality createAlias:newAppUserID completionBlock:[self getResponseCompletionBlock:result]];
}

- (void)identify:(NSString *_Nullable)appUserID
          result:(FlutterResult)result
{
    [RCCommonFunctionality identify:appUserID completionBlock:[self getResponseCompletionBlock:result]];
}

- (void)resetWithResult:(FlutterResult)result
{
    [RCCommonFunctionality resetWithCompletionBlock:[self getResponseCompletionBlock:result]];
}

- (void)setDebugLogsEnabled:(BOOL)enabled
                     result:(FlutterResult)result
{
    [RCCommonFunctionality setDebugLogsEnabled:enabled];
    result(nil);
}

- (void)setProxyURLString:(nullable NSString *)proxyURLString
                   result:(FlutterResult)result
{
    [RCCommonFunctionality setProxyURLString:proxyURLString];
    result(nil);
}

- (void)getPurchaserInfoWithResult:(FlutterResult)result
{
    [RCCommonFunctionality getPurchaserInfoWithCompletionBlock:[self getResponseCompletionBlock:result]];
}

- (void)setAutomaticAppleSearchAdsAttributionCollection:(BOOL)enabled
                                                 result:(FlutterResult)result
{
    [RCCommonFunctionality setAutomaticAppleSearchAdsAttributionCollection:enabled];
    result(nil);
}

- (void)isAnonymousWithResult:(FlutterResult)result
{
    result(@([RCCommonFunctionality isAnonymous]));
}

- (void)checkTrialOrIntroductoryPriceEligibility:(NSArray *)products
                                          result:(FlutterResult)result
{
    [RCCommonFunctionality checkTrialOrIntroductoryPriceEligibility:products completionBlock:^(NSDictionary<NSString *,NSDictionary *> * _Nonnull responseDictionary) {
        result([NSDictionary dictionaryWithDictionary:responseDictionary]);
    }];
}

- (void)invalidatePurchaserInfoCacheWithResult:(FlutterResult)result
{
    [RCCommonFunctionality invalidatePurchaserInfoCache];
    result(nil);
}

#pragma mark Subscriber Attributes

- (void)setAttributes:(NSDictionary *)attributes result:(FlutterResult)result
{
    [RCCommonFunctionality setAttributes:attributes];
    result(nil);
}

- (void)setEmail:(NSString *)email result:(FlutterResult)result
{
    [RCCommonFunctionality setEmail:email];
    result(nil);
}

- (void)setPhoneNumber:(NSString *)phoneNumber result:(FlutterResult)result
{
    [RCCommonFunctionality setPhoneNumber:phoneNumber];
    result(nil);
}

- (void)setDisplayName:(NSString *)displayName result:(FlutterResult)result
{
    [RCCommonFunctionality setDisplayName:displayName];
    result(nil);
}

- (void)setPushToken:(NSString *)pushToken result:(FlutterResult)result
{
    [RCCommonFunctionality setPushToken:pushToken];
    result(nil);
}

#pragma mark -
#pragma mark Delegate Methods

- (void)purchases:(RCPurchases *)purchases didReceiveUpdatedPurchaserInfo:(RCPurchaserInfo *)purchaserInfo
{
    [self.channel invokeMethod:RNPurchasesPurchaserInfoUpdatedEvent
                     arguments:purchaserInfo.dictionary];
}

#pragma mark -
#pragma mark Helper Methods

- (void)rejectWithResult:(FlutterResult)result error:(RCErrorContainer *)errorContainer
{
    result([FlutterError errorWithCode:[NSString stringWithFormat:@"%ld", (long) errorContainer.code]
                               message:errorContainer.message
                               details:errorContainer.info]);
}

- (void (^)(NSDictionary *, RCErrorContainer *))getResponseCompletionBlock:(FlutterResult)result
{
    return ^(NSDictionary *_Nullable purchaserInfoDictionary, RCErrorContainer *_Nullable error) {
        if (error) {
            [self rejectWithResult:result error:error];
        } else {
            result(purchaserInfoDictionary);
        }
    };
}

- (NSString *)platformFlavor { 
    return @"flutter";
}

- (NSString *)platformFlavorVersion { 
    return @"1.2.0-SNAPSHOT";
}

@end
