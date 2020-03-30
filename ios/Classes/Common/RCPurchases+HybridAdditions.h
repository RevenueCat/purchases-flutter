//
// Created by RevenueCat on 3/19/20.
// Copyright (c) 2020 Purchases. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Purchases/Purchases.h>

NS_ASSUME_NONNULL_BEGIN


@interface RCPurchases (HybridAdditions)

- (void)_setPushTokenString:(nullable NSString *)pushToken;

@end


NS_ASSUME_NONNULL_END
