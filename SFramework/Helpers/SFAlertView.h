//
//  SFAlertView.h
//  SFramework
//
//  Created by Sattar Falahati (SFramework) on 13/04/16.
//  Copyright © 2016 Sattar Falahati (SFramework). All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SFAlertView : NSObject

/// SFAlertView Completion Block
typedef void (^SFAlertViewCompletionBlock)();

/// Alert view with ONE Button
+ (void)showAlertWithOneButtonOnTarget:(id)target withTitle:(NSString *)title withMessage:(NSString *)message withButtonTitle:(NSString *)btnTitle andButtonBlock:(SFAlertViewCompletionBlock)touchEventBlock;

/// Alert view with TWO Buttons
+ (void)showAlertWithOTwoButtonsOnTarget:(id)target withTitle:(NSString *)title withMessage:(NSString *)message  withFirstButtonTitle:(NSString *)firstBtnTitle withBlock:(SFAlertViewCompletionBlock)firstBtnTouchEventBlock withSecondButtonTitle:(NSString *)secondBtnTitle withBlock:(SFAlertViewCompletionBlock)secondBtnTouchEventBlock;

/// Locolized alert view For Network is not connect
+ (void)showAlertNetworkIsNotConnectOnTarget:(id)target withRetryBlock:(SFAlertViewCompletionBlock)retryBtnTouchEventBlock withCancelBlock:(SFAlertViewCompletionBlock)cancelBtnTouchEventBlock;

@end
