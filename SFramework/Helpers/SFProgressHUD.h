//
//  SFProgressHUD.h
//  Pods
//
//  Created by Sattar Falahati on 10/02/17.
//
//

#import <Foundation/Foundation.h>

@interface SFProgressHUD : NSObject

/// Show progress hud on a view with message
+ (void)showProgressHUDWithMessage:(nonnull NSString *)message onView:(nonnull id)view;

/// Hide progress hud from a view
+ (void)hideProgressHUDFromView:(nonnull id)view;

/// Show progress hud on WINDOW with message
+ (void)showProgressHUDWithMessage:(nonnull NSString *)message;

/// Hide progress hud from WINDOW
+ (void)hideProgressHUD;

@end
