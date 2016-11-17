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

@implementation NSDate (SFDate)

- (NSDateFormatter *)dateFormatterWithFormat:(NSString *)format
{
    if ([format isEmpty]) return [NSDateFormatter new];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    
    // Set local time
    NSLocale *locale = [NSLocale currentLocale];
    NSString *countryCode = [locale objectForKey: NSLocaleCountryCode];
    dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:countryCode];
    
    [dateFormatter setDateFormat :format ];
    return dateFormatter;
}

- (BOOL)isEqualToDate:(NSDate *)date
{
    // Check if date biger
    if(([self compare:date] == NSOrderedAscending)) return NO;
    
    // Check if date smaller
    if (([self compare:date] == NSOrderedDescending)) return NO;
    
    // Date is not biger nor smaller == it is equal
    return YES;
}

- (NSDate *)convertStringToDateWithDateString:(NSString *)dateString withOrginalFormat:(NSString *)strOrginalFormat
{
    if ([dateString isEmpty] || [strOrginalFormat isEmpty]) return nil;
    
    NSDateFormatter *formatter = [self dateFormatterWithFormat:strOrginalFormat];
    [formatter setDateFormat:strOrginalFormat];
    
    return [formatter dateFromString:dateString];
}

- (NSString *)convertToNewFormat:(NSString *)strDateFormat
{
    NSDateFormatter *formatter = [self dateFormatterWithFormat:strDateFormat];
    [formatter setDateFormat:strDateFormat];
    
    return [formatter stringFromDate:self];
}

- (NSDate *)getNowDateWithFormat:(NSString *)strDateFormat
{
    if ([strDateFormat isEmpty]) strDateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDateFormatter *formatter = [self dateFormatterWithFormat:strDateFormat];
    [formatter setDateFormat:strDateFormat];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    NSDate *date = [formatter dateFromString:dateString];
    
    return date;
}

- (long long)getNowDateInMillisecondsFrom1970
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
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *newDate = [calendar dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (BOOL)isBefore:(BOOL)before otherDate:(NSDate *)otherDate
{
    if(before && ([self compare:otherDate] == NSOrderedAscending)) return YES;
    
    if (!before && ([self compare:otherDate] == NSOrderedDescending)) return YES;
    
    return NO;
}

- (NSDate *)returnDayForMonth:(NSInteger)month year:(NSInteger)year day:(NSInteger)day
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


@end
