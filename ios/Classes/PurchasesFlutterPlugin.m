#import "PurchasesFlutterPlugin.h"

@import StoreKit;

#import "RCPurchaserInfo+RNPurchases.h"
#import "RCEntitlement+RNPurchases.h"
#import "SKProduct+RNPurchases.h"

@interface PurchasesFlutterPlugin () <RCPurchasesDelegate>

@property (nonatomic, retain) NSMutableDictionary *products;
@property (nonatomic, retain) FlutterMethodChannel *channel;
@property (nonatomic, retain) NSObject<FlutterPluginRegistrar> *registrar;

@end

NSString *RNPurchasesPurchaserInfoUpdatedEvent = @"Purchases-PurchaserInfoUpdated";

@implementation PurchasesFlutterPlugin

- (instancetype)initWithChannel:(FlutterMethodChannel*)channel
                      registrar:(NSObject<FlutterPluginRegistrar>*)registrar
{
    self = [super init];
    NSAssert(self, @"super init cannot be nil");
    self.channel = channel;
    self.registrar = registrar;
    return self;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"purchases_flutter"
                                     binaryMessenger:[registrar messenger]];
    PurchasesFlutterPlugin* instance = [[PurchasesFlutterPlugin alloc] initWithChannel:channel registrar:registrar];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary* arguments = call.arguments;
    if ([@"setupPurchases" isEqualToString:call.method]) {
        NSString* apiKey = arguments[@"apiKey"];
        NSString* appUserID = arguments[@"appUserId"];
        BOOL observerMode = [arguments[@"observerMode"] boolValue];
        [self setupPurchases:apiKey appUserID:appUserID observerMode:observerMode result:result];
    } else if ([@"setAllowSharingStoreAccount" isEqualToString:call.method]) {
        [self setAllowSharingStoreAccount:[arguments[@"allowSharing"] boolValue] result:result];
    } else if ([@"addAttributionData" isEqualToString:call.method]) {
        NSDictionary *data = arguments[@"data"];
        NSInteger network = [arguments[@"network"] integerValue];
        NSString *networkUserId = arguments[@"networkUserId"];
        [self addAttributionData:data fromNetwork:(RCAttributionNetwork)network forNetworkUserId:networkUserId result:result];
    } else if ([@"getEntitlements" isEqualToString:call.method]) {
        [self getEntitlementsWithResult:result];
    } else if ([@"getProductInfo" isEqualToString:call.method]) {
        [self getProductInfo:arguments[@"productIdentifiers"] result:result];
    } else if ([@"makePurchase" isEqualToString:call.method]) {
        [self makePurchase:arguments[@"productIdentifier"] result:result];
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
    } else if ([@"getPurchaserInfo" isEqualToString:call.method]) {
        [self getPurchaserInfoWithResult:result];
    } else if ([@"syncPurchases" isEqualToString:call.method]) {
        // NOOP
    } else if ([@"setAutomaticAttributionCollection" isEqualToString:call.method]) {
        [self setAutomaticAttributionCollection:[arguments[@"enabled"] boolValue] result:result];
    } else {
        result(FlutterMethodNotImplemented);
    }
}

- (void)setupPurchases:(NSString *)apiKey
             appUserID:(NSString *)appUserID
          observerMode:(BOOL)observerMode
                result:(FlutterResult)result
{
    self.products = [NSMutableDictionary new];
    [RCPurchases configureWithAPIKey:apiKey appUserID:appUserID observerMode:observerMode];
    RCPurchases.sharedPurchases.delegate = self;
    result(nil);
}

- (void)setAllowSharingStoreAccount:(BOOL)allowSharingStoreAccount
                             result:(FlutterResult)result
{
    NSAssert(RCPurchases.sharedPurchases, @"You must call setup first.");
    RCPurchases.sharedPurchases.allowSharingAppStoreAccount = allowSharingStoreAccount;
    result(nil);
}

