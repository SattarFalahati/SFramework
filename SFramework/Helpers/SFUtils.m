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

+ (id)sharedManager
{
    static id sharedManager;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

#pragma mark - Arrays

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

#pragma mark - Buttons

+ (void)roundetBottomCornerView:(UIView *)view onCorner:(UIRectCorner)rectCorner andRadius:(CGFloat)radius andBackgroundColor:(UIColor *)bColor
{
    if(bColor){
        [view setBackgroundColor:bColor];
    }
    UIBezierPath *maskPathEditPP = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayerEditPP = [[CAShapeLayer alloc] init];
    maskLayerEditPP.frame = view.bounds;
    maskLayerEditPP.path = maskPathEditPP.CGPath;
    view.layer.mask = maskLayerEditPP;
}

+ (void)setTextButton:(UIButton *)btn andText:(NSString *)text forState:(UIControlState)state
{
    [btn setTitle:text forState:state];
}

+ (void)setImageButton:(UIButton *)btn andImage:(UIImage *)btnImage forState:(UIControlState)state
{
    [btn setImage:btnImage forState:state];
}

+ (void)setImageBackgroundButton:(UIButton *)btn andImage:(UIImage *)btnImage forState:(UIControlState)state
{
    [btn setBackgroundImage:btnImage forState:state];
}

+ (void)setTextColorButton:(UIButton *)btn andColor:(UIColor *)textColor forState:(UIControlState)state
{
    [btn setTitleColor:textColor forState:state];
}


+ (void)setImageButtonWithoutText:(UIButton *)btn andImage:(UIImage *)btnImage transparent:(BOOL)transparent forState:(UIControlState)state
{
    [self setTextButton:btn andText:@"" forState:state];
    btn.contentMode = UIViewContentModeScaleAspectFit;
    btn.imageEdgeInsets = UIEdgeInsetsMake(3, 3, 3, 3);
    [self setImageButton:btn andImage:btnImage forState:state];
    if(transparent){
        [btn setBackgroundColor:CClear];
    }
}

#pragma mark - Text

+(CGSize)heightText:(NSString *)text sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
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

#pragma mark - Unic ID

+(NSString *)UUID
{
    CFUUIDRef newUniqueID = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef newUniqueIDString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueID);
    NSString *guid = (__bridge NSString *)newUniqueIDString;
    CFRelease(newUniqueIDString);
    CFRelease(newUniqueID);
    return([guid lowercaseString]);
}

+(NSString *)UUIDforEmail
{
    NSString *uuid = [[self UUID] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return [uuid substringToIndex:10];
}

#pragma mark - Language

+(NSString *) getMyLanguage
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
    return [languages objectAtIndex:0];
}

#pragma mark - Images

+(UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+(UIImage *)scaleToWidth:(CGFloat)width andOrginalImage:(UIImage *)orginalImage
{
    UIImage *scaledImage = orginalImage;
    if (scaledImage.size.width != width) {
        CGFloat height = floorf(scaledImage.size.height * (width / scaledImage.size.width));
        CGSize size = CGSizeMake(width, height);
        
        // Create an image context
        UIGraphicsBeginImageContext(size);
        
        // Draw the scaled image
        [scaledImage drawInRect:CGRectMake(0.0f, 0.0f, size.width, size.height)];
        
        // Create a new image from context
        scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        
        // Pop the current context from the stack
        UIGraphicsEndImageContext();
    }
    // Return the new scaled image
    return scaledImage;
}

#pragma mark - Text fields

+(void)setPlaceholderForTextField:(UITextField *)txtFld withText:(NSString *)text withColor:(UIColor *)color andFont:(UIFont *)font{
    txtFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName: color, NSFontAttributeName : font}];
}

#pragma mark - Navigation Bar

+(UIBarButtonItem *)barButtonItemWithImageName:(NSString *)imageName forTarget:(id)target andselector:(SEL)selector
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
+(void)setupNavigationBarWithBackgroundColor:(UIColor *)bgColor WithFontName:(UIFont *)font andfontColor:(UIColor *)fontColor
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
    UIImage *image = [self imageWithColor:bgColor];
    [[UINavigationBar appearance] setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

/*************************
 Call this method When you want to have a custom navigation bar for only one page
 *************************/

+(void)navigationController:(UINavigationController *)navigationBar forTarget:(id)target setBackgroundColor:(UIColor *)bgColor withPageTitle:(NSString *)title WithFontName:(UIFont *)font andfontColor:(UIColor *)fontColor
{
    [target setNeedsStatusBarAppearanceUpdate];
    [navigationBar setNavigationBarHidden:NO];
    UIImage *image = [self imageWithColor:bgColor];
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
    [imgLogo setBackgroundColor:CClear];
    [imgLogo setImage:[UIImage imageNamed:@"navLogo"]];
    [imgLogo setContentMode:UIViewContentModeScaleAspectFit];
    navItem.titleView = imgLogo;
}

#pragma mark - Segments

+ (void)setSegmentFont:(UIFont *)font andColor:(UIColor *)color forState:(UIControlState)state
{
    [[UISegmentedControl appearance] setTitleTextAttributes:@{
                                                              NSFontAttributeName:font,
                                                              NSForegroundColorAttributeName : color
                                                              }
                                                   forState:state];
}

#pragma mark - STRING

/// Find range of NUMBERS in a string and return an ARRAY of range.location & range.lenght
+ (NSArray *)findRangeNumbrsInStringWithOriginalString:(NSString *)originalString
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

#pragma mark - NSDATE

+ (NSDate *)getDateFromString:(NSString *)dateString
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormat dateFromString:dateString];
    NSTimeInterval timeZoneSeconds = [[NSTimeZone localTimeZone] secondsFromGMT];
    NSDate *dateInLocalTimezone = [date dateByAddingTimeInterval:timeZoneSeconds];
    return dateInLocalTimezone;
}

