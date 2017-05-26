//
//  SFUtils.h
//
//  Copyright (c) 2016 Sattar Falahati (SFramework). All rights reserved.
//

#import "SFUtils.h"

// Helpers
#import "SFImports.h"

// External Fameworks
#import "AFNetworking.h"


@interface SFUtils ()
@end

@implementation SFUtils

+ (nonnull id)sharedManager
{
    static id sharedManager;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

// MARK: - Arrays

+ (NSMutableArray *)generateRandomArray:(int) max
{
    NSMutableArray *randArray = [NSMutableArray new];
    for (int k = 0; k < max; k++) {
        int r = arc4random() % max;
        if([randArray containsObject:[NSString stringWithFormat:@"%d", r]]){
            k--;
        }else{
            [randArray addObject:[NSString stringWithFormat:@"%d", r]];
        }
    }
    return randArray;
}

// MARK: - Text

+ (CGSize)heightText:(NSString *)text sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    if(IS_IOS7_AND_UP){
        NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys: font, NSFontAttributeName, nil];
        CGRect frame = [text boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:attributesDictionary context:nil];
        return frame.size;
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        return [text sizeWithFont:font constrainedToSize:size];
#pragma clang diagnostic pop
    }
}

// MARK: - Unic ID

+ (NSString *)UUID
{
    CFUUIDRef newUniqueID = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef newUniqueIDString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueID);
    NSString *guid = (__bridge NSString *)newUniqueIDString;
    CFRelease(newUniqueIDString);
    CFRelease(newUniqueID);
    return([guid lowercaseString]);
}

+ (NSString *)UUIDforEmail
{
    NSString *uuid = [[self UUID] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return [uuid substringToIndex:10];
}

// MARK: - Language

+ (NSString *)getMyLanguage
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
    return [languages objectAtIndex:0];
}

// MARK: - Text fields

+ (void)setPlaceholderForTextField:(UITextField *)txtFld withText:(NSString *)text withColor:(UIColor *)color andFont:(UIFont *)font
{
    if ([font isEmpty]) {
        NSLog(@"Placeholder font is empty \n system font with size of 13 substituted");
        font = [UIFont systemFontOfSize:13.0f];
    }
    txtFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName: color, NSFontAttributeName : font}];
}

// MARK: - Navigation Bar

+ (UIBarButtonItem *)barButtonItemWithImageName:(NSString *)imageName forTarget:(id)target andselector:(SEL)selector
{
    UIImage *image = [UIImage imageNamed:imageName];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0.0, 0.0, kRightBarButtons, kRightBarButtons);
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return barButtonItem;
}

/*************************
 Call this method only in AppDelegate for having general NavigationBar
 *************************/
+ (void)setupNavigationBarWithBackgroundColor:(UIColor *)bgColor withFontName:(UIFont *)font andfontColor:(UIColor *)fontColor
{
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleDefault];
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    
    // FIXME dellet comments if you have text title for your page
    // Set txt font , dont size and color
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName: fontColor,
                                                           NSFontAttributeName:font
                                                           }];
    // Set Background color
    UIImage *image = [SFImage imageWithColor:bgColor];
    [[UINavigationBar appearance] setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

/*************************
 Call this method only in AppDelegate for having general NavigationBarButtonItem
 *************************/

+ (void)setupNavigationBarButtonItemWithColor:(UIColor *)color withFontName:(UIFont *)font
{
    NSDictionary *attributiNavigationItem = @{NSForegroundColorAttributeName:color, NSFontAttributeName:font};
    [[UIBarButtonItem appearance] setTitleTextAttributes:attributiNavigationItem forState:UIControlStateNormal];
}

/*************************
 Call this method When you want to have a custom navigation bar for only one page
 *************************/

+ (void)customNavigationController:(UINavigationController *)navigationBar forTarget:(id)target setBackgroundColor:(UIColor *)bgColor withPageTitle:(NSString *)title WithFontName:(UIFont *)font andfontColor:(UIColor *)fontColor
{
    [target setNeedsStatusBarAppearanceUpdate];
    [navigationBar setNavigationBarHidden:NO];
    UIImage *image = [SFImage imageWithColor:bgColor];
    [navigationBar.navigationBar setTranslucent:NO];
    [navigationBar.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [navigationBar.navigationBar setBarStyle:UIBarStyleDefault];
    [navigationBar.navigationBar setShadowImage:[UIImage new]];
    [navigationBar.navigationBar setTitleTextAttributes:@{
                                                          NSForegroundColorAttributeName: fontColor,
                                                          NSFontAttributeName:font
                                                          }];
    navigationBar.navigationBar.topItem.title = title;
}

/*************************
 Call this method When you want to have a Image As a title for navigation bar
 *************************/
+ (void)setImageForNavigationItem:(UINavigationItem *)navItem forTarget:(id)target
{
    [target setNeedsStatusBarAppearanceUpdate];
    UIImageView *imgLogo = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, kBarButtonSide)];
    [imgLogo setBackgroundColor:kCClear];
    [imgLogo setImage:[UIImage imageNamed:@"navLogo"]];
    [imgLogo setContentMode:UIViewContentModeScaleAspectFit];
    navItem.titleView = imgLogo;
}

// MARK: - Segments

