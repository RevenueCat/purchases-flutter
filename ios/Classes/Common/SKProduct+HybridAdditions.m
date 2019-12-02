//
//  Created by RevenueCat.
//  Copyright © 2019 RevenueCat. All rights reserved.
//

#import "SKProduct+HybridAdditions.h"

@implementation SKProduct (RCPurchases)

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
                        @"identifier": self.productIdentifier ?: @"",
                        @"description": self.localizedDescription ?: @"",
                        @"title": self.localizedTitle ?: @"",
                        @"price": @(self.price.floatValue),
                        @"price_string": [formatter stringFromNumber:self.price],
                        @"currency_code": (self.rc_currencyCode) ? self.rc_currencyCode : [NSNull null]
                        }];
    
    if (@available(iOS 11.2, *)) {
        if (self.introductoryPrice) {
            d[@"intro_price"] = @(self.introductoryPrice.price.floatValue);
            d[@"intro_price_string"] = [formatter stringFromNumber:self.introductoryPrice.price];
            d[@"intro_price_period"] = [self normalizeSubscriptionPeriod:self.introductoryPrice.subscriptionPeriod];
            d[@"intro_price_period_unit"] = [self normalizeSubscriptionPeriodUnit:self.introductoryPrice.subscriptionPeriod.unit];
            d[@"intro_price_period_number_of_units"] = @(self.introductoryPrice.subscriptionPeriod.numberOfUnits);
            d[@"intro_price_cycles"] = @(self.introductoryPrice.numberOfPeriods);
            return d;
        }
    }

    d[@"intro_price"] = [NSNull null];
    d[@"intro_price_string"] = [NSNull null];
    d[@"intro_price_period"] = [NSNull null];
    d[@"intro_price_period_unit"] = [NSNull null];
    d[@"intro_price_period_number_of_units"] = [NSNull null];
    d[@"intro_price_cycles"] = [NSNull null];
    
    return d;
}

- (NSString *)normalizeSubscriptionPeriod:(SKProductSubscriptionPeriod *)subscriptionPeriod API_AVAILABLE(ios(11.2)){
    NSString *unit;
    switch (subscriptionPeriod.unit) {
        case SKProductPeriodUnitDay:
            unit = @"D";
            break;
        case SKProductPeriodUnitWeek:
            unit = @"W";
            break;
        case SKProductPeriodUnitMonth:
            unit = @"M";
            break;
        case SKProductPeriodUnitYear:
            unit = @"Y";
            break;
    }
    return [NSString stringWithFormat:@"%@%@%@", @"P", @(subscriptionPeriod.numberOfUnits), unit];
}

- (NSString *)normalizeSubscriptionPeriodUnit:(SKProductPeriodUnit)subscriptionPeriodUnit API_AVAILABLE(ios(11.2)){
    switch (subscriptionPeriodUnit) {
        case SKProductPeriodUnitDay:
            return @"DAY";
        case SKProductPeriodUnitWeek:
            return @"WEEK";
        case SKProductPeriodUnitMonth:
            return @"MONTH";
        case SKProductPeriodUnitYear:
            return @"YEAR";
    }
}

@end