+ (NSString *)getDateString:(NSDate *)date andDateFormatter:(NSString *)dateForm
{
    if(!date){
        return nil;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateForm];
    return [formatter stringFromDate:date];
}

+ (NSDate *)getNowDate
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    NSDate *date = [dateFormat dateFromString:dateString];
    NSTimeInterval timeZoneSeconds = [[NSTimeZone localTimeZone] secondsFromGMT];
    NSDate *dateInLocalTimezone = [date dateByAddingTimeInterval:timeZoneSeconds];
    return dateInLocalTimezone;
}

+ (long long)getNowDateInMillisecondsFrom1970
{
    long long milliseconds = (long long)([[SFUtils getNowDate] timeIntervalSince1970] * 1000.0);
    return milliseconds;
}

+ (long long)getDateInMillisecondsFrom1970:(NSDate *)date
{
    long long milliseconds = (long long)([date timeIntervalSince1970] * 1000.0);
    return milliseconds;
}

+ (NSDate *)getNowDateWithFormat:(NSString *)format
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:format];
    NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    NSDate *date = [dateFormat dateFromString:dateString];
    NSTimeInterval timeZoneSeconds = [[NSTimeZone localTimeZone] secondsFromGMT];
    NSDate *dateInLocalTimezone = [date dateByAddingTimeInterval:timeZoneSeconds];
    return dateInLocalTimezone;
}

+ (NSDate *)getDate:(NSDate *)fromDate addDays:(NSUInteger)days addHours:(NSUInteger)hours
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = days;
    dateComponents.hour = hours;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *previousDate = [calendar dateByAddingComponents:dateComponents
                                                     toDate:fromDate
                                                    options:0];
    return previousDate;
}

+ (BOOL)date:(NSDate *)date is:(BOOL)before otherDate:(NSDate *)otherDate
{
    if(before && ([date compare:otherDate] == NSOrderedAscending)){
        return YES;
    }
    if (!before && ([date compare:otherDate] == NSOrderedDescending)){
        return YES;
    }
    return NO;
}

+ (NSDate *)returnDayForMonth:(NSInteger)month year:(NSInteger)year day:(NSInteger)day fromDate:(NSDate *)date
{
    
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:date];
    
    [components setDay:day];
    [components setMonth:month];
    [components setYear:year];
    
    return [CURRENT_CALENDAR dateFromComponents:components];
}

#pragma mark - CAMERA & SCREEN

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

#pragma mark - progress bar

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

#pragma mark - Border && Radius

+ (void)roundCorners:(UIRectCorner)corners onView:(UIView *)view radius:(CGFloat)radius withBorder:(BOOL)border andBorderColor:(UIColor *)color
{
    CGRect bounds = view.bounds;
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds
                                                     byRoundingCorners:corners
                                                           cornerRadii:CGSizeMake(radius, radius)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = bounds;
    shapeLayer.path = bezierPath.CGPath;
    
    view.layer.mask = shapeLayer;
    
    // Add Border
    if (border == YES) {
        
        CAShapeLayer *shapeLayerForBorder = [CAShapeLayer layer];
        shapeLayerForBorder.frame = CGRectZero;
        shapeLayerForBorder.path = bezierPath.CGPath;
        shapeLayerForBorder.strokeColor = [UIColor redColor].CGColor;
        shapeLayerForBorder.fillColor = nil;
        
        // Check and see if border already exist , delete it then recreate
        for (CAShapeLayer *layer in view.layer.sublayers) {
            if (CGSizeEqualToSize(layer.frame.size,shapeLayerForBorder.frame.size)) {
                [layer removeFromSuperlayer];
            }
        }
        
        [view.layer addSublayer:shapeLayerForBorder];
    }
    
}

+ (void)roundTopCornersRadius:(CGFloat)radius onView:(UIView *)view withBorder:(BOOL)border andBorderColor:(UIColor *)color
{
    [SFUtils roundCorners:(UIRectCornerTopLeft|UIRectCornerTopRight) onView:view radius:radius withBorder:border andBorderColor:color];
}

+ (void)roundBottomCornersRadius:(CGFloat)radius onView:(UIView *)view withBorder:(BOOL)border andBorderColor:(UIColor *)color
{
    [SFUtils roundCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight) onView:view radius:radius withBorder:border andBorderColor:color];
}

+ (void)addBorderOnView:(UIView *)view withRadius:(CGFloat)radius andBorderColor:(UIColor *)color andBorderWidth:(CGFloat)width
{
    view.layer.cornerRadius = radius;
    view.layer.masksToBounds = YES;
    view.layer.borderWidth = width;
    view.layer.borderColor = (__bridge CGColorRef _Nullable)(color);
}




@end
