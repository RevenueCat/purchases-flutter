//
//  Created by RevenueCat.
//  Copyright © 2019 RevenueCat. All rights reserved.
//
#import "RCCommonFunctionality.h"
#import "SKProduct+HybridAdditions.h"
#import "RCErrorContainer.h"
#import "RCOfferings+HybridAdditions.h"
#import "RCPurchaserInfo+HybridAdditions.h"

@implementation RCCommonFunctionality

+ (void)setAllowSharingStoreAccount:(BOOL)allowSharingStoreAccount
{
    NSAssert(RCPurchases.sharedPurchases, @"You must call setup first.");
    RCPurchases.sharedPurchases.allowSharingAppStoreAccount = allowSharingStoreAccount;
}

+ (void)addAttributionData:(NSDictionary *)data network:(NSInteger)network networkUserId:(NSString *)networkUserId
{
    [RCPurchases addAttributionData:data fromNetwork:(RCAttributionNetwork) network forNetworkUserId:networkUserId];
}

+ (void)getProductInfo:(NSArray *)products
       completionBlock:(void (^)(NSArray<NSDictionary *> *))completion
{
    NSAssert(RCPurchases.sharedPurchases, @"You must call setup first.");

    [RCPurchases.sharedPurchases productsWithIdentifiers:products
                                         completionBlock:^(NSArray<SKProduct *> *_Nonnull products) {
                                             NSMutableArray *productObjects = [NSMutableArray new];
                                             for (SKProduct *p in products) {
                                                 [productObjects addObject:p.dictionary];
                                             }
                                             completion(productObjects);
                                         }];
}

+ (void)restoreTransactionsWithCompletionBlock:(RCHybridResponseBlock)completion
{
    NSAssert(RCPurchases.sharedPurchases, @"You must call setup first.");
    [RCPurchases.sharedPurchases restoreTransactionsWithCompletionBlock:[self getPurchaserInfoCompletionBlock:completion]];
}

+ (NSString *)appUserID
{
    NSAssert(RCPurchases.sharedPurchases, @"You must call setup first.");
    return RCPurchases.sharedPurchases.appUserID;
}

+ (void)createAlias:(nullable NSString *)newAppUserID completionBlock:(RCHybridResponseBlock)completion
{
    NSAssert(RCPurchases.sharedPurchases, @"You must call setup first.");
    [RCPurchases.sharedPurchases createAlias:newAppUserID completionBlock:[self getPurchaserInfoCompletionBlock:completion]];
}

+ (void)identify:(NSString *)appUserID completionBlock:(RCHybridResponseBlock)completion
{
    NSAssert(RCPurchases.sharedPurchases, @"You must call setup first.");
    [RCPurchases.sharedPurchases identify:appUserID completionBlock:[self getPurchaserInfoCompletionBlock:completion]];
}

+ (void)resetWithCompletionBlock:(RCHybridResponseBlock)completion
{
    NSAssert(RCPurchases.sharedPurchases, @"You must call setup first.");
    [RCPurchases.sharedPurchases resetWithCompletionBlock:[self getPurchaserInfoCompletionBlock:completion]];
}

+ (void)setDebugLogsEnabled:(BOOL)enabled
{
    RCPurchases.debugLogsEnabled = enabled;
}

+ (void)getPurchaserInfoWithCompletionBlock:(RCHybridResponseBlock)completion
{
    NSAssert(RCPurchases.sharedPurchases, @"You must call setup first.");
    [RCPurchases.sharedPurchases purchaserInfoWithCompletionBlock:[self getPurchaserInfoCompletionBlock:completion]];
}


+ (void)setAutomaticAppleSearchAdsAttributionCollection:(BOOL)enabled
{
    RCPurchases.automaticAppleSearchAdsAttributionCollection = enabled;
}

+ (void)getOfferingsWithCompletionBlock:(RCHybridResponseBlock)completion
{
    NSAssert(RCPurchases.sharedPurchases, @"You must call setup first.");
    [RCPurchases.sharedPurchases offeringsWithCompletionBlock:^(RCOfferings *_Nullable offerings, NSError *_Nullable error) {
        if (error) {
            completion(nil, [self payloadForError:error withExtraPayload:@{}]);
        } else {
            completion(offerings.dictionary, nil);
        }
    }];
}

+ (BOOL)isAnonymous
{
    NSAssert(RCPurchases.sharedPurchases, @"You must call setup first.");
    return [RCPurchases.sharedPurchases isAnonymous];
}

+ (void)purchaseProduct:(NSString *)productIdentifier completionBlock:(RCHybridResponseBlock)completion
{
    NSAssert(RCPurchases.sharedPurchases, @"You must call setup first.");

    void (^completionBlock)(SKPaymentTransaction *_Nullable, RCPurchaserInfo *_Nullable, NSError *_Nullable, BOOL) = ^(SKPaymentTransaction *_Nullable transaction, RCPurchaserInfo *_Nullable purchaserInfo, NSError *_Nullable error, BOOL userCancelled) {
        if (error) {
            completion(nil, [self payloadForError:error withExtraPayload:@{@"userCancelled": @(userCancelled)}]);
        } else {
            completion(@{
                @"purchaserInfo": purchaserInfo.dictionary,
                @"productIdentifier": transaction.payment.productIdentifier
            }, nil);
        }
    };

    [RCPurchases.sharedPurchases productsWithIdentifiers:@[productIdentifier]
                                         completionBlock:^(NSArray<SKProduct *> *_Nonnull products) {
                                             NSMutableDictionary *productsByIdentifiers = [NSMutableDictionary new];
                                             for (SKProduct *p in products) {
                                                 productsByIdentifiers[p.productIdentifier] = p;
                                             }
                                             if (productsByIdentifiers[productIdentifier]) {
                                                 [RCPurchases.sharedPurchases purchaseProduct:productsByIdentifiers[productIdentifier]
                                                                          withCompletionBlock:completionBlock];
                                             } else {
                                                 NSError *error = [NSError errorWithDomain:RCPurchasesErrorDomain
                                                                                      code:RCProductNotAvailableForPurchaseError
                                                                                  userInfo:@{
                                                                                          NSLocalizedDescriptionKey: @"Couldn't find product."
                                                                                  }];
                                                 completion(nil, [self payloadForError:error withExtraPayload:@{@"userCancelled": @(NO)}]);
                                             }
                                         }];
}

