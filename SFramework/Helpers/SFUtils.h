//
//  SFUtils.h
//
//  Copyright (c) 2016 Sattar Falahati (SFramework). All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>
#include <math.h>
#include <sys/xattr.h>


@interface SFUtils : NSObject

+ (nonnull id)sharedManager;

#pragma mark - Arrays

+ (nonnull NSMutableArray *)generateRandomArray:(int)max;

#pragma mark - Text

+ (CGSize)heightText:(nonnull NSString *)text sizeWithFont:(nonnull UIFont *)font constrainedToSize:(CGSize)size;

#pragma mark - Unic ID

+ (nonnull NSString *)UUID;
+ (nonnull NSString *)UUIDforEmail;

#pragma mark - Language

+ (nonnull NSString *)getMyLanguage;

#pragma mark - Text fields

+ (void)setPlaceholderForTextField:(nonnull UITextField *)txtFld withText:(nullable NSString *)text withColor:(nullable UIColor *)color andFont:(nullable UIFont *)font;

#pragma mark - Navigation Bar

+ (nonnull UIBarButtonItem *)barButtonItemWithImageName:(nonnull NSString *)imageName forTarget:(nonnull id)target andselector:(nonnull SEL)selector;
+ (void)setupNavigationBarWithBackgroundColor:(nonnull UIColor *)bgColor WithFontName:(nonnull UIFont *)font andfontColor:(nonnull UIColor *)fontColor;
+ (void)customNavigationController:(nonnull UINavigationController *)navigationBar forTarget:(nonnull id)target setBackgroundColor:(nonnull UIColor *)bgColor withPageTitle:(nonnull NSString *)title WithFontName:(nullable UIFont *)font andfontColor:(nullable UIColor *)fontColor;
+ (void)setImageForNavigationItem:(nonnull UINavigationItem *)navItem forTarget:(nonnull id)target;

#pragma mark - Segments

+ (void)setSegmentFont:(nonnull UIFont *)font andColor:(nonnull UIColor *)color forState:(UIControlState)state;

#pragma mark - STRING

+ (nonnull NSArray *)findRangeOfNumbrsInStringWithOriginalString:(nonnull NSString *)originalString;
#pragma mark - CAMERA & SCREEN

+ (BOOL)hasCamera;
+ (void)setScreenAlwaysOn:(BOOL)value;

#pragma mark - progress bar

+ (void)showProgressHUDWithMessage:(nonnull NSString *)message onView:(nonnull id)view;
+ (void)hideProgressHUDFromView:(nonnull id)view;
+ (void)showProgressHUDWithMessage:(nonnull NSString *)message;
+ (void)hideProgressHUD;

#pragma mark - Tab bar controller

/// Use this method to hide tab bar controller with animation
+ (void)setTabBarController:(nonnull UITabBarController *)taBarController hidden:(BOOL)tabBarHidden animated:(BOOL)animated;

#pragma mark - Phone call

/// Use this method to call to a number
+ (void)callToNumber:(nonnull NSString *)number;

@end
