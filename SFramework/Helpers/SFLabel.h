//
//  SFLabel.h
//  SFramework
//
//  Created by Sattar Falahati (SFramework) on 13/04/16.
//  Copyright © 2016 Sattar Falahati (SFramework). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (SFLabel)

/// Set Text color for a part of string
- (void)setTextColor:(UIColor *)textColor range:(NSRange)range;

/// Set font for a part of string
- (void)setFont:(UIFont *)font range:(NSRange)range;

/// When you want to have a string with two different color and font use this method
- (void)setAttributedTextWithString:(NSString *)string withBaseFont:(UIFont *)baseFont andBaseColor:(UIColor *)baseColor withAttributedString:(NSString *)attributedString withAttributedFont:(UIFont *)attributedFont andAttributedColor:(UIColor *)attributedColor;

@end
