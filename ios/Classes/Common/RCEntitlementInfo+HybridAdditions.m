//
//  Created by RevenueCat.
//  Copyright © 2019 RevenueCat. All rights reserved.
//

#import "RCEntitlementInfo+HybridAdditions.h"
#import "SKProduct+HybridAdditions.h"

static NSDateFormatter *formatter;
static dispatch_once_t onceToken;

static NSString * stringFromDate(NSDate *date)
{
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

@implementation RCEntitlementInfo (HybridAdditions)

- (NSDictionary *)dictionary
{
    NSMutableDictionary *jsonDict = [NSMutableDictionary new];
    jsonDict[@"identifier"] = self.identifier;
    jsonDict[@"isActive"] = @(self.isActive);
    jsonDict[@"willRenew"] = @(self.willRenew);

    switch (self.periodType) {
        case RCIntro:
            jsonDict[@"periodType"] = @"INTRO";
            break;
        case RCNormal:
            jsonDict[@"periodType"] = @"NORMAL";
            break;
        case RCTrial:
            jsonDict[@"periodType"] = @"TRIAL";
            break;
    }
    
    jsonDict[@"latestPurchaseDate"] = stringFromDate(self.latestPurchaseDate);
    jsonDict[@"originalPurchaseDate"] = stringFromDate(self.originalPurchaseDate);
    jsonDict[@"expirationDate"] = stringFromDate(self.expirationDate) ?: [NSNull null];

    switch (self.store) {
        case RCAppStore:
            jsonDict[@"store"] = @"APP_STORE";
            break;
        case RCMacAppStore:
            jsonDict[@"store"] = @"MAC_APP_STORE";
            break;
        case RCPlayStore:
            jsonDict[@"store"] = @"PLAY_STORE";
            break;
        case RCStripe:
            jsonDict[@"store"] = @"STRIPE";
            break;
        case RCPromotional:
            jsonDict[@"store"] = @"PROMOTIONAL";
            break;
        case RCUnknownStore:
            jsonDict[@"store"] = @"UNKNOWN_STORE";
            break;
    }
    
    jsonDict[@"productIdentifier"] = self.productIdentifier;
    jsonDict[@"isSandbox"] = @(self.isSandbox);
    jsonDict[@"unsubscribeDetectedAt"] = stringFromDate(self.unsubscribeDetectedAt) ?: [NSNull null];
    jsonDict[@"billingIssueDetectedAt"] = stringFromDate(self.billingIssueDetectedAt) ?: [NSNull null];
    
    return [NSDictionary dictionaryWithDictionary:jsonDict];
}

@end
