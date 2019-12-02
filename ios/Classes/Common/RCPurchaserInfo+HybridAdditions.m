//
//  Created by RevenueCat.
//  Copyright © 2019 RevenueCat. All rights reserved.
//

#import "RCPurchaserInfo+HybridAdditions.h"
#import "RCEntitlementInfos+HybridAdditions.h"

static NSDateFormatter *formatter;
static dispatch_once_t onceToken;

static NSString *stringFromDate(NSDate *date) {
    dispatch_once(&onceToken, ^{
        // Here we're not using NSISO8601DateFormatter as we need to support iOS < 10
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
        dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
        dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
        formatter = dateFormatter;
    });

    return [formatter stringFromDate:date];
}

@implementation RCPurchaserInfo (HybridAdditions)

- (NSDictionary *)dictionary
{
    NSMutableDictionary *allExpirations = [NSMutableDictionary new];
    for (NSString *productIdentifier in self.allPurchasedProductIdentifiers) {
        NSDate *date = [self expirationDateForProductIdentifier:productIdentifier];
        allExpirations[productIdentifier] = stringFromDate(date) ?: [NSNull null];
    }

    NSMutableDictionary *allPurchases = [NSMutableDictionary new];
    for (NSString *productIdentifier in self.allPurchasedProductIdentifiers) {
        NSDate *date = [self purchaseDateForProductIdentifier:productIdentifier];
        allPurchases[productIdentifier] = stringFromDate(date) ?: [NSNull null];
    }

    id latestExpiration = stringFromDate(self.latestExpirationDate) ?: [NSNull null];

    return @{
            @"entitlements": self.entitlements.dictionary,
            @"activeSubscriptions": self.activeSubscriptions.allObjects,
            @"allPurchasedProductIdentifiers": self.allPurchasedProductIdentifiers.allObjects,
            @"latestExpirationDate": latestExpiration,
            @"firstSeen": stringFromDate(self.firstSeen),
            @"originalAppUserId": self.originalAppUserId,
            @"requestDate": stringFromDate(self.requestDate),
            @"allExpirationDates": allExpirations,
            @"allPurchaseDates": allPurchases,
            @"originalApplicationVersion": self.originalApplicationVersion ?: [NSNull null],
    };
}

@end
