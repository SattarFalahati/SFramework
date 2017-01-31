//
//  SFDate.h
//  Pods
//
//  Created by Mac on 17/11/16.
//
//

#import <Foundation/Foundation.h>

@interface NSDate (SFDate) 


/// Set date formatter with format ; IMPORTANT : This method will change time zone based on user current time (local time)
- (nonnull NSDateFormatter *)dateFormatterWithFormat:(nonnull NSString *)format;

/// Check if date is equal to another date
- (BOOL)isEqualToDate:(nonnull NSDate *)date;

/// Convert string to date
- (nullable NSDate *)convertStringToDateWithDateString:(nonnull NSString *)dateString withOrginalFormat:(nullable NSString *)strOrginalFormat;

/// Convert date to new date with new format
- (nonnull NSString *)convertToNewFormat:(nonnull NSString *)strDateFormat;

/// Get now date and time IMPORTANT : The defualt strDateFormat is : @"yyyy-MM-dd HH:mm:ss" ( in case user send it empty )
- (nonnull NSDate *)getNowDateWithFormat:(nonnull NSString *)strDateFormat;

/// Get now date in milliseconds
- (long long)getNowDateInMillisecondsFrom1970;

/// Get date in milliseconds
- (long long)getDateInMillisecondsFrom1970;

/// Add month , days and hours to a date
- (nonnull NSDate *)addMonth:(NSUInteger)months addDays:(NSUInteger)days addHours:(NSUInteger)hours;

/// Compare to date ( Check if a date is before / after other date )
- (BOOL)isBefore:(BOOL)before otherDate:(nonnull NSDate *)otherDate;

/// USE TO GET FIRST OR LAST DATE OF A MONTH *** EXAMPLE : FIRST DAY :[self returnDateForMonth:components.month year:components.year day:2 withDate:date] last DAY :  [self returnDateForMonth:components.month+1 year:components.year day:1 withDate:date];
- (nonnull NSDate *)returnDayForMonth:(NSInteger)month year:(NSInteger)year day:(NSInteger)day fromDate:(nonnull NSDate *)date;

/// Convert seconeds to HH:MM:SS
- (nonnull NSString *)convertSecondsToHoursMinutesSeconds:(int)seconds;

/// Convert hours to minutes
- (nonnull NSString *)convertHoursToMinutes;

/// Calculate the year diffrence between a date and now *** you can use this method to calculate the age ...
- (nonnull NSNumber *)getCalculatedYearDifferenceFromDate:(NSDate *)date;


@end