+ (void)setSegmentFont:(UIFont *)font andColor:(UIColor *)color forState:(UIControlState)state
{
    [[UISegmentedControl appearance] setTitleTextAttributes:@{
                                                              NSFontAttributeName:font,
                                                              NSForegroundColorAttributeName : color
                                                              }
                                                   forState:state];
}

// MARK: - STRING

/// Find range of NUMBERS in a string and return an ARRAY of range.location & range.lenght
+ (NSArray *)findRangeOfNumbrsInStringWithOriginalString:(NSString *)originalString
{
    NSMutableArray *arr = [NSMutableArray array];
    
    // STEP ONE : Chcek if string contain a number or not
    NSScanner *scanner = [NSScanner scannerWithString:originalString];
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    NSString *newStrFromOrginalStr;
    while ([scanner isAtEnd] == NO) {
        NSString *numbString;
        if ([scanner scanCharactersFromSet:numbers intoString:&numbString]) {
            
            // STEP TWO : Get number range
            NSRange range ;
            // FIXME :
            /// This is temprory solution : To avoid read, readed number have to change the number in original string into something else ... (#)
            if ([newStrFromOrginalStr isNotEmpty]) {
                range = [newStrFromOrginalStr rangeOfString:numbString];
            }
            else {
                range = [originalString rangeOfString:numbString];
            }
            
            if (range.location == NSNotFound) {
                NSLog(@"NO MATCH");
            }
            else {
                // NSLog(@"Found the range of the NUMBER at (%lu, %lu)", (unsigned long)range.location, range.location + range.length);
                
                NSRange finalRange =  NSMakeRange(range.location, range.location + range.length);
                
                /// This is temprory solution : To avoid read, readed number have to change the number in original string into something else ... (#)
                if ([newStrFromOrginalStr isNotEmpty]) {
                    newStrFromOrginalStr = [newStrFromOrginalStr stringByReplacingCharactersInRange: NSMakeRange(range.location ,range.length) withString:@"#"];
                }
                else {
                    newStrFromOrginalStr = [originalString stringByReplacingCharactersInRange: NSMakeRange(range.location ,range.length) withString:@"#"];
                }
                
                // STEP TREE : ADD RANGE TO ARRAY
                [arr addObject:[NSValue valueWithRange:finalRange]];
            }
        }
        else {
            [scanner setScanLocation:([scanner scanLocation] + 1)];
        }
        
    }
    return  arr;
}

// MARK: - CAMERA & SCREEN

+ (BOOL)hasCamera
{
    BOOL bl = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    return bl;
}

+ (void)setScreenAlwaysOn:(BOOL)value
{
    [[UIApplication sharedApplication] setIdleTimerDisabled:value];
    if (value == YES) {
        NSLog(@"Screen Always ON: YES");
    } else NSLog(@"Screen Always ON: NO");
}

// MARK: - Tab bar controller

/// Use this method to hide tab bar controller with animation
+ (void)setTabBarController:(UITabBarController *)taBarController hidden:(BOOL)tabBarHidden animated:(BOOL)animated
{
    
    CGFloat offset = tabBarHidden ? taBarController.tabBar.frame.size.height : - taBarController.tabBar.frame.size.height;
    
    [UIView animateWithDuration:animated ? 1.5 : 0.0 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseIn|UIViewAnimationOptionLayoutSubviews animations:^{
        
        taBarController.tabBar.center = CGPointMake(taBarController.tabBar.center.x, taBarController.tabBar.center.y + offset);
        if (tabBarHidden) {
            // Hide TabBar
            [taBarController.tabBar setHidden:YES];
        }
        else {
            // Show TabBar
            [taBarController.tabBar setHidden:NO];
        }
    } completion:^(BOOL finished) {
        // DO STH IF NEEDED
    }];
}

+ (void)setTabBarWithShadowImage:(UIImage *)imgShadow withBackgroundImage:(UIImage *)imgBackground withBackgroundColor:(UIColor *)bgColor withBarTintColor:(UIColor *)barTintColor withTintColor:(UIColor *)tintColor
{
    // TabBar
    [[UITabBar appearance] setShadowImage:imgShadow];
    [[UITabBar appearance] setBackgroundColor:bgColor];
    [[UITabBar appearance] setBackgroundImage:imgBackground];
    [[UITabBar appearance] setBarTintColor:barTintColor];
    [[UITabBar appearance] setTintColor:tintColor];
}

+ (void)setTabBarItemColor:(UIColor *)color forState:(UIControlState)state
{
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName :color} forState: state];
}

// MARK: - Phone call

/// Use this method to call to a number
+ (void)callToNumber:(nonnull NSString *)number
{
    if ([number isNotEmpty]) {
        
        NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",number]];
        
        if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
            [[UIApplication sharedApplication] openURL:phoneUrl];
        }
    }
}

// MARK: - Open web page (SAFARI)

+ (void)openWebPage:(nonnull NSString *)strURL
{
    if ([strURL isEmptyString]) return;
 
    NSString *str = strURL;
    
    if (![strURL contains:@"http://"]) {
        str = [NSString stringWithFormat:@"http://%@",strURL];
    }
    NSURL *URL = [NSURL URLWithString:str];
    
    if ([[UIApplication sharedApplication] canOpenURL:URL]) {
        [[UIApplication sharedApplication] openURL:URL];
    }
}
@end
