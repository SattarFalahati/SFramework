//
//  SFDefine.h
//
//  Copyright (c) 2016 Sattar Falahati (SFramework). All rights reserved.
//

#define kBarButtonSide          44.0 // For navigation bar (normally its 44)
#define kRightBarButtons        44.0 // For navigation bar (normally its 44)

#define GAI_EVENT(category,action,label)   dispatch_async(dispatch_get_main_queue(),^{ [NOTIFICATION_CENTER postNotificationName:kAnalytics_EVENT object:@{kGAI_CATEGORY:category,kGAI_ACTION:action, kGAI_LABEL:label}]; })

#define GAI_CRASH(error)              dispatch_async(dispatch_get_main_queue(),^{ [NOTIFICATION_CENTER postNotificationName:kAnalytics_CRASH object:@{kGAI_DESCRIPTION:[NSString stringWithFormat:@"error: %@",error.description]}]; })

#define ReachabilityURL                         @"www.google.it"

#if __has_feature(objc_arc)
#define MB_AUTORELEASE(exp) exp
#define MB_RELEASE(exp) exp
#define MB_RETAIN(exp) exp
#else
#define MB_AUTORELEASE(exp) [exp autorelease]
#define MB_RELEASE(exp) [exp release]
#define MB_RETAIN(exp) [exp retain]
#endif

#define IS_WIDESCREEN                                       (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)568) < DBL_EPSILON)
#define IS_IOS7_AND_UP                                      ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
#define IS_IOS8_AND_UP                                      ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IOS_7_OR_LATER                                      [[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending
#define IOS_5_OR_LATER                                      [[[UIDevice currentDevice] systemVersion] compare:@"5.0" options:NSNumericSearch] != NSOrderedAscending
#define IOS_4_OR_LATER                                      [[[UIDevice currentDevice] systemVersion] compare:@"4.0" options:NSNumericSearch] != NSOrderedAscending
#define ONLY_IF_AT_LEAST_IOS_4(action)                      if ([[[UIDevice currentDevice] systemVersion] compare:@"4.0" options:NSNumericSearch] != NSOrderedAscending) { action; }
#define SYSTEM_VERSION_EQUAL_TO(v)                          ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)                      ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)          ([[[UIDevice currentDevice] systemVersion] compare:v    options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)             ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
#define IS_MULTITASKING_SUPPORTED                           ([[UIDevice currentDevice] respondsToSelector:@selector(isMultitaskingSupported)] && [[UIDevice currentDevice] isMultitaskingSupported])
#define SYSTEM_VERSION                                      [[UIDevice currentDevice] systemVersion]

#define IS_IPAD                                             (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE                                           (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA                                           ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH                                        ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT                                       ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH                                   (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH                                   (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS                                 (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5                                         (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6                                         (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P                                        (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define WINDOW                                              [[[UIApplication sharedApplication] delegate] window]
#define WINDOW_VIEW                                         [[[UIApplication sharedApplication] windows] lastObject]

#define CURRENT_CALENDAR                                    [NSCalendar currentCalendar]
#define DATE_COMPONENTS                                     (NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfYear |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitWeekOfMonth)

#define NOTIFICATION_CENTER                                 [NSNotificationCenter defaultCenter]
#define SHARED_APPLICATION                                  [UIApplication sharedApplication]
#define DEFAULT_MANAGER                                     [NSFileManager defaultManager]
#define BUNDLE                                              [NSBundle mainBundle]
#define CURRENT_LOCAL                                       [NSLocale currentLocale]
#define MAIN_SCREEN                                         [UIScreen mainScreen]
#define BUNDLE                                              [NSBundle mainBundle]
#define BUNDLE_PATH                                         [[NSBundle mainBundle] bundlePath]
#define SCREEN_BOUNDS                                       [[UIScreen mainScreen] bounds]
#define TIME_COMPONENTS                                     NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit
#define CURRENT_LOCAL_WITH_OBJECT(param)                    [[NSLocale currentLocale] objectForKey:(param)]
#define APP_ID                                              [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]
#define BUNDLE_VERSION                                      [BUNDLE objectForInfoDictionaryKey:@"CFBundleVersion"]
#define APP_VERSION                                         [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define APP_BUILD                                           [[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define APP_NAME                                            [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"]
#define APP_DELEGATE(type)                                  ((type *)[[UIApplication sharedApplication] delegate])
#define NSAPP_DELEGATE(type)                                ((type *)[[NSApplication sharedApplication] delegate])
#define NSSHARE_APP                                         [NSApplication sharedApplication]
#define OpenURL(urlString)                                  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]]
#define ObserveValue(x, y, z)                               [(z) addObserver:y forKeyPath:x options:NSKeyValueObservingOptionOld context:nil];
#define MY_LANGUAGE                                         [[[[NSUserDefaults standardUserDefaults]objectForKey:@"AppleLanguages"]objectAtIndex:0] uppercaseString]

