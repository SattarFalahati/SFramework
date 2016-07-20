//
//  SFColor.h
//  SFramevork
//
//  Created by Sattar Falahati on 18/07/16.
//
//

#import <UIKit/UIKit.h>

#define HexColor(c)                     [UIColor colorWithRed:((c>>24)&0xFF)/255.0 green:((c>>16)&0xFF)/255.0 blue:((c>>8)&0xFF)/255.0 alpha:((c)&0xFF)/255.0]
#define RGB(r, g, b)                    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define RGBA(r, g, b, a)                [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define NSHexColor(c)                   [NSColor colorWithRed:((c>>24)&0xFF)/255.0 green:((c>>16)&0xFF)/255.0 blue:((c>>8)&0xFF)/255.0 alpha:((c)&0xFF)/255.0]
#define NSRGB(r, g, b)                  [NSColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define NSRGBA(r, g, b, a)              [NSColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define UIColorFromRGB(rgbValue)        [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface UIColor (SFColor)

/// Create color from hex string
+ (UIColor *)colorWithHexString:(NSString *)strHex;

@end
