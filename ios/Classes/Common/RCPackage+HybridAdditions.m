//
//  Created by RevenueCat.
//  Copyright © 2019 RevenueCat. All rights reserved.
//

#import "RCPackage+HybridAdditions.h"
#import "SKProduct+HybridAdditions.h"

@implementation RCPackage (HybridAdditions)

- (NSDictionary *)dictionary:(NSString *)offeringIdentifier
{
    NSMutableDictionary *jsonDict = [NSMutableDictionary new];

    jsonDict[@"identifier"] = self.identifier;
    jsonDict[@"packageType"] = [self nameForPackageType:self.packageType];
    jsonDict[@"product"] = self.product.dictionary;
    jsonDict[@"offeringIdentifier"] = offeringIdentifier;

    return [NSDictionary dictionaryWithDictionary:jsonDict];
}

- (NSString *)nameForPackageType:(RCPackageType)type
{
    switch(type) {
        case RCPackageTypeUnknown:
            return @"UNKNOWN";
        case RCPackageTypeCustom:
            return @"CUSTOM";
        case RCPackageTypeLifetime:
            return @"LIFETIME";
        case RCPackageTypeAnnual:
            return @"ANNUAL";
        case RCPackageTypeSixMonth:
            return @"SIX_MONTH";
        case RCPackageTypeThreeMonth:
            return @"THREE_MONTH";
        case RCPackageTypeTwoMonth:
            return @"TWO_MONTH";
        case RCPackageTypeMonthly:
            return @"MONTHLY";
        case RCPackageTypeWeekly:
            return @"WEEKLY";
    }
}

@end