//
//  Created by RevenueCat.
//  Copyright © 2019 RevenueCat. All rights reserved.
//
#import "RCCommonFunctionality.h"
#import "SKProduct+HybridAdditions.h"
#import "RCErrorContainer.h"
#import "RCOfferings+HybridAdditions.h"
#import "RCPurchaserInfo+HybridAdditions.h"
#import "SKPaymentDiscount+HybridAdditions.h"
#import "RCPurchases+HybridAdditions.h"


API_AVAILABLE(ios(12.2))
@interface RCCommonFunctionality ()

@property(class, readonly, nonatomic, retain) NSMutableDictionary<NSString *, SKPaymentDiscount *> *discounts;

@end


@implementation RCCommonFunctionality

API_AVAILABLE(ios(12.2))
static NSMutableDictionary<NSString *, SKPaymentDiscount *> *_discounts = nil;


+ (NSMutableDictionary<NSString *, SKPaymentDiscount *> *)discounts API_AVAILABLE(ios(12.2)) {
    return _discounts;
}

+ (void)configure
{
    if (@available(iOS 12.2, *)) {
        _discounts = [NSMutableDictionary new];
    }
}

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

+ (void)purchaseProduct:(NSString *)productIdentifier
signedDiscountTimestamp:(nullable NSString *)discountTimestamp
        completionBlock:(RCHybridResponseBlock)completion
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
    
    
    [self productWithIdentifier:productIdentifier completionBlock:^(SKProduct *_Nullable aProduct) {
        if (aProduct == nil) {
            [self productNotFoundErrorWithDescription:@"Couldn't find product." userCancelled:[NSNumber numberWithBool:NO] completion:completion];
            return;
        }
        
        if (@available(iOS 12.2, *)) {
            if (discountTimestamp) {
                SKPaymentDiscount *discount = self.discounts[discountTimestamp];
                if (discount == nil) {
                    [self productNotFoundErrorWithDescription:@"Couldn't find discount." userCancelled:[NSNumber numberWithBool:NO] completion:completion];
                    return;
                }
                
                [RCPurchases.sharedPurchases purchaseProduct:aProduct withDiscount:discount completionBlock:completionBlock];
                return;
            }
        }
        
        [RCPurchases.sharedPurchases purchaseProduct:aProduct withCompletionBlock:completionBlock];
    }];
}

+ (void)purchasePackage:(NSString *)packageIdentifier
               offering:(NSString *)offeringIdentifier
