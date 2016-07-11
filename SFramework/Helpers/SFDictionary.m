//
//  SFDictionary.h
//  SFramework
//
//  Created by Sattar Falahati (SFramework) on 13/04/16.
//  Copyright © 2016 Sattar Falahati (SFramework). All rights reserved.
//

#import "SFDictionary.h"

@implementation NSDictionary (SFDictionary)

- (id)safeValueForKey:(NSString *)key
{
    @try {
        id value = [self valueForKey:key];
        if (value && value != [NSNull null]) return value;
        return nil;
    }
    @catch (NSException *exception) {
        return nil;
    }
}

@end
