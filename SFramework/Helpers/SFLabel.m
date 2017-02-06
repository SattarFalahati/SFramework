//
//  SFLabel.h
//  SFramework
//
//  Created by Sattar Falahati (SFramework) on 13/04/16.
//  Copyright © 2016 Sattar Falahati (SFramework). All rights reserved.
//

#import "SFLabel.h"

@implementation UILabel (SFLabel)

- (void)setTextColor:(UIColor *)textColor range:(NSRange)range
{
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString: self.attributedText];
    [text addAttribute: NSForegroundColorAttributeName
                 value: textColor
                 range: range];
    
    [self setAttributedText: text];
}

- (void)setFont:(UIFont *)font range:(NSRange)range
{
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString: self.attributedText];
    [text addAttribute: NSFontAttributeName
                 value: font
                 range: range];
    
    [self setAttributedText: text];
}


// Attributed text

- (void)setAttributedTextWithString:(NSString *)string withBaseFont:(UIFont *)baseFont andBaseColor:(UIColor *)baseColor withAttributedString:(NSString *)attributedString withAttributedFont:(UIFont *)attributedFont andAttributedColor:(UIColor *)attributedColor
{
    string = string;
    attributedString = attributedString;
    if (!baseFont) baseFont = self.font;
    if (!baseColor) baseColor = self.textColor;
    if (!attributedFont) attributedFont = baseFont;
    if (!attributedColor) attributedColor = baseColor;
    
    NSDictionary *base = @{NSForegroundColorAttributeName:baseColor, NSFontAttributeName:baseFont};
    NSDictionary *attributed = @{NSForegroundColorAttributeName:attributedColor, NSFontAttributeName:attributedFont};
    
    NSMutableAttributedString *finalString = [[NSMutableAttributedString alloc] initWithString:string attributes:base];
    
    NSRange range = [string rangeOfString:attributedString];
    [finalString setAttributes:attributed range:range];
    
    self.attributedText = finalString;
}


@end