signedDiscountTimestamp:(nullable NSString *)discountTimestamp
        completionBlock:(RCHybridResponseBlock)completion
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
    
    [self packageWithIdentifier:packageIdentifier offeringIdentifier:offeringIdentifier completionBlock:^(RCPackage *_Nullable aPackage) {
        if (aPackage == nil) {
            [self productNotFoundErrorWithDescription:@"Couldn't find package." userCancelled:[NSNumber numberWithBool:NO] completion:completion];
            return;
        }
        
        if (@available(iOS 12.2, *)) {
           if (discountTimestamp) {
               SKPaymentDiscount *discount = self.discounts[discountTimestamp];
               if (discount == nil) {
                   [self productNotFoundErrorWithDescription:@"Couldn't find discount." userCancelled:[NSNumber numberWithBool:NO] completion:completion];
                   return;
               }
               
               [RCPurchases.sharedPurchases purchasePackage:aPackage withDiscount:discount completionBlock:completionBlock];
               return;
           }
        }
        
        [RCPurchases.sharedPurchases purchasePackage:aPackage withCompletionBlock:completionBlock];
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
                                 completionBlock:(RCReceiveIntroEligibilityBlock)completion
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

+ (void)paymentDiscountForProductIdentifier:(NSString *)productIdentifier
                                   discount:(nullable NSString *)discountIdentifier
                            completionBlock:(RCHybridResponseBlock)completion
{
    if (@available(iOS 12.2, *)) {
        NSAssert(RCPurchases.sharedPurchases, @"You must call setup first.");
        [self productWithIdentifier:productIdentifier completionBlock:^(SKProduct *_Nullable aProduct) {
            if (aProduct) {
                SKProductDiscount *discountToUse = [self discountWithIdentifier:discountIdentifier forProduct:aProduct];

                if (discountToUse) {
                    [RCPurchases.sharedPurchases paymentDiscountForProductDiscount:discountToUse product:aProduct completion:^(SKPaymentDiscount *paymentDiscount, NSError *error) {
                        if (paymentDiscount) {
                            self.discounts[[paymentDiscount.timestamp stringValue]] = paymentDiscount;
                            completion(paymentDiscount.dictionary, nil);
                        } else {
                            completion(nil, [self payloadForError:error  withExtraPayload:@{}]);
                        }
                    }];
                } else {
                    [self productNotFoundErrorWithDescription:@"Couldn't find discount." userCancelled:nil completion:completion];
                }
            } else {
                [self productNotFoundErrorWithDescription:@"Couldn't find product." userCancelled:nil completion:completion];
            }

        }];
    } else {
        completion(nil, nil);
    }
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

+ (void)invalidatePurchaserInfoCache { 
    NSAssert(RCPurchases.sharedPurchases, @"You must call setup first.");
    [RCPurchases.sharedPurchases invalidatePurchaserInfoCache];
}

#pragma mark Subcriber Attributes

+ (void)setAttributes:(NSDictionary<NSString *, NSString *> *)attributes {
    NSAssert(RCPurchases.sharedPurchases, @"You must call setup first.");
    NSMutableDictionary *nonNilAttributes = [[NSMutableDictionary alloc] init];
    for (NSString * key in attributes.allKeys) {
        id object = attributes[key];
        NSString *nonNilAttribute = ([object isEqual:NSNull.null])
                                     ? @""
                                     : object;
        nonNilAttributes[key] = nonNilAttribute;
    }
    [RCPurchases.sharedPurchases setAttributes:nonNilAttributes];
}

+ (void)setEmail:(nullable NSString *)email {
    NSAssert(RCPurchases.sharedPurchases, @"You must call setup first.");
    NSString *nonNSNullAttribute = [self nonNSNullAttribute:email];
    [RCPurchases.sharedPurchases setEmail:nonNSNullAttribute];
}

+ (void)setPhoneNumber:(nullable NSString *)phoneNumber {
    NSAssert(RCPurchases.sharedPurchases, @"You must call setup first.");
    NSString *nonNSNullAttribute = [self nonNSNullAttribute:phoneNumber];
    [RCPurchases.sharedPurchases setPhoneNumber:nonNSNullAttribute];
}

+ (void)setDisplayName:(nullable NSString *)displayName {
    NSAssert(RCPurchases.sharedPurchases, @"You must call setup first.");
    NSString *nonNSNullAttribute = [self nonNSNullAttribute:displayName];
    [RCPurchases.sharedPurchases setDisplayName:nonNSNullAttribute];
}

+ (void)setPushToken:(nullable NSString *)pushToken {
    NSAssert(RCPurchases.sharedPurchases, @"You must call setup first.");
    NSString *nonNSNullAttribute = [self nonNSNullAttribute:pushToken];
    [RCPurchases.sharedPurchases _setPushTokenString:nonNSNullAttribute];
}

+ (NSString * _Nullable)nonNSNullAttribute:(NSString * _Nullable)attribute {
    return ([attribute isEqual:NSNull.null]) ? @"" : attribute;
}

#pragma errors

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

+ (void)productNotFoundErrorWithDescription:(NSString *)errorDescription
                              userCancelled:(nullable NSNumber *)userCancelled
                                 completion:(RCHybridResponseBlock)completion
{
    NSDictionary *extraPayload;
    if (userCancelled == nil) {
        extraPayload = @{};
    } else {
        extraPayload = @{@"userCancelled": @([userCancelled boolValue])};
    }
    
    NSError *error = [NSError errorWithDomain:RCPurchasesErrorDomain
                                         code:RCProductNotAvailableForPurchaseError
                                     userInfo:@{
                                         NSLocalizedDescriptionKey: errorDescription
                                     }];
    completion(nil, [self payloadForError:error withExtraPayload:extraPayload]);
}

#pragma helpers

+ (void)productWithIdentifier:(NSString *)productIdentifier
              completionBlock:(void (^)(SKProduct *_Nullable))completion
{
    [RCPurchases.sharedPurchases productsWithIdentifiers:@[productIdentifier]
                                         completionBlock:^(NSArray<SKProduct *> *_Nonnull products) {
                                             SKProduct *aProduct = nil;
                                             for (SKProduct *p in products) {
                                                 if ([productIdentifier isEqualToString:p.productIdentifier]) {
                                                     aProduct = p;
                                                 }
                                             }
                                             completion(aProduct);
                                         }];
}

+ (void)packageWithIdentifier:(NSString *)packageIdentifier
           offeringIdentifier:(NSString *)offeringIdentifier
              completionBlock:(void (^)(RCPackage *_Nullable))completion
{
    [RCPurchases.sharedPurchases offeringsWithCompletionBlock:^(RCOfferings *offerings, NSError *error) {
        completion([[offerings offeringWithIdentifier:offeringIdentifier] packageWithIdentifier:packageIdentifier]);
    }];
}

+ (nullable SKProductDiscount *)discountWithIdentifier:(NSString *)identifier
                                            forProduct:(SKProduct *)aProduct API_AVAILABLE(ios(12.2)) {
    SKProductDiscount *discountToUse = nil;
    NSArray<SKProductDiscount *> *productDiscounts = aProduct.discounts;
    if (identifier == nil && productDiscounts != nil && productDiscounts.count > 0) {
        discountToUse = productDiscounts.firstObject;
    } else {
        for (SKProductDiscount *discount in productDiscounts) {
            if (identifier == discount.identifier) {
                discountToUse = discount;
            }
        }
    }
    return discountToUse;
}

@end
