//
// Licensed under the terms in License.txt
//
// Copyright 2010 Allen Ding. All rights reserved.
//

#import "KiwiConfiguration.h"

@interface KWDeviceInfo : NSObject

// MARK: - Getting the Device Type

+ (BOOL)isSimulator;
+ (BOOL)isPhysical;

@end
