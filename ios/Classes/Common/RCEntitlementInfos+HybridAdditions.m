//
//  Created by RevenueCat.
//  Copyright © 2019 RevenueCat. All rights reserved.
//

#import "RCEntitlementInfo+HybridAdditions.h"
#import "RCEntitlementInfos+HybridAdditions.h"

@implementation RCEntitlementInfos (HybridAdditions)

- (NSDictionary *)dictionary
{
    NSMutableDictionary *jsonDict = [NSMutableDictionary new];
    NSMutableDictionary *all = [NSMutableDictionary new];
    for (NSString *entId in self.all) {
        all[entId] = self.all[entId].dictionary;
    }
    jsonDict[@"all"] = all;

    NSMutableDictionary *active = [NSMutableDictionary new];
    for (NSString *entId in self.active) {
        active[entId] = self.active[entId].dictionary;
    }
    jsonDict[@"active"] = active;

    return [NSDictionary dictionaryWithDictionary:jsonDict];
}

@end
