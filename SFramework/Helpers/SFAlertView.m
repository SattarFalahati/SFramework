//
//  SFAlertView.m
//  SFramework
//
//  Created by Sattar Falahati (SFramework) on 13/04/16.
//  Copyright © 2016 Sattar Falahati (SFramework). All rights reserved.
//
#import "SFAlertView.h"

#import "SFLocalization.h"

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

    NSString *str = [SFLocalization internalFrameworkLocalizedStringForKey:@"SFAlert.NoInternet.Title" withDefault:@"SFAlert.NoInternet.Title"];
    
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


/// Locolized alert view For Network is not connect
+ (void)showAlertNetworkIsNotConnectOnTarget:(id)target withRetryBlock:(SFAlertViewCompletionBlock)retryBtnTouchEventBlock withCancelBlock:(SFAlertViewCompletionBlock)cancelBtnTouchEventBlock
{
    NSString *title = [SFLocalization internalFrameworkLocalizedStringForKey:@"SFAlert.NoInternet.Title" withDefault:@"SFAlert.NoInternet.Title"];
    NSString *message = [SFLocalization internalFrameworkLocalizedStringForKey:@"SFAlert.NoInternet.Message" withDefault:@"SFAlert.NoInternet.Message"];
    NSString *retryBtnTitle = [SFLocalization internalFrameworkLocalizedStringForKey:@"SFAlert.NoInternet.BTNRetry" withDefault:@"SFAlert.NoInternet.BTNRetry"];
    NSString *cancelBtnTitle = [SFLocalization internalFrameworkLocalizedStringForKey:@"SFAlert.NoInternet.BTNCencel" withDefault:@"SFAlert.NoInternet.BTNCencel"];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *firstBtn = [UIAlertAction actionWithTitle:retryBtnTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        dispatch_async(dispatch_get_main_queue(), ^{
            retryBtnTouchEventBlock();
        });
    }];
    
    UIAlertAction *secondBtn = [UIAlertAction actionWithTitle:cancelBtnTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        dispatch_async(dispatch_get_main_queue(), ^{
            cancelBtnTouchEventBlock();
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
