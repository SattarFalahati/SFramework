//
//  SFUtils.h
//
//  Copyright (c) 2016 Sattar Falahati (SFramework). All rights reserved.
//

#import "SFUtils.h"

#define kBarButtonSide          44.0 // For navigation bar (normally its 44)
#define kRightBarButtons        44.0 // For navigation bar (normally its 44)


@interface SFUtils ()
@end

@implementation SFUtils

+ (id)sharedManager{
    static id sharedManager;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

#pragma mark - Objects

+ (BOOL)isEmpty:(NSObject *)obj
{
    return ![self isNotEmpty:obj];
}

//+(BOOL)isNotEmpty:(NSObject *)obj
//{
//    if(obj && ![obj isKindOfClass:[NSNull class]] && (NSNull *)obj!=[NSNull null]){
//        if([obj isKindOfClass:[NSString class]]){
//            return ![(NSString *)obj isEmpty];
//        }
//        if([obj isKindOfClass:[NSArray class]]){
//            NSArray *arr = (NSArray *)obj;
//            if(arr && [arr count]>0){
//                return YES;
//            }
//        }
//        if([obj isKindOfClass:[NSMutableArray class]]){
//            NSMutableArray *arr = (NSMutableArray *)obj;
//            if(arr && [arr count]>0){
//                return YES;
//            }
//        }
//        if([obj isKindOfClass:[NSDictionary class]]){
//            NSDictionary *dic = (NSDictionary *)obj;
//            if(dic && [dic count]>0 && [[dic allKeys] count]>0){
//                return YES;
//            }
//        }
//        if([obj isKindOfClass:[NSMutableDictionary class]]){
//            NSMutableDictionary *dic = (NSMutableDictionary *)obj;
//            if(dic && [dic count]>0 && [[dic allKeys] count]>0){
//                return YES;
//            }
//        }
//        if([obj isKindOfClass:[NSURL class]]){
//            NSURL *url = (NSURL *)obj;
//            if(url && [url absoluteString] && ![[url absoluteString] isEmpty]){
//                return YES;
//            }
//        }
//        if([obj isKindOfClass:[NSNumber class]]){
//            NSNumber *num = (NSNumber *)obj;
//            if(num){
//                return YES;
//            }
//        }
//        if([obj isKindOfClass:[NSData class]]){
//            NSData *data = (NSData *)obj;
//            if(data && [data length]>0){
//                return YES;
//            }
//        }
//    }
//    return NO;
//}

#pragma mark - Arrays

+(NSMutableArray *) generateRandomArray:(int) max
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

+(void)roundetBottomCornerView:(UIView *)view onCorner:(UIRectCorner)rectCorner andRadius:(CGFloat)radius andBackgroundColor:(UIColor *)bColor
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

+(void)setTextButton:(UIButton *)btn andText:(NSString *)text forState:(UIControlState)state
{
    [btn setTitle:text forState:state];
}

+(void)setImageButton:(UIButton *)btn andImage:(UIImage *)btnImage forState:(UIControlState)state
{
    [btn setImage:btnImage forState:state];
}

+(void)setImageBackgroundButton:(UIButton *)btn andImage:(UIImage *)btnImage forState:(UIControlState)state
{
    [btn setBackgroundImage:btnImage forState:state];
}

+ (void)setTextColorButton:(UIButton *)btn andColor:(UIColor *)textColor forState:(UIControlState)state
{
    [btn setTitleColor:textColor forState:state];
}


+(void)setImageButtonWithoutText:(UIButton *)btn andImage:(UIImage *)btnImage transparent:(BOOL)transparent forState:(UIControlState)state
{
    [self setTextButton:btn andText:@"" forState:state];
    btn.contentMode = UIViewContentModeScaleAspectFit;
    btn.imageEdgeInsets = UIEdgeInsetsMake(3, 3, 3, 3);
    [self setImageButton:btn andImage:btnImage forState:state];
    if(transparent){
//        [btn setBackgroundColor:clearC];
    }
}

#pragma mark - Network

//+(BOOL)isNetworkStatusActive
//{
//    if([AFNetworkReachabilityManager sharedManager].reachable){
//        return YES;
//    }
//    if([self NetworkStatus] == YES){
//        return YES;
//    }
//    return [self isHostReachable:ReachabilityURL];
//}

+ (BOOL)isReachableWithoutRequiringConnection:(SCNetworkReachabilityFlags)flags
{
    BOOL isReachable = flags & kSCNetworkReachabilityFlagsReachable;
    BOOL noConnectionRequired = !(flags & kSCNetworkReachabilityFlagsConnectionRequired);
    if ((flags & kSCNetworkReachabilityFlagsIsWWAN)) {
        noConnectionRequired = YES;
    }
    return (isReachable && noConnectionRequired) ? YES : NO;
}

+ (BOOL)isHostReachable:(NSString *)host
{
    if (!host || ![host length]) {
        return NO;
    }
    SCNetworkReachabilityFlags flags;
    SCNetworkReachabilityRef reachability =  SCNetworkReachabilityCreateWithName(NULL, [host UTF8String]);
    BOOL gotFlags = SCNetworkReachabilityGetFlags(reachability, &flags);
    CFRelease(reachability);
    if (!gotFlags) {
        return NO;
    }
    return [self isReachableWithoutRequiringConnection:flags];
}

+(BOOL)NetworkStatus
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr*)&zeroAddress);
    if(reachability != NULL) {
        SCNetworkReachabilityFlags flags;
        if (SCNetworkReachabilityGetFlags(reachability, &flags)) {
            if ((flags & kSCNetworkReachabilityFlagsReachable) == 0){
                return NO;
            }
            if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0){
                return YES;
            }
            if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||
                 (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0)){
                if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0){
                    return YES;
                }
            }
            if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN){
                return YES;
            }
        }
    }
    return NO;
}