- (void)addAttributionData:(NSDictionary *)data 
               fromNetwork:(NSInteger)network
          forNetworkUserId:(NSString * _Nullable)networkUserId
                    result:(FlutterResult)result
{
    [RCPurchases addAttributionData:data fromNetwork:(RCAttributionNetwork)network forNetworkUserId:networkUserId];
    result(nil);
}

- (void)getEntitlementsWithResult:(FlutterResult)result
{
    NSAssert(RCPurchases.sharedPurchases, @"You must call setup first.");
    [RCPurchases.sharedPurchases entitlementsWithCompletionBlock:^(RCEntitlements * _Nullable entitlements, NSError * _Nullable error) {
        if (error) {
            [self rejectWithResult:result error:error];
        } else {
            NSMutableDictionary *response = [NSMutableDictionary new];
            for (NSString *entId in entitlements) {
                RCEntitlement *entitlement = entitlements[entId];
                response[entId] = entitlement.dictionary;
            }
            
            for (RCEntitlement *entitlement in entitlements.allValues) {
                for (RCOffering *offering in entitlement.offerings.allValues)
                {
                    SKProduct *product = offering.activeProduct;
                    if (product != nil) {
                        self.products[product.productIdentifier] = product;
                    }
                }
            }
            result([NSDictionary dictionaryWithDictionary:response]);
        }
    }];
}


- (void)getProductInfo:(NSArray *)products
                result:(FlutterResult)result
{
    NSAssert(RCPurchases.sharedPurchases, @"You must call setup first.");
    
    [RCPurchases.sharedPurchases productsWithIdentifiers:products
                                         completionBlock:^(NSArray<SKProduct *> * _Nonnull products) {
                                             NSMutableArray *productObjects = [NSMutableArray new];
                                             for (SKProduct *p in products) {
                                                 self.products[p.productIdentifier] = p;
                                                 [productObjects addObject:p.dictionary];
                                             }
                                             result(productObjects);
                                         }];
}

- (void)makePurchase:(NSString *)productIdentifier
              result:(FlutterResult)result
{
    NSAssert(RCPurchases.sharedPurchases, @"You must call setup first.");
    
    void (^completionBlock)(SKPaymentTransaction * _Nullable, RCPurchaserInfo * _Nullable, NSError * _Nullable, BOOL) = ^(SKPaymentTransaction * _Nullable transaction, RCPurchaserInfo * _Nullable purchaserInfo, NSError * _Nullable error, BOOL userCancelled) {
        if (error) {
            [self rejectWithResult:result error:error withExtraPayload:@{ @"userCancelled": @(userCancelled)}];
        } else {
            result(@{
                     @"productIdentifier":transaction.payment.productIdentifier,
                     @"purchaserInfo": purchaserInfo.dictionary
                     });
        }
    };
    
    if (self.products[productIdentifier] == nil) {
        [RCPurchases.sharedPurchases productsWithIdentifiers:[NSArray arrayWithObjects:productIdentifier, nil]
                                             completionBlock:^(NSArray<SKProduct *> * _Nonnull products) {
                                                 NSMutableArray *productObjects = [NSMutableArray new];
                                                 for (SKProduct *p in products) {
                                                     self.products[p.productIdentifier] = p;
                                                     [productObjects addObject:p.dictionary];
                                                 }
                                                 [RCPurchases.sharedPurchases makePurchase:self.products[productIdentifier]
                                                                       withCompletionBlock:completionBlock];
                                             }];
    } else {
        [RCPurchases.sharedPurchases makePurchase:self.products[productIdentifier]
                              withCompletionBlock:completionBlock];
    }
}

- (void)restoreTransactionsWithResult:(FlutterResult)result {
    NSAssert(RCPurchases.sharedPurchases, @"You must call setup first.");
    [RCPurchases.sharedPurchases restoreTransactionsWithCompletionBlock:^(RCPurchaserInfo * _Nullable purchaserInfo, NSError * _Nullable error) {
        if (error) {
            [self rejectWithResult:result error:error];
        } else {
            result(purchaserInfo.dictionary);
        }
    }];
}

