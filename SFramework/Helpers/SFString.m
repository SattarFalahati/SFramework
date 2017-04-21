//
//  SFString.h
//  SFramework
//
//  Created by Sattar Falahati (SFramework) on 13/04/16.
//  Copyright © 2016 Sattar Falahati (SFramework). All rights reserved.
//


#import "SFString.h"
#import <CommonCrypto/CommonDigest.h>


@implementation NSString (SFString)

- (BOOL)contains:(NSString *)string
{
    NSRange range = [self rangeOfString:string];
    return (range.location != NSNotFound);
}

- (BOOL)isEmptyString
{
    if ((NSNull *) self == [NSNull null]) {
        return YES;
    }
    if (self == nil) {
        return YES;
    }
    if ([self length] == 0) {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
        return YES;
    }
    if([[self stringByStrippingWhitespace] isEqualToString:@""]){
        return YES;
    }
    return NO;
}

- (BOOL)isISOLatin
{
    return [self canBeConvertedToEncoding:NSISOLatin1StringEncoding];
}

- (BOOL)isAlphaNumeric
{
    NSCharacterSet *unwantedCharacters = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:unwantedCharacters].location == NSNotFound) ? YES : NO;
}

- (BOOL)isOnlyNumeric
{
    NSString *localDecimalSymbol = [[NSLocale currentLocale] objectForKey:NSLocaleDecimalSeparator];
    NSMutableCharacterSet *decimalCharacterSet = [NSMutableCharacterSet characterSetWithCharactersInString:localDecimalSymbol];
    [decimalCharacterSet formUnionWithCharacterSet:[NSCharacterSet alphanumericCharacterSet]];
    NSCharacterSet* nonNumbers = [decimalCharacterSet invertedSet];
    NSRange r = [self rangeOfCharacterFromSet: nonNumbers];
    if (r.location == NSNotFound){
        // check to see how many times the decimal symbol appears in the string. It should only appear once for the number to be numeric.
        int numberOfOccurances = (int)[[self componentsSeparatedByString:localDecimalSymbol] count]-1;
        return (numberOfOccurances > 1) ? NO : YES;
    }
    else return NO;
}

- (BOOL)isNumeric
{
    const char *s = [self UTF8String];
    for (size_t i=0;i<strlen(s);i++){
        if ((s[i]<'0' || s[i]>'9') && (s[i] != '.')){
            return NO;
        }
    }
    return YES;
}

- (BOOL)isValidEmailFormat
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)isValidMobileNumber
{
    NSString *regExPattern = @"^([+]39)?((38[{8,9}|0|3])|(34[{0-3}|{5-9}])|(37[7|3|0])|(36[{0,3}|6|8])|(33[{0-9}])|(32[{2-4}|{7-9}|0])|(39[{0-3}|7])|(313)|(350))([\\d]{7})$";
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger regExMatches = [regEx numberOfMatchesInString:self options:0 range:NSMakeRange(0, [self length])];
    if (regExMatches == 0) {
        return NO;
    } else
        return YES;
}

- (BOOL)isValidFixedNumber
{
    NSString *regExPattern = @"^[0]{1}[0-9]{5,10}$";
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger regExMatches = [regEx numberOfMatchesInString:self options:0 range:NSMakeRange(0, [self length])];
    if (regExMatches != 0) {
        if([self length] > 6 && [self length] < 11){
            return YES;
        }
    }
    return NO;
}


- (NSString *)reverse
{
	NSInteger length = [self length];
	unichar *buffer = calloc(length, sizeof(unichar));
	[self getCharacters:buffer range:NSMakeRange(0, length)];
	for(int i = 0, mid = ceil(length/2.0); i < mid; i++) {
		unichar c = buffer[i];
		buffer[i] = buffer[length-i-1];
		buffer[length-i-1] = c;
	}
	NSString *s = [[NSString alloc] initWithCharacters:buffer length:length];
    buffer = nil;
	return s;
}

- (NSString *)URLEncode
{
    CFStringRef encoded = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                  (__bridge CFStringRef)self,
                                                                  NULL,
                                                                  CFSTR(":/?#[]@!$&'()*+,;="),
                                                                  kCFStringEncodingUTF8);
    return [NSString stringWithString:(__bridge_transfer NSString *)encoded];
}

