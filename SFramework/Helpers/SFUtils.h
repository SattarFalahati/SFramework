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

+ (id)sharedManager;

#pragma mark - Objects

+ (BOOL)isEmpty:(NSObject *)obj;
+ (BOOL)isNotEmpty:(NSObject *)obj;

#pragma mark - Arrays

+ (NSMutableArray *)generateRandomArray:(int)max;

#pragma mark - Buttons

+ (void)roundetBottomCornerView:(UIView *)view onCorner:(UIRectCorner)rectCorner andRadius:(CGFloat)radius andBackgroundColor:(UIColor *)bColor;
+ (void)setImageButtonWithoutText:(UIButton *)btn andImage:(UIImage *)btnImage transparent:(BOOL)transparent forState:(UIControlState)state;
+ (void)setTextButton:(UIButton *)btn andText:(NSString *)text forState:(UIControlState)state;
+ (void)setImageButton:(UIButton *)btn andImage:(UIImage *)btnImage forState:(UIControlState)state;
+ (void)setImageBackgroundButton:(UIButton *)btn andImage:(UIImage *)btnImage forState:(UIControlState)state;
+ (void)setTextColorButton:(UIButton *)btn andColor:(UIColor *)textColor forState:(UIControlState)state;

#pragma mark - Network

+ (BOOL)isNetworkStatusActive;
+ (BOOL)isReachableWithoutRequiringConnection:(SCNetworkReachabilityFlags)flags;
+ (BOOL)isHostReachable:(NSString *)host;
+ (BOOL)NetworkStatus;
+ (void)getNetworkConnectionStatuse;

#pragma mark - Text

+ (CGSize)heightText:(NSString *)text sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

#pragma mark - Table

+ (void)refreshWithTableView:(UITableView *)table;

#pragma mark - Unic ID

+ (NSString *)UUID;
+ (NSString *)UUIDforEmail;

#pragma mark - Language

+ (NSString *)getMyLanguage;

#pragma mark - Images

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)scaleToWidth:(CGFloat)width andOrginalImage:(UIImage *)orginalImage;

#pragma mark - Text fields

+ (void)setPlaceholderForTextField:(UITextField *)txtFld withText:(NSString *)text withColor:(UIColor *)color andFont:(UIFont *)font;

#pragma mark - Navigation Bar

+ (UIBarButtonItem *)barButtonItemWithImageName:(NSString *)imageName forTarget:(id)target andselector:(SEL)selector;
+ (void)setupNavigationBarWithBackgroundColor:(UIColor *)bgColor WithFontName:(UIFont *)font andfontColor:(UIColor *)fontColor;
+ (void)navigationController:(UINavigationController *)navigationBar forTarget:(id)target setBackgroundColor:(UIColor *)bgColor withPageTitle:(NSString *)title WithFontName:(UIFont *)font andfontColor:(UIColor *)fontColor;
+ (void)setImageForNavigationItem:(UINavigationItem *)navItem forTarget:(id)target;

#pragma mark - Segments

+ (void)setSegmentFont:(UIFont *)font andColor:(UIColor *)color forState:(UIControlState)state;

#pragma mark - Color with HEX

+ (UIColor *)colorWithHexString:(NSString *)HexSting;

#pragma mark - STRING

+ (NSArray *)findRangeNumbrsInStringWithOriginalString:(NSString *)originalString;

#pragma mark - NSDATE

+ (NSDate *)getDateFromString:(NSString *)dateString;
+ (NSString *)getDateString:(NSDate *)date andDateFormatter:(NSString *)dateForm;
+ (NSDate *)getNowDate;
+ (long long)getNowDateInMillisecondsFrom1970;
+ (long long)getDateInMillisecondsFrom1970:(NSDate *)date;
+ (NSDate *)getNowDateWithFormat:(NSString *)format;
+ (NSDate *)getDate:(NSDate *)fromDate addDays:(NSUInteger)days addHours:(NSUInteger)hours;
+ (BOOL)date:(NSDate *)date is:(BOOL)before otherDate:(NSDate *)otherDate;

/// USE TO GET FIRST OR LAST DATE OF A MONTH EXAMPLE : FIRST DAY :[self returnDateForMonth:components.month year:components.year day:2 withDate:date] last DAY :  [self returnDateForMonth:components.month+1 year:components.year day:1 withDate:date];
+ (NSDate *)returnDayForMonth:(NSInteger)month year:(NSInteger)year day:(NSInteger)day fromDate:(NSDate *)date;

#pragma mark - CAMERA & SCREEN

+ (BOOL)hasCamera;
+ (void)setScreenAlwaysOn:(BOOL)value;

#pragma mark - progress bar

+ (void)showProgressHUDWithMessage:(NSString *)message;
+ (void)stopProgressHUD;

#pragma mark - Border && Radius

+ (void)roundCorners:(UIRectCorner)corners onView:(UIView *)view radius:(CGFloat)radius withBorder:(BOOL)border andBorderColor:(UIColor *)color;
+ (void)roundTopCornersRadius:(CGFloat)radius onView:(UIView *)view withBorder:(BOOL)border andBorderColor:(UIColor *)color;
+ (void)roundBottomCornersRadius:(CGFloat)radius onView:(UIView *)view withBorder:(BOOL)border andBorderColor:(UIColor *)color;

@end