+ (void)purchasePackage:(NSString *)packageIdentifier offering:(NSString *)offeringIdentifier completionBlock:(RCHybridResponseBlock)completion
{
    NSAssert(RCPurchases.sharedPurchases, @"You must call setup first.");

    void (^completionBlock)(SKPaymentTransaction *_Nullable, RCPurchaserInfo *_Nullable, NSError *_Nullable, BOOL) = ^(SKPaymentTransaction *_Nullable transaction, RCPurchaserInfo *_Nullable purchaserInfo, NSError *_Nullable error, BOOL userCancelled) {
        if (error) {
            completion(nil, [self payloadForError:error withExtraPayload:@{@"userCancelled": @(userCancelled)}]);
        } else {
            completion(@{
                @"purchaserInfo": purchaserInfo.dictionary,
                @"productIdentifier": transaction.payment.productIdentifier
            }, nil);
        }
    };

    [RCPurchases.sharedPurchases offeringsWithCompletionBlock:^(RCOfferings *offerings, NSError *error) {
        RCPackage *aPackage = [[offerings offeringWithIdentifier:offeringIdentifier] packageWithIdentifier:packageIdentifier];
        if (aPackage) {
            [RCPurchases.sharedPurchases purchasePackage:aPackage withCompletionBlock:completionBlock];
        } else {
            NSError *error = [NSError errorWithDomain:RCPurchasesErrorDomain
                                                 code:RCProductNotAvailableForPurchaseError
                                             userInfo:@{
                                                     NSLocalizedDescriptionKey: @"Couldn't find package."
                                             }];
            completion(nil, [self payloadForError:error withExtraPayload:@{@"userCancelled": @(NO)}]);
        }
    }];
}

+ (void)setFinishTransactions:(BOOL)finishTransactions
{
    NSAssert(RCPurchases.sharedPurchases, @"You must call setup first.");
    RCPurchases.sharedPurchases.finishTransactions = finishTransactions;
}

+ (void)makeDeferredPurchase:(RCDeferredPromotionalPurchaseBlock)deferredPurchase completionBlock:(RCHybridResponseBlock)completion
{
    NSAssert(RCPurchases.sharedPurchases, @"You must call setup first.");

    deferredPurchase(^(SKPaymentTransaction *_Nullable transaction, RCPurchaserInfo *_Nullable purchaserInfo, NSError *_Nullable error, BOOL userCancelled) {
        if (error) {
            completion(nil, [self payloadForError:error withExtraPayload:@{@"userCancelled": @(userCancelled)}]);
        } else {
            completion(@{
                @"purchaserInfo": purchaserInfo.dictionary,
                @"productIdentifier": transaction.payment.productIdentifier
            }, nil);
        }
    });
}

+ (void)checkTrialOrIntroductoryPriceEligibility:(nonnull NSArray<NSString *> *)productIdentifiers
                                 completionBlock:(void (^)(NSDictionary<NSString *, NSDictionary *> *))completion
{
    NSAssert(RCPurchases.sharedPurchases, @"You must call setup first.");
    
    [RCPurchases.sharedPurchases checkTrialOrIntroductoryPriceEligibility:productIdentifiers completionBlock:^(NSDictionary<NSString *,RCIntroEligibility *> * _Nonnull dictionary) {
        NSMutableDictionary *response = [NSMutableDictionary new];
        for (NSString *productID in dictionary) {
            RCIntroEligibility *eligibility = dictionary[productID];
            response[productID] = @{
                @"status": @(eligibility.status),
                @"description": eligibility.description
            };
        }
        completion([NSDictionary dictionaryWithDictionary:response]);
    }];
}

+ (void (^)(RCPurchaserInfo *, NSError *))getPurchaserInfoCompletionBlock:(RCHybridResponseBlock)completion
{
    return ^(RCPurchaserInfo *_Nullable purchaserInfo, NSError *_Nullable error) {
        if (error) {
            completion(nil, [self payloadForError:error withExtraPayload:@{}]);
        } else {
            completion(purchaserInfo.dictionary, nil);
        }
    };
}

+ (RCErrorContainer *)payloadForError:(NSError *)error withExtraPayload:(NSDictionary *)extraPayload
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:extraPayload];
    dict[@"code"] = @(error.code);
    dict[@"message"] = error.localizedDescription;
    if (error.userInfo[NSUnderlyingErrorKey]) {
        dict[@"underlyingErrorMessage"] = ((NSError *) error.userInfo[NSUnderlyingErrorKey]).localizedDescription;
    }

    if (error.userInfo[RCReadableErrorCodeKey]) {
        dict[@"readableErrorCode"] = error.userInfo[RCReadableErrorCodeKey];
        dict[@"readable_error_code"] = error.userInfo[RCReadableErrorCodeKey];
    }

    return [[RCErrorContainer alloc] initWithError:error info:dict];
}

@end
