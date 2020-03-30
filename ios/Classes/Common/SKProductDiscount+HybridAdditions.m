//
//  Created by RevenueCat.
//  Copyright © 2019 RevenueCat. All rights reserved.
//

#import "SKProduct+HybridAdditions.h"
#import "SKProductDiscount+HybridAdditions.h"


@implementation SKProductDiscount (RCPurchases)

- (nullable NSString *)rc_currencyCode {
    if(@available(iOS 10.0, *)) {
        return self.priceLocale.currencyCode;
    } else {
        return [self.priceLocale objectForKey:NSLocaleCurrencyCode];
    }
}

- (NSDictionary *)dictionary
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterCurrencyStyle;
    formatter.locale = self.priceLocale;
    
    NSMutableDictionary *d = [NSMutableDictionary dictionaryWithDictionary:@{
        @"price": @(self.price.floatValue),
        @"priceString": [formatter stringFromNumber:self.price],
        @"period": [SKProduct normalizedSubscriptionPeriod:self.subscriptionPeriod],
        @"periodUnit": [SKProduct normalizedSubscriptionPeriodUnit:self.subscriptionPeriod.unit],
        @"periodNumberOfUnits": @(self.subscriptionPeriod.numberOfUnits),
        @"cycles": @(self.numberOfPeriods)
    }];
    
    if (@available(iOS 12.2, *)) {
        if (self.identifier) {
            d[@"identifier"] = self.identifier;
        }
    }
    
    return d;
}

@end
