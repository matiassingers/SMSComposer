//
//  SMSComposer.h
//
//  Created by Grant Sanders on 12/25/2010.
//  Modified by Matias Singers on 12/01/2013.

#import "SMSComposer.h"

@implementation SMSComposer

@synthesize callback;

- (CDVPlugin *)initWithWebView:(UIWebView *)theWebView
{
	self = (SMSComposer *)[super initWithWebView:theWebView];
	return self;
}

- (void)showSMSComposer:(CDVInvokedUrlCommand *)command
{
	self.callback = [[arguments objectAtIndex:0] retain];

	if (![MFMessageComposeViewController canSendText]) {
		NSLog(@"SMS composer is not available on this platform.");

		UIAlertView *warningAlert = [[UIAlertView alloc] 
									initWithTitle:@"Error" 
									message:@"Your device doesn't support SMS!" 
									delegate:nil 
									cancelButtonTitle:@"OK" 
									otherButtonTitles:nil];
		[warningAlert show];
		return;
	}

	NSArray *recipients = [command.arguments objectAtIndex:0];
	NSString *body = [command.arguments objectAtIndex:1];

	MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
	messageController.messageComposeDelegate = self;
	[messageController setRecipients:recipients];
	[messageController setBody:body];

	 // Present message view controller on screen
	[self.viewController presentViewController:messageController animated:YES completion:nil];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
	CDVPluginResult* pluginResult = nil;

	switch (result) {
		case MessageComposeResultFailed:
		{
			pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
			break;
		}
			
		default:
		{
			pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
			break;
		}
	}
	
	[self.viewController dismissViewControllerAnimated:YES completion:nil];
	[self.commandDelegate sendPluginResult:pluginResult callbackId:callback];

    [self.callback release];
}

@end