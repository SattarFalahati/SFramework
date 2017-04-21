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

// MARK: - ALERT VIEW

/// Alert view with ONE Button
+ (void)showAlertWithOneButtonOnTarget:(id)target withTitle:(NSString *)title withMessage:(NSString *)message withButtonTitle:(NSString *)btnTitle andButtonBlock:(SFAlertControllerCompletionBlock)touchEventBlock;

/// Alert view with TWO Buttons
+ (void)showAlertWithOTwoButtonsOnTarget:(id)target withTitle:(NSString *)title withMessage:(NSString *)message  withFirstButtonTitle:(NSString *)firstBtnTitle withBlock:(SFAlertControllerCompletionBlock)firstBtnTouchEventBlock withSecondButtonTitle:(NSString *)secondBtnTitle withBlock:(SFAlertControllerCompletionBlock)secondBtnTouchEventBlock;

// MARK: - ALERT NETWORK CONECTION

/// Locolized alert view For Network is not connect
+ (void)showAlertNetworkIsNotConnectOnTarget:(id)target withRetryBlock:(SFAlertControllerCompletionBlock)retryBtnTouchEventBlock withCancelBlock:(SFAlertControllerCompletionBlock)cancelBtnTouchEventBlock;

// MARK: - ACTION SHEET

/** 
 * Desciption of SFAlertController ActionSheet
 * Each of ActionSheet methods are having number off buttons PLUS on button with cancel style ( buttom btn to close the action sheet ) and this CANCEL btn is NOT included in the number of buttons
 **/

/// Action sheet with ONE Button and CANCEL Button
+ (void)showActionSheetWithOneButtonOnTarget:(id)target withTitle:(NSString *)title withMessage:(NSString *)message withButtonTitle:(NSString *)btnTitle andButtonBlock:(SFAlertControllerCompletionBlock)touchEventBlock withCancelButtonTitle:(NSString *)cancelBtnTitle withBlock:(SFAlertControllerCompletionBlock)cancelBtnTouchEventBlock;

/// Action sheet with TWO Buttons and CANCEL Button
+ (void)showActionSheetWithTwoButtonsOnTarget:(id)target withTitle:(NSString *)title withMessage:(NSString *)message  withFirstButtonTitle:(NSString *)firstBtnTitle withBlock:(SFAlertControllerCompletionBlock)firstBtnTouchEventBlock withSecondButtonTitle:(NSString *)secondBtnTitle withBlock:(SFAlertControllerCompletionBlock)secondBtnTouchEventBlock withCancelButtonTitle:(NSString *)cancelBtnTitle withBlock:(SFAlertControllerCompletionBlock)cancelBtnTouchEventBlock;

/// Action sheet with three Buttons and CANCEL Button
+ (void)showActionSheetWithThreeButtonsOnTarget:(id)target withTitle:(NSString *)title withMessage:(NSString *)message  withFirstButtonTitle:(NSString *)firstBtnTitle withBlock:(SFAlertControllerCompletionBlock)firstBtnTouchEventBlock withSecondButtonTitle:(NSString *)secondBtnTitle withBlock:(SFAlertControllerCompletionBlock)secondBtnTouchEventBlock withThirdButtonTitle:(NSString *)thirdBtnTitle withBlock:(SFAlertControllerCompletionBlock)thirdBtnTouchEventBlock withCancelButtonTitle:(NSString *)cancelBtnTitle withBlock:(SFAlertControllerCompletionBlock)cancelBtnTouchEventBlock;


@end