//+ (void)getNetworkConnectionStatuse
//{
//    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
//        switch (status) {
//            case AFNetworkReachabilityStatusUnknown:
//                NSLog(@"The reachability status is Unknown");
//                // Do sth
//                break;
//            case AFNetworkReachabilityStatusNotReachable:
//                NSLog(@"The reachability status is not reachable");
//                // Do sth
//                break;
//            case AFNetworkReachabilityStatusReachableViaWWAN:
//                NSLog(@"The reachability status is reachable via WWAN");
//                // Do sth
//                break;
//            case AFNetworkReachabilityStatusReachableViaWiFi:
//                NSLog(@"The reachability status is reachable via WiFi");
//                // Do sth
//                break;
//            default:
//                NSLog(@"The reachability status is not found");
//                // Do sth
//                break;
//        }
//    }];
//}

#pragma mark - Text

//+(CGSize)heightText:(NSString *)text sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
//{
//    if(IS_IOS7_AND_UP){
//        NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys: font, NSFontAttributeName, nil];
//        CGRect frame = [text boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:attributesDictionary context:nil];
//        return frame.size;
//    }else{
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wdeprecated-declarations"
//        return [text sizeWithFont:font constrainedToSize:size];
//#pragma clang diagnostic pop
//    }
//}

#pragma mark - Table

+(void)refreshWithTableView:(UITableView *)table
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView transitionWithView:table
                          duration:0.35f
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^(void) {
                            [table reloadData];
                        } completion:NULL];
    });
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
//    [target setNeedsStatusBarAppearanceUpdate];
//    UIImageView *imgLogo = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, kBarButtonSide)];
//    [imgLogo setBackgroundColor:clearC];
//    [imgLogo setImage:[UIImage imageNamed:@"navLogo"]];
//    [imgLogo setContentMode:UIViewContentModeScaleAspectFit];
//    navItem.titleView = imgLogo;
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

#pragma mark - Color with HEX

+ (UIColor *)colorWithHexString:(NSString *)HexSting
{
    NSString *colorString = [[HexSting stringByReplacingOccurrencesOfString:@"#" withString:@""] uppercaseString];
    
    CGFloat alpha = 1.0;
    CGFloat red = 0.0;
    CGFloat blue = 0.0;
    CGFloat green = 0.0;
    
    switch ([colorString length]) {
        case 0:
            // @""
            break;
            
        case 3:
            // #RGB
            alpha = 1.0;
            red   = [self colorComponentFrom:colorString start:0 length:1];
            green = [self colorComponentFrom:colorString start:1 length:1];
            blue  = [self colorComponentFrom:colorString start:2 length:1];
            break;
            
        case 4:
            // #ARGB
            alpha = [self colorComponentFrom:colorString start:0 length:1];
            red   = [self colorComponentFrom:colorString start:1 length:1];
            green = [self colorComponentFrom:colorString start:2 length:1];
            blue  = [self colorComponentFrom:colorString start:3 length:1];
            break;
            
        case 6:
            // #RRGGBB
            alpha = 1.0;
            red   = [self colorComponentFrom:colorString start:0 length:2];
            green = [self colorComponentFrom:colorString start:2 length:2];
            blue  = [self colorComponentFrom:colorString start:4 length:2];
            break;
            
        case 8:
            // #AARRGGBB
            alpha = [self colorComponentFrom:colorString start:0 length:2];
            red   = [self colorComponentFrom:colorString start:2 length:2];
            green = [self colorComponentFrom:colorString start:4 length:2];
            blue  = [self colorComponentFrom:colorString start:6 length:2];
            break;
            
        default:
            NSLog(@"stringaHex non valida: %@", HexSting);
            break;
    }
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (CGFloat)colorComponentFrom:(NSString *)string start:(NSUInteger)start length:(NSUInteger)length
{
    NSString *substring = [string substringWithRange:NSMakeRange(start, length)];
    NSString *fullHex = (length == 2) ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString:fullHex] scanHexInt:&hexComponent];
    return hexComponent / 255.0;
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
            if ([self isNotEmpty:newStrFromOrginalStr]) {
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
                if ([self isNotEmpty:newStrFromOrginalStr]) {
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

+ (void)showProgressHUDWithMessage:(NSString *)message
{
    // SetUp Message
    if ([self isEmpty:message])
        message = @"";
    
    // SetUp Progress bar
//    MBProgressHUD *progress = [MBProgressHUD showHUDAddedTo:WINDOW animated:YES];
//    
//    [progress.label setText:message];
//    progress.animationType = MBProgressHUDAnimationZoom;
//    progress.mode = MBProgressHUDModeIndeterminate;
//    [progress showAnimated:YES];
}

+ (void)stopProgressHUD
{
//    [MBProgressHUD hideHUDForView:WINDOW animated:YES];
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


@end
