//
//  SFView.h
//  Pods
//
//  Created by Mac on 11/09/16.
//
//

#import <UIKit/UIKit.h>

@interface UIView (SFView)

// MARK: - Border && Radius

/// Add Corner Radius to corners (TopLeft, TopRight, BottomLeft, BottomRight, AllCorners) with border ( if you don't want to have border just set border == NO and color == nil )
- (void)roundCorners:(UIRectCorner)corners radius:(CGFloat)radius withBorder:(BOOL)border andBorderColor:(UIColor *)color;

/// Only Top Corner Radius with border ( if you don't want to have border just set border == NO and color == nil )
- (void)roundTopCornersRadius:(CGFloat)radius withBorder:(BOOL)border andBorderColor:(UIColor *)color;

/// Only Bottom Corner Radius with border ( if you don't want to have border just set border == NO and color == nil )
- (void)roundBottomCornersRadius:(CGFloat)radius withBorder:(BOOL)border andBorderColor:(UIColor *)color;

/// Add border *** if you don't want to have corner radius send radius nil
- (void)addBorderWithColor:(UIColor *)color andBorderWidth:(CGFloat)width withCornerRadius:(CGFloat)radius;

/// Add Corner Radius To a view with Background Color
- (void)roundetBottomCorner:(UIRectCorner)rectCorner andRadius:(CGFloat)radius andBackgroundColor:(UIColor *)bColor;

/// Make view to be rounded
- (void)makeViewCircular;

/// Add Corner Radius
- (void)addCornerRadius:(CGFloat)radius;

// MARK: - VIEWS

/// Set blur effect with effect option
- (void)blurEffectWithUIBlurEffectStyle:(UIBlurEffectStyle)blurStyle;

/// Create an image from a view
- (UIImage *)makeImageFromView;

@end
