//
//  Created by RevenueCat.
//  Copyright © 2019 RevenueCat. All rights reserved.
//

#import "RCEntitlement+HybridAdditions.h"
#import "SKProduct+HybridAdditions.h"

@implementation RCEntitlement (HybridAdditions)

- (NSDictionary *)dictionary
{
    NSMutableDictionary *jsonDict = [NSMutableDictionary new];
    for (NSString *key in self.offerings) {
        RCOffering *offering = self.offerings[key];
        jsonDict[key] = offering.activeProduct.dictionary;
    }
    return [NSDictionary dictionaryWithDictionary:jsonDict];
}

@end