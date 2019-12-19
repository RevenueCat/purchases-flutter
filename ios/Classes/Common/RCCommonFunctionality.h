//
//  Created by RevenueCat.
//  Copyright © 2019 RevenueCat. All rights reserved.
//

#import <Purchases/Purchases.h>

NS_ASSUME_NONNULL_BEGIN

@class RCErrorContainer;

typedef void (^RCHybridResponseBlock)(NSDictionary * _Nullable, RCErrorContainer * _Nullable);

@interface RCCommonFunctionality : NSObject

+ (void)setAllowSharingStoreAccount:(BOOL)allowSharingStoreAccount;

+ (void)addAttributionData:(NSDictionary *)data network:(NSInteger)network networkUserId:(NSString *)networkUserId;

+ (void)getProductInfo:(NSArray *)products completionBlock:(void(^)(NSArray<NSDictionary *> *))completion;

+ (void)restoreTransactionsWithCompletionBlock:(RCHybridResponseBlock)completion;

+ (NSString *)appUserID;

+ (void)createAlias:(nullable NSString *)newAppUserId completionBlock:(RCHybridResponseBlock)completion;

+ (void)identify:(NSString *)appUserId completionBlock:(RCHybridResponseBlock)completion;

+ (void)resetWithCompletionBlock:(RCHybridResponseBlock)completion;

+ (void)setDebugLogsEnabled:(BOOL)enabled;

+ (void)getPurchaserInfoWithCompletionBlock:(RCHybridResponseBlock)completion;

+ (void)setAutomaticAppleSearchAdsAttributionCollection:(BOOL)enabled;

+ (void)getOfferingsWithCompletionBlock:(RCHybridResponseBlock)completion;

+ (BOOL)isAnonymous;

+ (void)purchaseProduct:(NSString *)productIdentifier completionBlock:(RCHybridResponseBlock)completion;

+ (void)purchasePackage:(NSString *)packageIdentifier offering:(NSString *)offeringIdentifier completionBlock:(RCHybridResponseBlock)completion;

+ (void)makeDeferredPurchase:(RCDeferredPromotionalPurchaseBlock)deferredPurchase completionBlock:(RCHybridResponseBlock)completion;

+ (void)setFinishTransactions:(BOOL)finishTransactions;

+ (void)checkTrialOrIntroductoryPriceEligibility:(nonnull NSArray<NSString *> *)productIdentifiers completionBlock:(RCReceiveIntroEligibilityBlock)completion;

@end

NS_ASSUME_NONNULL_END
