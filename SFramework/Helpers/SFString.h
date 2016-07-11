//
//  SFString.h
//  SFramework
//
//  Created by Sattar Falahati (SFramework) on 13/04/16.
//  Copyright © 2016 Sattar Falahati (SFramework). All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SFString)

- (NSString *) reverse;
- (NSString *) URLEncode;
- (NSString *) URLDecode;
- (NSString *) stringByStrippingWhitespace;
- (NSString *) substringFrom:(NSInteger)from to:(NSInteger)to;
- (NSString *) CapitalizeFirst:(NSString *)source;
- (NSString *) UnderscoresToCamelCase:(NSString*)underscores;
- (NSString *) CamelCaseToUnderscores:(NSString *)input;
- (NSUInteger) countWords;
- (BOOL) contains:(NSString *)string;
- (BOOL) isEmpty;
- (BOOL) isAlphaNumeric;
- (BOOL) isISOLatin;
- (BOOL) isOnlyNumeric;
- (BOOL) isNumeric;
- (BOOL) isValidEmailFormat;
- (BOOL) isValidNumeroMobile;
- (BOOL) isValidNumeroFisso;
- (NSArray *) urlDetector:(NSString *)text;
- (NSArray *) phoneNumberDetector:(NSString *)text;
- (NSString *) replaceDetector;
- (NSString *) specialCharactersConversion;
- (NSString *)convertHTML;
@end
