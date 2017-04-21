//
//  SFDictionary.h
//  SFramework
//
//  Created by Sattar Falahati (SFramework) on 13/04/16.
//  Copyright © 2016 Sattar Falahati (SFramework). All rights reserved.
//

#import "SFDictionary.h"

#import "SFObject.h"

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

- (id)getRandomKey
{
    if (self.count == 0) {
        return nil;
    }
    return self.allKeys.getRandomObject;
}

- (NSString *)createJSONString
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
