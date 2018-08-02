#import <Cordova/CDV.h>

@interface CPSwish : CDVPlugin

- (void)echo : (CDVInvokedUrlCommand*)command;
- (void)beginPayment : (CDVInvokedUrlCommand*)command;
- (void)isSwishInstalled : (CDVInvokedUrlCommand*)command;
@end
