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

@end