#define SET_NETWORK_ACTIVITY_INDICATOR(x)                   [UIApplication sharedApplication].networkActivityIndicatorVisible = x
#define SHOW_NETWORK_ACTIVITY_INDICATOR()                   [UIApplication sharedApplication].networkActivityIndicatorVisible = YES
#define HIDE_NETWORK_ACTIVITY_INDICATOR()                   [UIApplication sharedApplication].networkActivityIndicatorVisible = NO

#define SFLogRect(rect)                                     NSLog(@"%@", NSStringFromCGRect(rect))
#define SFLogSize(size)                                     NSLog(@"%@", NSStringFromCGSize(size))
#define SFLogPoint(point)                                   NSLog(@"%@", NSStringFromCGPoint(point))

#define NUM_INT(int)                                        [NSNumber numberWithInt:int]
#define NUM_FLOAT(float)                                    [NSNumber numberWithFloat:float]
#define NUM_BOOL(bool)                                      [NSNumber numberWithBool:bool]

#define CENTER_VERTICALLY(parent,child)                     floor((parent.frame.size.height - child.frame.size.height) / 2)
#define CENTER_HORIZONTALLY(parent,child)                   floor((parent.frame.size.width - child.frame.size.width) / 2)
#define CENTER_IN_PARENT(parent,childWidth,childHeight)     CGPointMake(floor((parent.frame.size.width - childWidth) / 2),floor((parent.frame.size.height - childHeight) / 2))
#define CENTER_IN_PARENT_X(parent,childWidth)               floor((parent.frame.size.width - childWidth) / 2)
#define CENTER_IN_PARENT_Y(parent,childHeight)              floor((parent.frame.size.height - childHeight) / 2)
#define WIDTH(view)                                         view.frame.size.width
#define HEIGHT(view)                                        view.frame.size.height
#define X(view)                                             view.frame.origin.x
#define Y(view)                                             view.frame.origin.y
#define LEFT(view)                                          view.frame.origin.x
#define TOP(view)                                           view.frame.origin.y
#define BOTTOM(view)                                        (view.frame.origin.y + view.frame.size.height)
#define RIGHT(view)                                         (view.frame.origin.x + view.frame.size.width)
#define VIEW_WIDTH(view)                                    view.frame.size.width
#define VIEW_HEIGHT(view)                                   view.frame.size.height
#define VIEW_X(view)                                        view.frame.origin.x
#define VIEW_Y(view)                                        view.frame.origin.y
#define VIEW_CENTER_X(view)                                 view.center.x
#define VIEW_CENTER_Y(view)                                 view.center.y
#define NavBar                                              self.navigationController.navigationBar
#define TabBar                                              self.tabBarController.tabBar
#define NavBarHeight                                        self.navigationController.navigationBar.bounds.size.height
#define TabBarHeight                                        self.tabBarController.tabBar.bounds.size.height
#define CGRectCenter(rect)                                  CGPointMake(NSOriginX(rect) + NSWidth(rect) / 2, NSOriginY(rect) + NSHeight(rect) / 2)
#define CGRectModify(rect,dx,dy,dw,dh)                      CGRectMake(rect.origin.x + dx, rect.origin.y + dy, rect.size.width + dw, rect.size.height + dh)



