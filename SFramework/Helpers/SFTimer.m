//
//  SFTimer.m
//  Pods
//
//  Created by sattar.falahati on 04/08/17.
//
//

#import "SFTimer.h"

@implementation NSTimer (SFTimer)

+ (id)scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval repeats:(BOOL)repeat blockOfFunctions:(void (^)())inBlock
{
    void (^block)() = [inBlock copy];
    id timer = [self scheduledTimerWithTimeInterval:inTimeInterval target:self selector:@selector(executeSimpleBlock:) userInfo:block repeats:repeat];
    return timer;
}

+ (id)timerWithTimeInterval:(NSTimeInterval)inTimeInterval repeats:(BOOL)repeat blockOfFunctions:(void (^)())inBlock
{
    void (^block)() = [inBlock copy];
    id timer = [self timerWithTimeInterval:inTimeInterval target:self selector:@selector(executeSimpleBlock:) userInfo:block repeats:repeat];
    return timer;
}

+ (void)executeSimpleBlock:(NSTimer *)timer
{
    if([timer userInfo])
    {
        void (^block)() = (void (^)())[timer userInfo];
        block();
    }
}

@end
