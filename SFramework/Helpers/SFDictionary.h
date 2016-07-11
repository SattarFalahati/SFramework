//
//  SFDictionary.h
//  SFramework
//
//  Created by Sattar Falahati (SFramework) on 13/04/16.
//  Copyright © 2016 Sattar Falahati (SFramework). All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SFDictionary)

- (id)safeValueForKey:(NSString *)key;

@end
