//
//  Created by RevenueCat.
//  Copyright © 2019 RevenueCat. All rights reserved.
//

#import "SKPaymentDiscount+HybridAdditions.h"

@implementation SKPaymentDiscount (RCPurchases)

- (NSDictionary *)dictionary
{
    return @{
        @"identifier": self.identifier,
        @"keyIdentifier": self.keyIdentifier,
        @"nonce": self.nonce.UUIDString,
        @"signature": self.signature,
        @"timestamp": self.timestamp,
    };
}

@end
