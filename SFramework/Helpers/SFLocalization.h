//
//  SFLocalization.h
//  Pods
//
//  Created by Mac on 20/07/16.
//
//

#import <Foundation/Foundation.h>

@interface SFLocalization : NSObject

/// Use this only for internal localized text
+ (NSString *)internalFrameworkLocalizedStringForKey:(NSString *)key withDefault:(NSString *)defaultString;

@end
