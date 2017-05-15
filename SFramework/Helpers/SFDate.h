//
//  SFDate.h
//  Pods
//
//  Created by Mac on 17/11/16.
//
//

#import <Foundation/Foundation.h>


@interface NSDateFormatter (DBDateExtensions)

/// Set date formatter with format ; IMPORTANT : This method will change time zone based on user current time (local time)
+ (nonnull NSDateFormatter *)dateFormatterWithFormat:(nonnull NSString *)format;

@end

@interface NSDate (SFDate)

/// Check if date is equal to another date
- (BOOL)isEqualToDate:(nonnull NSDate *)date;

/// Convert string to date
+ (nullable NSDate *)convertStringToDateWithDateString:(nonnull NSString *)dateString withOrginalFormat:(nullable NSString *)strOrginalFormat;

/// Convert date to new date with new format
- (nonnull NSString *)convertToNewFormat:(nonnull NSString *)strDateFormat;

/// Get now date and time IMPORTANT : The defualt strDateFormat is : @"yyyy-MM-dd HH:mm:ss" ( in case user send it empty )
+ (nonnull NSDate *)getNowDateWithFormat:(nullable NSString *)strDateFormat;

/// Get now date in milliseconds
+ (long long)getNowDateInMillisecondsFrom1970;

/// Get date in milliseconds
- (long long)getDateInMillisecondsFrom1970;

/// Add month , days and hours to a date
- (nonnull NSDate *)addMonth:(NSUInteger)months addDays:(NSUInteger)days addHours:(NSUInteger)hours;

/// Compare to date ( Check if a date is before / after other date )
- (BOOL)isBefore:(BOOL)before otherDate:(nonnull NSDate *)otherDate;

/// USE TO GET FIRST OR LAST DATE OF A MONTH *** EXAMPLE : FIRST DAY :[someDate returnDateForMonth:components.month year:components.year day:2 withDate:date] last DAY :  [someDate returnDateForMonth:components.month+1 year:components.year day:1 withDate:date];
- (nonnull NSDate *)returnDayForMonth:(NSInteger)month year:(NSInteger)year day:(NSInteger)day;

/// Convert seconeds to HH:MM:SS
- (nonnull NSString *)convertSecondsToHoursMinutesSeconds:(int)seconds;

/// Convert hours to minutes
- (nonnull NSString *)convertHoursToMinutes;

/**
 *  Calculate the year diffrence between a date and now (you can use this method to calculate the age ...)
 *  @param date The date that you want to calculate the year difference.
 *  @return Number of difference.
 */
+ (nonnull NSNumber *)getCalculatedYearDifferenceFromNowToDate:(nonnull NSDate *)date;

/**
 *  Calculate the year diffrence between two dates.
 *  @param firstDate : the first date
 *  @param secondDate : the second date
 *  @return Number of difference between two dates.
 */
+ (nonnull NSNumber *)getCalculatedYearDifferenceBetweenfirstDate:(nonnull NSDate *)firstDate andSecondDate:(nonnull NSDate *)secondDate;

/**
 *  Calculate the time remain between now and at specific date
 *  @param endDate The end date.
 *  return Years, month, days, hours, minutes and seconds that remains from NOW date to the enad date.
 */
+ (void)countdownFromNowToDate:(nonnull NSDate *)endDate withCompletitionBlock:(void (^_Nullable)(NSInteger year, NSInteger month, NSInteger day, NSInteger hour, NSInteger minute, NSInteger second))completitionBlock;

@end