- (void)getAppUserIDWithResult:(FlutterResult)result
{
    NSAssert(RCPurchases.sharedPurchases, @"You must call setup first.");
    result(RCPurchases.sharedPurchases.appUserID);
}

- (void)createAlias:(NSString * _Nullable)newAppUserID
             result:(FlutterResult)result
{
    NSAssert(RCPurchases.sharedPurchases, @"You must call setup first.");
    [RCPurchases.sharedPurchases createAlias:newAppUserID completionBlock:^(RCPurchaserInfo * _Nullable purchaserInfo, NSError * _Nullable error) {
        if (error) {
            [self rejectWithResult:result error:error];
        } else {
            result(purchaserInfo.dictionary);
        }
    }];
}

- (void)identify:(NSString * _Nullable)appUserID
          result:(FlutterResult)result
{
    NSAssert(RCPurchases.sharedPurchases, @"You must call setup first.");
    [RCPurchases.sharedPurchases identify:appUserID completionBlock:^(RCPurchaserInfo * _Nullable purchaserInfo, NSError * _Nullable error) {
        if (error) {
            [self rejectWithResult:result error:error];
        } else {
            result(purchaserInfo.dictionary);
        }
    }];
}

- (void)resetWithResult:(FlutterResult)result
{
    NSAssert(RCPurchases.sharedPurchases, @"You must call setup first.");
    [RCPurchases.sharedPurchases resetWithCompletionBlock:^(RCPurchaserInfo * _Nullable purchaserInfo, NSError * _Nullable error) {
        if (error) {
            [self rejectWithResult:result error:error];
        } else {
            result(purchaserInfo.dictionary);
        }
    }];
}

- (void)setDebugLogsEnabled:(BOOL)enabled
                     result:(FlutterResult)result{
    RCPurchases.debugLogsEnabled = enabled;
    result(nil);
}

- (void)getPurchaserInfoWithResult:(FlutterResult)result
{
    NSAssert(RCPurchases.sharedPurchases, @"You must call setup first.");
    [RCPurchases.sharedPurchases purchaserInfoWithCompletionBlock:^(RCPurchaserInfo * _Nullable purchaserInfo, NSError * _Nullable error) {
        if (error) {
            [self rejectWithResult:result error:error];
        } else {
            result(purchaserInfo.dictionary);
        }
    }];
}

- (void)setAutomaticAttributionCollection:(BOOL)enabled
                                   result:(FlutterResult)result{
    [RCPurchases setAutomaticAttributionCollection:enabled];
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

- (void)rejectWithResult:(FlutterResult)result error:(NSError *)error {
    [self rejectWithResult:result error:error withExtraPayload:@{}];
}

- (void)rejectWithResult:(FlutterResult)result error:(NSError *)error withExtraPayload:(NSDictionary *)extraPayload {
    NSDictionary* payloadForError = [self payloadForError:error withExtraPayload:extraPayload];
    
    result([FlutterError errorWithCode:[NSString stringWithFormat: @"%ld", (long)error.code]
                               message:error.localizedDescription
                               details:payloadForError]);
}

- (NSDictionary *)payloadForError:(NSError *)error withExtraPayload:(NSDictionary *)extraPayload {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:extraPayload];
    
    if (error.userInfo[NSUnderlyingErrorKey]) {
        dict[@"underlyingErrorMessage"] = ((NSError *)error.userInfo[NSUnderlyingErrorKey]).localizedDescription;
    }
    
    if (error.userInfo[RCReadableErrorCodeKey]) {
        dict[@"readable_error_code"] = error.userInfo[RCReadableErrorCodeKey];
    }
    
    return dict;
}

@end
