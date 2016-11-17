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

/// Set title and title color in one function
- (void)setTitle:(NSString *)strTitle andTitleColor:(UIColor *)color forState:(UIControlState)state;

/// set image in button with btn having transparent background
- (void)setImage:(UIImage *)btnImage withTransparentBackground:(BOOL)transparent forState:(UIControlState)state;

@end
