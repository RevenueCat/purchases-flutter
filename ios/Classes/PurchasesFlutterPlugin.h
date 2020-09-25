#if TARGET_OS_OSX
#import <FlutterMacOS/FlutterMacOS.h>
#else
#import <Flutter/Flutter.h>
#endif
@import Purchases;

@interface PurchasesFlutterPlugin : NSObject<FlutterPlugin>
@end
