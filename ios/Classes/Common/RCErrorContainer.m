//
//  Created by RevenueCat.
//  Copyright © 2019 RevenueCat. All rights reserved.
//

#import "RCErrorContainer.h"


@interface RCErrorContainer ()

@property (nonatomic, readwrite) NSInteger code;
@property (nonatomic, nonnull, readwrite) NSString *message;
@property (nonatomic, nonnull, readwrite) NSDictionary *info;
@property (nonatomic, nonnull, readwrite) NSError *error;

@end

@implementation RCErrorContainer

- (instancetype)initWithError:(NSError *)error info:(NSDictionary *)info
{
    if (self = [super init]) {
        self.code = error.code;
        self.message = error.localizedDescription;
        self.info = info;
        self.error = error;
    }
    return self;
}

@end
