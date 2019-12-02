//
//  Created by RevenueCat.
//  Copyright © 2019 RevenueCat. All rights reserved.
//

#import "RCOffering+HybridAdditions.h"
#import "SKProduct+HybridAdditions.h"
#import "RCPackage+HybridAdditions.h"

@implementation RCOffering (HybridAdditions)

- (NSDictionary *)dictionary
{
    NSMutableDictionary *jsonDict = [NSMutableDictionary new];
    jsonDict[@"identifier"] = self.identifier;
    jsonDict[@"serverDescription"] = self.serverDescription;

    NSMutableArray *availablePackages = [NSMutableArray new];
    for (RCPackage *package in self.availablePackages) {
        [availablePackages addObject:[package dictionary:self.identifier]];
    }
    jsonDict[@"availablePackages"] = [NSArray arrayWithArray:availablePackages];

    jsonDict[@"lifetime"] = [self.lifetime dictionary:self.identifier];
    jsonDict[@"annual"] = [self.annual dictionary:self.identifier];
    jsonDict[@"sixMonth"] = [self.sixMonth dictionary:self.identifier];
    jsonDict[@"threeMonth"] = [self.threeMonth dictionary:self.identifier];
    jsonDict[@"twoMonth"] = [self.twoMonth dictionary:self.identifier];
    jsonDict[@"monthly"] = [self.monthly dictionary:self.identifier];
    jsonDict[@"weekly"] = [self.weekly dictionary:self.identifier];

    return [NSDictionary dictionaryWithDictionary:jsonDict];
}

@end
