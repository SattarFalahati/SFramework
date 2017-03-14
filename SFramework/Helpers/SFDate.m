//
//  SFDate.m
//  Pods
//
//  Created by Mac on 17/11/16.
//
//

#import "SFDate.h"

// SFImporst ( to have access to all classes )
#import "SFImports.h"

@implementation NSDateFormatter (DBDateExtensions)

+ (NSDateFormatter *)dateFormatterWithFormat:(NSString *)format
{
    if ([format isEmpty]) return [NSDateFormatter new];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    
    // Set local time
    dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:CURRENT_LOCAL_WITH_OBJECT(NSLocaleCountryCode)];
    
    [dateFormatter setDateFormat :format ];
    return dateFormatter;
}

@end

@implementation NSDate (SFDate)

- (BOOL)isEqualToDate:(NSDate *)date
{
    // Check if date biger
    if(([self compare:date] == NSOrderedAscending)) return NO;
    
    // Check if date smaller
    if (([self compare:date] == NSOrderedDescending)) return NO;
    
    // Date is not biger nor smaller == it is equal
    return YES;
}

+ (NSDate *)convertStringToDateWithDateString:(NSString *)dateString withOrginalFormat:(NSString *)strOrginalFormat
{
    if ([dateString isEmpty] || [strOrginalFormat isEmpty]) return nil;
    
    NSDateFormatter *formatter = [NSDateFormatter dateFormatterWithFormat:strOrginalFormat];
    [formatter setDateFormat:strOrginalFormat];
    
    return [formatter dateFromString:dateString];
}

- (NSString *)convertToNewFormat:(NSString *)strDateFormat
{
    NSDateFormatter *formatter = [NSDateFormatter dateFormatterWithFormat:strDateFormat];
    [formatter setDateFormat:strDateFormat];
    
    return [formatter stringFromDate:self];
}

+ (NSDate *)getNowDateWithFormat:(NSString *)strDateFormat
{
    if ([strDateFormat isEmpty]) strDateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDateFormatter *formatter = [NSDateFormatter dateFormatterWithFormat:strDateFormat];
    [formatter setDateFormat:strDateFormat];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    NSDate *date = [formatter dateFromString:dateString];
    
    return date;
}

+ (long long)getNowDateInMillisecondsFrom1970
{
    long long milliseconds = (long long)([[self getNowDateWithFormat:nil] timeIntervalSince1970] * 1000.0);
    return milliseconds;
}

- (long long)getDateInMillisecondsFrom1970
{
    long long milliseconds = (long long)([self timeIntervalSince1970] * 1000.0);
    return milliseconds;
}

- (NSDate *)addMonth:(NSUInteger)months addDays:(NSUInteger)days addHours:(NSUInteger)hours
{
    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.month = months;
    dateComponents.day = days;
    dateComponents.hour = hours;
    NSDate *newDate = [CURRENT_CALENDAR dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (BOOL)isBefore:(BOOL)before otherDate:(NSDate *)otherDate
{
    if(before && ([self compare:otherDate] == NSOrderedAscending)) return YES;
    
    if (!before && ([self compare:otherDate] == NSOrderedDescending)) return YES;
    
    return NO;
}

+ (NSDate *)returnDayForMonth:(NSInteger)month year:(NSInteger)year day:(NSInteger)day
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    
    [components setDay:day];
    [components setMonth:month];
    [components setYear:year];
    
    return [CURRENT_CALENDAR dateFromComponents:components];
}

- (NSString *)convertSecondsToHoursMinutesSeconds:(int)seconds
{
    int h = floor(seconds/3600);
    int m = floor((seconds - h*3600)/60);
    int s = seconds - (h*3600) - (m*60);
    
    NSString *str = [NSString stringWithFormat:@"%02d:%02d:%02d", h, m, s];
    return str;
}

- (NSString *)convertHoursToMinutes
{
    // Get Start hour
    NSString *strStartTime = [self convertToNewFormat:@"HH:mm"];
    
    // Seprate hours from minutes
    NSArray *arrOfHoursAndMin = [strStartTime componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@":"]];
    
    // Get minutes and hours
    NSInteger intHours = [arrOfHoursAndMin[0] intValue];
    NSInteger intMins = [arrOfHoursAndMin[1] intValue];
    
    // Get sum of the minutes and hours
    NSInteger intSum = (intHours * 60) + intMins;
    
    return [NSString stringWithFormat:@"%d",intSum];
}

+ (NSNumber *)getCalculatedYearDifferenceBetweenfirstDate:(NSDate *)firstDate andSecondDate:(NSDate *)secondDate
{
    // Calculate the year diffrence
    NSDateComponents *pastYearsComponents = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:firstDate toDate:secondDate options:0];
    NSInteger calculated = [pastYearsComponents year];
    
    return [NSNumber numberWithInteger:calculated];
}

+ (NSNumber *)getCalculatedYearDifferenceFromNowToDate:(NSDate *)date
{
    return [self getCalculatedYearDifferenceBetweenfirstDate:date andSecondDate:[self getNowDateWithFormat:@"yyyy"]];
}

+ (void)countdownFromNowToDate:(NSDate *)endDate withCompletitionBlock:(void (^)(NSInteger year, NSInteger month, NSInteger day, NSInteger hour, NSInteger minute, NSInteger second))completitionBlock
{
    if (!endDate) return;
    
    NSDateComponents *dateComponents = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:[self getNowDateWithFormat:nil] toDate:endDate options:0];
    
    NSInteger years    = [dateComponents year];
    NSInteger months   = [dateComponents month];
    NSInteger days     = [dateComponents day];
    NSInteger hours    = [dateComponents hour];
    NSInteger minutes  = [dateComponents minute];
    NSInteger seconds  = [dateComponents second];
    
    if (completitionBlock) completitionBlock (years, months, days, hours, minutes, seconds);
}

@end
