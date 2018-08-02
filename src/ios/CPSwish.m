#import "CPSwish.h"

@implementation CPSwish
NSString* paymentCallbackID = nil;

- (void)echo:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = [command callbackId];
    NSString* msg = [NSString stringWithFormat: @"Echo: %@", [[command arguments] objectAtIndex:0]];

    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:msg];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

-(void) urlNotification:(NSNotification*) notification
{
    NSString* launchUrl = [(NSURL*)[notification object] absoluteString];
    NSLog(@"%@", launchUrl);
    
    if([launchUrl hasPrefix:@"swish"]) {
        
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        
        if(paymentCallbackID != nil) {
            CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK  messageAsString:launchUrl];
            [self.commandDelegate sendPluginResult:result callbackId:paymentCallbackID];
        }
    }

}

- (void)beginPayment:(CDVInvokedUrlCommand*)command {

    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(urlNotification:)
     name:CDVPluginHandleOpenURLNotification object:nil];

	 NSString *encodedCallbackURLStr = [[NSString stringWithFormat:@"swish%@://", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"SWISH_URL_SUFFIX"]]
		stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];

	 
	 NSString* token = [[command arguments] objectAtIndex:0];
	NSString* urlString = [NSString stringWithFormat:@"swish://paymentrequest?token=%@&callbackurl=%@", token, encodedCallbackURLStr];
	 
    paymentCallbackID = command.callbackId;
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

- (void)isSwishInstalled:(CDVInvokedUrlCommand*)command
{
	 bool isInstalled = [[UIApplication sharedApplication]
	 canOpenURL:[NSURL URLWithString:@"swish://"]];
    
    

    
    
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:isInstalled];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}



@end
