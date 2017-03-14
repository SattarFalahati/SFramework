//
//  SFProgressHUD.m
//  Pods
//
//  Created by Sattar Falahati on 10/02/17.
//
//

#import "SFProgressHUD.h"

// Helpers
#import "SFImports.h"

@implementation SFProgressHUD

+ (void)showProgressHUDWithMessage:(NSString *)message
{
    [self showProgressHUDWithMessage:message onView:WINDOW];
}

+ (void)hideProgressHUD
{
    [self hideProgressHUDFromView:WINDOW];
}

+ (void)showProgressHUDWithMessage:(NSString *)message onView:(id)view
{
    // SetUp Message
    if ([message isEmpty])
        message = @"";
    
    // SetUp Progress bar
    MBProgressHUD *progress = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    progress.labelText = message;
    progress.animationType = MBProgressHUDAnimationFade;
    progress.mode = MBProgressHUDModeIndeterminate;
    [progress show:YES];
}

+ (void)hideProgressHUDFromView:(id)view
{
    [MBProgressHUD hideHUDForView:view animated:YES];
}


@end
