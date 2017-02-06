//
//  SFColor.m
//  SFramevork
//
//  Created by Sattar Falahati on 18/07/16.
//
//

#import "SFColor.h"

@implementation UIColor (SFColor)

// MARK: - Color with HEX

+ (UIColor *)colorWithHexString:(NSString *)strHex
{
    NSString *strColor = [[strHex stringByReplacingOccurrencesOfString:@"#" withString:@""] uppercaseString];
    
    CGFloat alpha = 1.0;
    CGFloat red = 0.0;
    CGFloat blue = 0.0;
    CGFloat green = 0.0;
    
    switch ([strColor length]) {
        case 0:
            // @""
            break;
            
        case 3:
            // #RGB
            alpha = 1.0;
            red   = [self colorComponentFrom:strColor start:0 length:1];
            green = [self colorComponentFrom:strColor start:1 length:1];
            blue  = [self colorComponentFrom:strColor start:2 length:1];
            break;
            
        case 4:
            // #ARGB
            alpha = [self colorComponentFrom:strColor start:0 length:1];
            red   = [self colorComponentFrom:strColor start:1 length:1];
            green = [self colorComponentFrom:strColor start:2 length:1];
            blue  = [self colorComponentFrom:strColor start:3 length:1];
            break;
            
        case 6:
            // #RRGGBB
            alpha = 1.0;
            red   = [self colorComponentFrom:strColor start:0 length:2];
            green = [self colorComponentFrom:strColor start:2 length:2];
            blue  = [self colorComponentFrom:strColor start:4 length:2];
            break;
            
        case 8:
            // #AARRGGBB
            alpha = [self colorComponentFrom:strColor start:0 length:2];
            red   = [self colorComponentFrom:strColor start:2 length:2];
            green = [self colorComponentFrom:strColor start:4 length:2];
            blue  = [self colorComponentFrom:strColor start:6 length:2];
            break;
            
        default:
            NSLog(@"Hex string is not valoid: %@", strHex);
            break;
    }
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

/// Private helper method for (color with hex)
+ (CGFloat)colorComponentFrom:(NSString *)string start:(NSUInteger)start length:(NSUInteger)length
{
    NSString *substring = [string substringWithRange:NSMakeRange(start, length)];
    NSString *fullHex = (length == 2) ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString:fullHex] scanHexInt:&hexComponent];
    return hexComponent / 255.0;
}


@end
