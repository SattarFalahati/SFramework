//
//  SFString.h
//  SFramework
//
//  Created by Sattar Falahati (SFramework) on 13/04/16.
//  Copyright © 2016 Sattar Falahati (SFramework). All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SFString)

/// Check string if it is contains another sting
- (BOOL)contains:(NSString *)string;

/// Check for empty string
- (BOOL)isEmptyString;

/// To check whether a string can be losslessly converted to encoding.
- (BOOL)isISOLatin;

/// Check string if it is Alpha Numeric (consisting of or using both letters and numerals)
- (BOOL)isAlphaNumeric;

/// Check string if it is ONLY Numeric
- (BOOL)isOnlyNumeric;

/// Check string if it is ONLY Numeric
- (BOOL)isNumeric;

/// Check string if it is valid email format
- (BOOL)isValidEmailFormat;

/// Check string if it is valid mobile number
- (BOOL)isValidMobileNumber;

/// Check string if it is valid fixed number
- (BOOL)isValidFixedNumber;

/// Reverse a string 
- (NSString *)reverse;

/// Encode URL
- (NSString *)URLEncode;

/// Decode URL
- (NSString *)URLDecode;

/// Delete with space in string
- (NSString *)stringByStrippingWhitespace;

/// Extraxt a part of string
- (NSString *)substringFrom:(NSInteger)from to:(NSInteger)to;

/// Capitalize first character
- (NSString *)capitalizeFirst:(NSString *)source;

/// Create camelcase from underscores string
- (NSString *)underscoresToCamelCase:(NSString*)underscores;

/// Create underscores from camelcase string
- (NSString *)camelCaseToUnderscores:(NSString *)input;

/// Number of words in a string
- (NSUInteger)countWords;

/// Convert special characters to normal characters
- (NSString *)specialCharactersConversion;

/// URL detector
- (NSArray *)URLDetector:(NSString *)text;

/// Phone detector
- (NSArray *)phoneNumberDetector:(NSString *)text;

/// Convert HTML code (string) to normal string
- (NSString *)convertHTMLCodeToString;

/// Find br tags in string and replace them with white space
- (NSString *)stringByStrippingBrTag;

/// Create random string with length
+ (NSString *)randomStringWithLength:(NSInteger)length;

/// Trim a string 
- (NSString *)safeSubstringToIndex:(NSUInteger)to;

/**
 *  Creates an object from a JSON string, and returns it.
 *
 *  @return An NSArray or an NSDictionary built form the JSON string.
 */
- (id)createObjectFromJSONString;

/**
 *  Returns whether or not the given string is an email address using NSDataDetector APIs.
 *
 * The full string must be an email address. This method does not trim the string before checking.
 *
 *  @return `YES` if the string is an email, `NO` if it is not.
 */
- (BOOL)isEmail;

/**
 *  Returns whether or not the given string is a valid URL using NSDataDetector APIs.
 *
 * The full string must be a URL. This method does not trim the string before checking.
 *
 *  @return `YES` if the string is a URL, `NO` if it is not.
 */
- (BOOL)isURL;

/**
 *  Returns whether or not the given string is an phone number using NSDataDetector APIs.
 *
 * The full string must be a phone number. This method does not trim the string before checking.
 *
 *  @return `YES` if the string is an phone number, `NO` if it is not.
 */
- (BOOL)isPhoneNumber;

/**
 *  Returns whether or not the given string is a date using NSDataDetector APIs.
 *
 * The full string must be date. This method does not trim the string before checking.
 *
 *  @return `YES` if the string is an date, `NO` if it is not.
 */
- (BOOL)isDate;

/**
 *  Returns whether or not the given string is an address using NSDataDetector APIs.
 *
 * The full string must be an address. This method does not trim the string before checking.
 *
 *  @return `YES` if the string is an address, `NO` if it is not.
 */
- (BOOL)isAddress;

/**
 *  Returns whether two strings are equal when ignoring case
 *
 *  @param otherString The string to be compared to the receiver string.
 *
 *  @return A boolean value telling whether two strings are the same when ignoring case.
 */
- (BOOL)isEqualToStringIgnoringCase:(NSString *)otherString;

/**
 *  Returns a string in which all occurrences of another string have been removed.
 *
 *  @param removeString The string that will be removed from the receiver.
 *
 *  @return The string that has had all occurrences of another string removed.
 */
- (NSString *)stringByRemovingOccurrencesOfString:(NSString *)removeString;


@end
