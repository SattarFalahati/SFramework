//
//  SFTimer.h
//  Pods
//
//  Created by sattar.falahati on 04/08/17.
//
//

#import <Foundation/Foundation.h>

/// Thanks to Jiva DeVoe https://github.com/jivadevoe/NSTimer-Blocks

@interface NSTimer (SFTimer)

+ (id)scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval blockOfFunctions:(void (^)())inBlock repeats:(BOOL)repeat;
+ (id)timerWithTimeInterval:(NSTimeInterval)inTimeInterval blockOfFunctions:(void (^)())inBlock repeats:(BOOL)repeat;

@end
