//
//  SFAlertView.h
//  SFramework
//
//  Created by Sattar Falahati (SFramework) on 13/04/16.
//  Copyright © 2016 Sattar Falahati (SFramework). All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SFAlertController : NSObject

/// SFAlertView Completion Block
typedef void (^SFAlertControllerCompletionBlock)();

#pragma mark - ALERT VIEW

/// Alert view with ONE Button
+ (void)showAlertWithOneButtonOnTarget:(id)target withTitle:(NSString *)title withMessage:(NSString *)message withButtonTitle:(NSString *)btnTitle andButtonBlock:(SFAlertControllerCompletionBlock)touchEventBlock;

/// Alert view with TWO Buttons
+ (void)showAlertWithOTwoButtonsOnTarget:(id)target withTitle:(NSString *)title withMessage:(NSString *)message  withFirstButtonTitle:(NSString *)firstBtnTitle withBlock:(SFAlertControllerCompletionBlock)firstBtnTouchEventBlock withSecondButtonTitle:(NSString *)secondBtnTitle withBlock:(SFAlertControllerCompletionBlock)secondBtnTouchEventBlock;

#pragma mark - ALERT NETWORK CONECTION

/// Locolized alert view For Network is not connect
+ (void)showAlertNetworkIsNotConnectOnTarget:(id)target withRetryBlock:(SFAlertControllerCompletionBlock)retryBtnTouchEventBlock withCancelBlock:(SFAlertControllerCompletionBlock)cancelBtnTouchEventBlock;


#pragma mark - ACTION SHEET

/// Action sheet with ONE Button
+ (void)showActionSheetWithOneButtonOnTarget:(id)target withTitle:(NSString *)title withMessage:(NSString *)message withButtonTitle:(NSString *)btnTitle andButtonBlock:(SFAlertControllerCompletionBlock)touchEventBlock;

/// Action sheet with TWO Buttons
+ (void)showActionSheetWithOTwoButtonsOnTarget:(id)target withTitle:(NSString *)title withMessage:(NSString *)message  withFirstButtonTitle:(NSString *)firstBtnTitle withBlock:(SFAlertControllerCompletionBlock)firstBtnTouchEventBlock withSecondButtonTitle:(NSString *)secondBtnTitle withBlock:(SFAlertControllerCompletionBlock)secondBtnTouchEventBlock;

/// Action sheet with three Buttons
+ (void)showActionSheetWithOThreeButtonsOnTarget:(id)target withTitle:(NSString *)title withMessage:(NSString *)message  withFirstButtonTitle:(NSString *)firstBtnTitle withBlock:(SFAlertControllerCompletionBlock)firstBtnTouchEventBlock withSecondButtonTitle:(NSString *)secondBtnTitle withBlock:(SFAlertControllerCompletionBlock)secondBtnTouchEventBlock withThirdButtonTitle:(NSString *)thirdBtnTitle withBlock:(SFAlertControllerCompletionBlock)thirdBtnTouchEventBlock;


@end
