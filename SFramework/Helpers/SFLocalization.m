//
//  SFLocalization.m
//  Pods
//
//  Created by Mac on 20/07/16.
//
//

#import "SFLocalization.h"

@implementation SFLocalization


#pragma mark - Internal Framework Localization Helper

/// Use this only for internal localized text
+ (NSString *)internalFrameworkLocalizedStringForKey:(NSString *)key withDefault:(NSString *)defaultString
{
    static NSBundle *bundle = nil;
    if (bundle == nil) {
        NSString *bundlePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"SFramework" ofType:@"bundle"];
        bundle = [NSBundle bundleWithPath:bundlePath] ?: [NSBundle bundleForClass:[self class]];
        for (NSString *language in [NSLocale preferredLanguages]) {
            if ([[bundle localizations] containsObject:language]) {
                bundlePath = [bundle pathForResource:@"Localizable" ofType:@"string"];
                bundle = [NSBundle bundleWithPath:bundlePath];
                break;
            }
        }
    }
    defaultString = [bundle localizedStringForKey:key value:defaultString table:nil];
    return [[NSBundle bundleForClass:[self class]] localizedStringForKey:key value:defaultString table:nil];
}

@end
