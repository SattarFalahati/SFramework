//
//  SFButton.h
//  Pods
//
//  Created by Mac on 11/11/16.
//
//

#import <UIKit/UIKit.h>

@interface UIButton (SFButton)

/// Use this when you want to have an image in top center and a title on bottom center of the button.
- (void)centerImageAndTitle;

/// Use this when you want to have an image followed by A text (The space between image and text is 20)
- (void)buttonWithImageAndTitle;

/// Set title and title color in one function
- (void)setTitle:(NSString *)strTitle andTitleColor:(UIColor *)color forState:(UIControlState)state;

/// set image in button with btn having transparent background
- (void)setImage:(UIImage *)btnImage withTransparentBackground:(BOOL)transparent forState:(UIControlState)state;


- (void)setAttributedTitleWithString:(NSString *)string withBaseFont:(UIFont *)baseFont andBaseColor:(UIColor *)baseColor withAttributedString:(NSString *)attributedString withAttributedFont:(UIFont *)attributedFont andAttributedColor:(UIColor *)attributedColor forState:(UIControlState)state;;

@end