- (NSString *)URLDecode
{
    CFStringRef decoded = CFURLCreateStringByReplacingPercentEscapes( kCFAllocatorDefault,
                                                                     (__bridge CFStringRef)self,
                                                                     CFSTR(":/?#[]@!$&'()*+,;=") );
    return [NSString stringWithString:(__bridge_transfer NSString *)decoded];
}

- (NSString *)stringByStrippingWhitespace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)substringFrom:(NSInteger)from to:(NSInteger)to
{
    NSString *rightPart = [self substringFromIndex:from];
    return [rightPart substringToIndex:to-from];
}

- (NSString *)capitalizeFirst:(NSString *)source
{
    if ([source length] == 0) {
        return source;
    }
    return [source stringByReplacingCharactersInRange:NSMakeRange(0, 1)
                                           withString:[[source substringWithRange:NSMakeRange(0, 1)] capitalizedString]];
}

- (NSString *)underscoresToCamelCase:(NSString*)underscores
{
    NSMutableString *output = [NSMutableString string];
    BOOL makeNextCharacterUpperCase = NO;
    for (NSInteger idx = 0; idx < [underscores length]; idx += 1) {
        unichar c = [underscores characterAtIndex:idx];
        if (c == '_') {
            makeNextCharacterUpperCase = YES;
        } else if (makeNextCharacterUpperCase) {
            [output appendString:[[NSString stringWithCharacters:&c length:1] uppercaseString]];
            makeNextCharacterUpperCase = NO;
        } else {
            [output appendFormat:@"%C", c];
        }
    }
    return output;
}

- (NSString *)camelCaseToUnderscores:(NSString *)input
{
    NSMutableString *output = [NSMutableString string];
    NSCharacterSet *uppercase = [NSCharacterSet uppercaseLetterCharacterSet];
    for (NSInteger idx = 0; idx < [input length]; idx += 1) {
        unichar c = [input characterAtIndex:idx];
        if ([uppercase characterIsMember:c]) {
            [output appendFormat:@"%s%C", (idx == 0 ? "" : "_"), (unichar)(c ^ 32)];
        } else {
            [output appendFormat:@"%C", c];
        }
    }
    return output;
}

- (NSUInteger)countWords
{
    __block NSUInteger wordCount = 0;
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length)
                               options:NSStringEnumerationByWords
                            usingBlock:^(NSString *character, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                wordCount++;
                            }];
    return wordCount;
}

