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

/// Use this methods for ios 8 to 10. from iOS 10 above use the native method. 
+ (id)scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval repeats:(BOOL)repeat blockOfFunctions:(void (^)())inBlock;
+ (id)timerWithTimeInterval:(NSTimeInterval)inTimeInterval repeats:(BOOL)repeat blockOfFunctions:(void (^)())inBlock;

@end
