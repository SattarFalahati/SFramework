//
//  SFAnimatedButton.h
//  Pods
//
//  Created by Sattar Falahati on 11/11/16.
//
//

#import <UIKit/UIKit.h>



@interface SFAnimatedButton : UIButton

typedef NS_ENUM(NSUInteger, SFButtonOption) {
    SFButtonNormal = 1,
    SFButtonBounce
};

@property (nonatomic) SFButtonOption SFOptions;

@end


@interface UIButton (SFButtonExtention)

/// Use this when you want to have an image in top center and a title on bottom center of the button.
- (void)centerImageAndTitle;

/// Use this when you want to have an image followed by A text (The space between image and text is 20)
- (void)buttonWithImageAndTitle;

/// Set title and title color in one function
- (void)setTitle:(NSString *)strTitle andTitleColor:(UIColor *)color forState:(UIControlState)state;

/// set image in button with btn having transparent background
- (void)setImage:(UIImage *)btnImage withTransparentBackground:(BOOL)transparent forState:(UIControlState)state;

/**
 * Set attributed string for Button
 * @param string : Complete string to show
 * @param baseFont : base font for button
 * @param baseColor : base color for button's text
 * @param attributedString : the part of button that we want to have different color and font
 * @param attributedFont : font for attributedString
 * @param attributedColor : color for attributedString
 * @param state : button state
 */
- (void)setAttributedTitleWithString:(NSString *)string withBaseFont:(UIFont *)baseFont andBaseColor:(UIColor *)baseColor withAttributedString:(NSString *)attributedString withAttributedFont:(UIFont *)attributedFont andAttributedColor:(UIColor *)attributedColor forState:(UIControlState)state;

/**
 * Rotate button
 * This function will rotate buton 180 Degree and if you call it twice the second time button will rotate to the orginal position.
 */
- (void)rotateButton;

@end

