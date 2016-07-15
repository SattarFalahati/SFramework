//
//  SFAlertView.m
//  SFramework
//
//  Created by Sattar Falahati (SFramework) on 13/04/16.
//  Copyright © 2016 Sattar Falahati (SFramework). All rights reserved.
//
#import "SFAlertView.h"

@implementation SFAlertView


/// Alert view with ONE Button
+ (void)showAlertWithOneButtonOnTarget:(id)target withTitle:(NSString *)title withMessage:(NSString *)message withButtonTitle:(NSString *)btnTitle andButtonBlock:(SFAlertViewCompletionBlock)touchEventBlock
{
    // Create alertController
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    // Add button
    UIAlertAction *button = [UIAlertAction actionWithTitle:btnTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        dispatch_async(dispatch_get_main_queue(), ^{
            touchEventBlock();
        });
    }];
    [alertController addAction:button];
    
    // Present alert (show)
    dispatch_async(dispatch_get_main_queue(), ^{
        [target presentViewController:alertController animated:YES completion:nil];
    });
    
}

/// Alert view with TWO Buttons
+ (void)showAlertWithOTwoButtonsOnTarget:(id)target withTitle:(NSString *)title withMessage:(NSString *)message  withFirstButtonTitle:(NSString *)firstBtnTitle withBlock:(SFAlertViewCompletionBlock)firstBtnTouchEventBlock withSecondButtonTitle:(NSString *)secondBtnTitle withBlock:(SFAlertViewCompletionBlock)secondBtnTouchEventBlock
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *firstBtn = [UIAlertAction actionWithTitle:firstBtnTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        dispatch_async(dispatch_get_main_queue(), ^{
            firstBtnTouchEventBlock();
        });
    }];
    
    UIAlertAction *secondBtn = [UIAlertAction actionWithTitle:secondBtnTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        dispatch_async(dispatch_get_main_queue(), ^{
            secondBtnTouchEventBlock();
        });
    }];
    
    [alertController addAction:firstBtn];
    [alertController addAction:secondBtn];
    
    // Present alert (show)
    dispatch_async(dispatch_get_main_queue(), ^{
        [target presentViewController:alertController animated:YES completion:nil];
    });
    
}

@end