#define USER_DEFAULTS                                       [NSUserDefaults standardUserDefaults]
#define USER_DEFAULTS_OBJECT(param)                         [[NSUserDefaults standardUserDefaults] objectForKey:(param)]
#define USER_DEFAULTS_BOOL(param)                           [[NSUserDefaults standardUserDefaults] boolForKey:(param)]
#define USER_DEFAULTS_INTEGER(param)                        [[NSUserDefaults standardUserDefaults] integerForKey:(param)]
#define USER_DEFAULTS_REMOVE(param)                         [[NSUserDefaults standardUserDefaults] removeObjectForKey:(param)]
#define USER_DEFAULTS_SetValue(x, y)                        [[NSUserDefaults standardUserDefaults] setValue:(y) forKey:(x)]
#define USER_DEFAULTS_SetBool(x, y)                         [[NSUserDefaults standardUserDefaults] setBool:(y) forKey:(x)]
#define USER_DEFAULTS_SetInteger(x, y)                      [[NSUserDefaults standardUserDefaults] setInteger:(y) forKey:(x)]
#define USER_DEFAULTS_ObserveValue(x, y)                    [[NSUserDefaults standardUserDefaults] addObserver:y forKeyPath:x options:NSKeyValueObservingOptionOld context:nil];
#define USER_DEFAULTS_Sync(ignored)                         [[NSUserDefaults standardUserDefaults] synchronize]


#define INDEX_PATH(a,b)                                     [NSIndexPath indexPathWithIndexes:(NSUInteger[]){a,b} length:2]


#define IDARRAY(...)                                        (id []){ __VA_ARGS__ }
#define IDCOUNT(...)                                        (sizeof(IDARRAY(__VA_ARGS__)) / sizeof(id))
#define ARRAY(...)                                          [NSArray arrayWithObjects: IDARRAY(__VA_ARGS__) count: IDCOUNT(__VA_ARGS__)]
#define DICT(...)                                           DictionaryWithIDArray(IDARRAY(__VA_ARGS__), IDCOUNT(__VA_ARGS__) / 2)


#define POINTERIZE(x)                                       ((__typeof__(x) []){ x })
#define NSVALUE(x)                                          [NSValue valueWithBytes: POINTERIZE(x) objCType: @encode(__typeof__(x))]
#define BLOCK_SAFE_RUN(block, ...)                          block ? block(__VA_ARGS__) : nil


#define START_TIMER(ignored)                                 NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
#define END_TIMER(msg)                                       NSTimeInterval stop = [NSDate timeIntervalSinceReferenceDate]; NSLog(@"%@", [NSString stringWithFormat:@"%@ Time = %f", msg, stop-start]);


#define DEG_TO_RAD(x)                                       (M_PI * x / 180.0)

#define IMAGE(imageName)                                    (UIImage *)[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:IMAGE_TYPE_PNG]]
#define IMAGE_TYPE_PNG                                      @"png"

#define RAND_FROM_TO(min, max)                              (min + arc4random_uniform(max - min + 1))

#define Sysop                                               [[UIDevice currentDevice] systemVersion]


// Check if the object is nil or the NSNull object.
static inline BOOL isNullOBJ(id object){
	BOOL isNull = NO;
	if (object == nil || object == [NSNull null]){
		isNull = YES;
	}
	return isNull;
}

// Check if the object is null or if the object responds to the length or count selector and is zero.
static inline BOOL isEmptyOBJ(id object) {
    return object == nil || [object isEqual:[NSNull null]] || ([object respondsToSelector:@selector(length)] && [(NSData *)object length] == 0) || ([object respondsToSelector:@selector(count)] && [(NSArray *)object count] == 0);
}

static inline NSString *stringFromObject(id object) {
	if (object == nil || [object isEqual:[NSNull null]]) {
		return @"";
	} else if ([object isKindOfClass:[NSString class]]) {
		return object;
	} else if ([object respondsToSelector:@selector(stringValue)]){
		return [object stringValue];
	} else {
		return [object description];
	}
}

static inline NSDictionary *dictionaryWithIDArray(id *array, NSUInteger count) {
    id keys[count];
    id objs[count];
    for(NSUInteger i = 0; i < count; i++) {
        keys[i] = array[i * 2];
        objs[i] = array[i * 2 + 1];
    }
    return [NSDictionary dictionaryWithObjects: objs forKeys: keys count: count];
}