- (NSString *)specialCharactersConversion
{
	NSString *string = [self stringByReplacingOccurrencesOfString:@"&ndash;" withString:@"–"];
	string = [string stringByReplacingOccurrencesOfString:@"\\U20ac" withString:@"€"];
	string = [string stringByReplacingOccurrencesOfString:@"\\u20ac" withString:@"€"];
	string = [string stringByReplacingOccurrencesOfString:@"\\Ufffd" withString:@"à"];
	string = [string stringByReplacingOccurrencesOfString:@"&mdash;" withString:@"—"];
	string = [string stringByReplacingOccurrencesOfString:@"&#039; " withString:@"'"];
	string = [string stringByReplacingOccurrencesOfString:@"&#039;" withString:@"'"];
	string = [string stringByReplacingOccurrencesOfString:@"&iexcl;" withString:@"¡"];
	string = [string stringByReplacingOccurrencesOfString:@"&iquest;" withString:@"¿"];
	string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
	string = [string stringByReplacingOccurrencesOfString:@"&ldquo;" withString:@"“"];
	string = [string stringByReplacingOccurrencesOfString:@"&rdquo;" withString:@"”"];
	string = [string stringByReplacingOccurrencesOfString:@"&#39;" withString:@"'"];
	string = [string stringByReplacingOccurrencesOfString:@"&lsquo;" withString:@"‘"];
	string = [string stringByReplacingOccurrencesOfString:@"&rsquo;" withString:@"’"];
	string = [string stringByReplacingOccurrencesOfString:@"&laquo;" withString:@"«"];
	string = [string stringByReplacingOccurrencesOfString:@"&raquo;" withString:@"»"];
	string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
	string = [string stringByReplacingOccurrencesOfString:@"&cent;" withString:@"¢"];
	string = [string stringByReplacingOccurrencesOfString:@"&copy;" withString:@"©"];
	string = [string stringByReplacingOccurrencesOfString:@"&divide;" withString:@"÷"];
	string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
	string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
	string = [string stringByReplacingOccurrencesOfString:@"&micro;" withString:@"µ"];
	string = [string stringByReplacingOccurrencesOfString:@"&middot;" withString:@"·"];
	string = [string stringByReplacingOccurrencesOfString:@"&para;" withString:@"¶"];
	string = [string stringByReplacingOccurrencesOfString:@"&plusmn;" withString:@"±"];
	string = [string stringByReplacingOccurrencesOfString:@"&euro;" withString:@"€"];
	string = [string stringByReplacingOccurrencesOfString:@"&pound;" withString:@"£"];
	string = [string stringByReplacingOccurrencesOfString:@"&reg;" withString:@"®"];
	string = [string stringByReplacingOccurrencesOfString:@"&sect;" withString:@"§"];
	string = [string stringByReplacingOccurrencesOfString:@"&trade;" withString:@"™"];
	string = [string stringByReplacingOccurrencesOfString:@"&yen;" withString:@"¥"];
	string = [string stringByReplacingOccurrencesOfString:@"&deg;" withString:@"°"];
	string = [string stringByReplacingOccurrencesOfString:@"&aacute;" withString:@"á"];
	string = [string stringByReplacingOccurrencesOfString:@"&Aacute;" withString:@"Á"];
	string = [string stringByReplacingOccurrencesOfString:@"&agrave;" withString:@"à"];
	string = [string stringByReplacingOccurrencesOfString:@"&Agrave;" withString:@"À"];
	string = [string stringByReplacingOccurrencesOfString:@"&acirc;" withString:@"â"];
	string = [string stringByReplacingOccurrencesOfString:@"&Acirc;" withString:@"Â"];
	string = [string stringByReplacingOccurrencesOfString:@"&aring;" withString:@"å"];
	string = [string stringByReplacingOccurrencesOfString:@"&Aring;" withString:@"Å"];
	string = [string stringByReplacingOccurrencesOfString:@"&atilde;" withString:@"ã"];
	string = [string stringByReplacingOccurrencesOfString:@"&Atilde;" withString:@"Ã"];
	string = [string stringByReplacingOccurrencesOfString:@"&auml;" withString:@"ä"];
	string = [string stringByReplacingOccurrencesOfString:@"&Auml;" withString:@"Ä"];
	string = [string stringByReplacingOccurrencesOfString:@"&aelig;" withString:@"æ"];
	string = [string stringByReplacingOccurrencesOfString:@"&AElig;" withString:@"Æ"];
	string = [string stringByReplacingOccurrencesOfString:@"&ccedil;" withString:@"ç"];
	string = [string stringByReplacingOccurrencesOfString:@"&Ccedil;" withString:@"Ç"];
	string = [string stringByReplacingOccurrencesOfString:@"&eacute;" withString:@"é"];
	string = [string stringByReplacingOccurrencesOfString:@"&Eacute;" withString:@"É"];
	string = [string stringByReplacingOccurrencesOfString:@"&egrave;" withString:@"è"];
	string = [string stringByReplacingOccurrencesOfString:@"&Egrave;" withString:@"È"];
	string = [string stringByReplacingOccurrencesOfString:@"&ecirc;" withString:@"ê"];
	string = [string stringByReplacingOccurrencesOfString:@"&Ecirc;" withString:@"Ê"];
	string = [string stringByReplacingOccurrencesOfString:@"&euml;" withString:@"ë"];
	string = [string stringByReplacingOccurrencesOfString:@"&Euml;" withString:@"Ë"];
	string = [string stringByReplacingOccurrencesOfString:@"&iacute;" withString:@"í"];
	string = [string stringByReplacingOccurrencesOfString:@"&Iacute;" withString:@"Í"];
	string = [string stringByReplacingOccurrencesOfString:@"&igrave;" withString:@"ì"];
	string = [string stringByReplacingOccurrencesOfString:@"&Igrave;" withString:@"Ì"];
	string = [string stringByReplacingOccurrencesOfString:@"&icirc;" withString:@"î"];
	string = [string stringByReplacingOccurrencesOfString:@"&Icirc;" withString:@"Î"];
	string = [string stringByReplacingOccurrencesOfString:@"&iuml;" withString:@"ï"];
	string = [string stringByReplacingOccurrencesOfString:@"&Iuml;" withString:@"Ï"];
	string = [string stringByReplacingOccurrencesOfString:@"&ntilde;" withString:@"ñ"];
	string = [string stringByReplacingOccurrencesOfString:@"&Ntilde;" withString:@"Ñ"];
	string = [string stringByReplacingOccurrencesOfString:@"&oacute;" withString:@"ó"];
	string = [string stringByReplacingOccurrencesOfString:@"&Oacute;" withString:@"Ó"];
	string = [string stringByReplacingOccurrencesOfString:@"&ograve;" withString:@"ò"];
	string = [string stringByReplacingOccurrencesOfString:@"&Ograve;" withString:@"Ò"];
	string = [string stringByReplacingOccurrencesOfString:@"&ocirc;" withString:@"ô"];
	string = [string stringByReplacingOccurrencesOfString:@"&Ocirc;" withString:@"Ô"];
	string = [string stringByReplacingOccurrencesOfString:@"&oslash;" withString:@"ø"];
	string = [string stringByReplacingOccurrencesOfString:@"&Oslash;" withString:@"Ø"];
	string = [string stringByReplacingOccurrencesOfString:@"&otilde;" withString:@"õ"];
	string = [string stringByReplacingOccurrencesOfString:@"&Otilde;" withString:@"Õ"];
	string = [string stringByReplacingOccurrencesOfString:@"&ouml;" withString:@"ö"];
	string = [string stringByReplacingOccurrencesOfString:@"&Ouml;" withString:@"Ö"];
	string = [string stringByReplacingOccurrencesOfString:@"&uacute;" withString:@"ú"];
	string = [string stringByReplacingOccurrencesOfString:@"&Uacute;" withString:@"Ú"];
	string = [string stringByReplacingOccurrencesOfString:@"&ugrave;" withString:@"ù"];
	string = [string stringByReplacingOccurrencesOfString:@"&Ugrave;" withString:@"Ù"];
	string = [string stringByReplacingOccurrencesOfString:@"&ucirc;" withString:@"û"];
	string = [string stringByReplacingOccurrencesOfString:@"&Ucirc;" withString:@"Û"];
	string = [string stringByReplacingOccurrencesOfString:@"&uuml;" withString:@"ü"];
	string = [string stringByReplacingOccurrencesOfString:@"&Uuml;" withString:@"Ü"];
	string = [string stringByReplacingOccurrencesOfString:@"&yuml;" withString:@"ÿ"];
	string = [string stringByReplacingOccurrencesOfString:@"&#180;" withString:@"´"];
	string = [string stringByReplacingOccurrencesOfString:@"&#96;" withString:@"`"];
	string = [string stringByReplacingOccurrencesOfString:@"l?" withString:@"l'"];
	string = [string stringByReplacingOccurrencesOfString:@"L?" withString:@"L'"];
	string = [string stringByReplacingOccurrencesOfString:@"&#0 9; " withString:@"'"];
	string = [string stringByReplacingOccurrencesOfString:@"&#0 9;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@",#232;" withString:@"è"];
    string = [string stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\r" withString:@""];
	return string;
}

- (NSArray *)URLDetector:(NSString *)text
{
	NSMutableArray *mutex = [NSMutableArray array];
	NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
	NSArray *matches = [detector matchesInString:text options:0 range:NSMakeRange(0, [text length])];
	for (NSTextCheckingResult *match in matches){
		NSString *matchText = [text substringWithRange:[match range]];
		if(matchText && ![matchText isEmptyString]){
			[mutex addObject:matchText];
		}
	}
	return [NSArray arrayWithArray:mutex];
}

- (NSArray *)phoneNumberDetector:(NSString *)text
{
	NSMutableArray *mutex = [NSMutableArray array];
	NSDataDetector* detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypePhoneNumber error:nil];
	NSArray *matches = [detector matchesInString:text options:0 range:NSMakeRange(0, [text length])];
	for (NSTextCheckingResult *match in matches){
		NSString *matchText = [text substringWithRange:[match range]];
		if(matchText && ![matchText isEmptyString]){
			[mutex addObject:matchText];
		}
	}
	return [NSArray arrayWithArray:mutex];
}


- (NSString *)convertHTMLCodeToString
{
    NSString *html = self;
    NSScanner *myScanner;
    NSString *text = nil;
    myScanner = [NSScanner scannerWithString:html];
    
    while ([myScanner isAtEnd] == NO) {
        
        [myScanner scanUpToString:@"<" intoString:NULL] ;
        
        [myScanner scanUpToString:@">" intoString:&text] ;
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    html = [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return html;
}

- (NSString *)stringByStrippingBrTag
{
    NSString *str = self;
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@" "];
    str = [str stringByReplacingOccurrencesOfString:@"\t" withString:@" "];
    str = [str stringByReplacingOccurrencesOfString:@"<br>" withString:@" "];
    str = [str stringByReplacingOccurrencesOfString:@"<br/>" withString:@" "];
    str = [str stringByReplacingOccurrencesOfString:@"<br >" withString:@" "];
    str = [str stringByReplacingOccurrencesOfString:@"<br />" withString:@" "];
    [str stringByReplacingOccurrencesOfString:@"\\s" withString:@" " options:NSRegularExpressionSearch range:NSMakeRange(0, [str length])];
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+ (NSString *)randomStringWithLength:(NSInteger)length
{
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity:length];
    
    for (int i = 0; i < length; i++) {
        [randomString appendFormat:@"%C", [letters characterAtIndex:arc4random() % [letters length]]];
    }
    
    return randomString;
}

- (NSString *)safeSubstringToIndex:(NSUInteger)to
{
    @try {
        return [self substringToIndex:to];
    } @catch (NSException *exception) {
        return @"";
    }
}

- (id)createObjectFromJSONString
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
}

- (BOOL)isEmail
{
    NSDataDetector * dataDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
    NSTextCheckingResult * firstMatch = [dataDetector firstMatchInString:self options:0 range:NSMakeRange(0, self.length)];
    return (firstMatch
            && firstMatch.range.location == 0
            && firstMatch.range.length == self.length
            && [firstMatch.URL.scheme isEqualToString:@"mailto"]);
}

- (BOOL)isURL
{
    NSDataDetector *dataDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
    NSTextCheckingResult *firstMatch = [dataDetector firstMatchInString:self options:0 range:NSMakeRange(0, self.length)];
    return (firstMatch
            && firstMatch.range.location == 0
            && firstMatch.range.length == self.length
            && ![firstMatch.URL.scheme isEqualToString:@"mailto"]);
}

- (BOOL)isPhoneNumber
{
    NSDataDetector *dataDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypePhoneNumber error:nil];
    NSTextCheckingResult *firstMatch = [dataDetector firstMatchInString:self options:0 range:NSMakeRange(0, self.length)];
    return firstMatch.range.location == 0 && firstMatch.range.length == self.length;
}

- (BOOL)isDate
{
    NSDataDetector *dataDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeDate error:nil];
    NSTextCheckingResult *firstMatch = [dataDetector firstMatchInString:self options:0 range:NSMakeRange(0, self.length)];
    return firstMatch.range.location == 0 && firstMatch.range.length == self.length;
}

- (BOOL)isAddress
{
    NSDataDetector *dataDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeAddress error:nil];
    NSTextCheckingResult *firstMatch = [dataDetector firstMatchInString:self options:0 range:NSMakeRange(0, self.length)];
    return firstMatch.range.location == 0 && firstMatch.range.length == self.length;
}

- (BOOL)isEqualToStringIgnoringCase:(NSString *)otherString
{
    return [self caseInsensitiveCompare:otherString] == NSOrderedSame;
}

- (NSString *)stringByRemovingOccurrencesOfString:(NSString *)removeString
{
    return [self stringByReplacingOccurrencesOfString:removeString withString:@""];
}

@end
