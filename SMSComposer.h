//
//  SMSComposer.h
//
//  Created by Grant Sanders on 12/25/2010.
//  Modified by Matias Singers on 12/01/2013.

#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>

#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMessageComposeViewController.h>

NSString *callback;

@interface SMSComposer : CDVPlugin <MFMessageComposeViewControllerDelegate>{
    NSString* callbackId;
}

@property (nonatomic, retain) NSString* callbackId;

- (void)showSMSComposer:(CDVInvokedUrlCommand*)command;
@end