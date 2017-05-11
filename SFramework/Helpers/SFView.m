//
//  SFView.m
//  Pods
//
//  Created by Mac on 11/09/16.
//
//

#import "SFView.h"

#import "SFConstraints.h"

@implementation UIView (SFView)

// MARK: - Border && Radius

- (void)roundCorners:(UIRectCorner)corners radius:(CGFloat)radius withBorder:(BOOL)border andBorderColor:(UIColor *)color
{
    CGRect bounds = self.bounds;
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds
                                                     byRoundingCorners:corners
                                                           cornerRadii:CGSizeMake(radius, radius)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = bounds;
    shapeLayer.path = bezierPath.CGPath;
    
    self.layer.mask = shapeLayer;
    
    // Add Border
    if (border == YES) {
        
        CAShapeLayer *shapeLayerForBorder = [CAShapeLayer layer];
        shapeLayerForBorder.frame = CGRectZero;
        shapeLayerForBorder.path = bezierPath.CGPath;
        shapeLayerForBorder.strokeColor = color.CGColor;
        shapeLayerForBorder.fillColor = nil;
        
        // Check and see if border already exist , delete it then recreate
        for (CAShapeLayer *layer in self.layer.sublayers) {
            if (CGSizeEqualToSize(layer.frame.size,shapeLayerForBorder.frame.size)) {
                [layer removeFromSuperlayer];
            }
        }
        
        [self.layer addSublayer:shapeLayerForBorder];
    }
}

- (void)roundTopCornersRadius:(CGFloat)radius withBorder:(BOOL)border andBorderColor:(UIColor *)color
{
    [self roundCorners:(UIRectCornerTopLeft|UIRectCornerTopRight) radius:radius withBorder:border andBorderColor:color];
}

- (void)roundBottomCornersRadius:(CGFloat)radius withBorder:(BOOL)border andBorderColor:(UIColor *)color
{
    [self roundCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight) radius:radius withBorder:border andBorderColor:color];
}

- (void)addBorderWithColor:(UIColor *)color andBorderWidth:(CGFloat)width withCornerRadius:(CGFloat)radius
{
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = width;
    self.layer.borderColor = (__bridge CGColorRef _Nullable)(color);
}

- (void)roundetBottomCorner:(UIRectCorner)rectCorner andRadius:(CGFloat)radius andBackgroundColor:(UIColor *)bColor
{
    if(bColor){
        [self setBackgroundColor:bColor];
    }
    UIBezierPath *maskPathEditPP = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayerEditPP = [[CAShapeLayer alloc] init];
    maskLayerEditPP.frame = self.bounds;
    maskLayerEditPP.path = maskPathEditPP.CGPath;
    self.layer.mask = maskLayerEditPP;
}

- (void)makeViewCircular
{
    CGFloat radius = fmin(self.frame.size.height , self.frame.size.width);
    [self addCornerRadius:(radius/2.0)];
}

- (void)addCornerRadius:(CGFloat)radius
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
}

// MARK: - VIEWS

- (void)blurEffectWithUIBlurEffectStyle:(UIBlurEffectStyle)blurStyle
{
    if (!UIAccessibilityIsReduceTransparencyEnabled()) {
        
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:blurStyle];
        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        blurEffectView.frame = self.bounds;
        blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self addSubview:blurEffectView];
    }
}

// MARK: - Make image from a view

- (UIImage *)makeImageFromView
{
    @autoreleasepool {
        
        CGSize imgSize = self.bounds.size;
        
        UIGraphicsBeginImageContextWithOptions(imgSize, NO, 0.0);
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return img;
    }
}


- (void)activeParallaxEffectWithDefaultSize:(CGFloat)size WithScrollView:(UIScrollView *)scrollView
{
    // Do the parallax magic
    CGFloat offset = scrollView.contentOffset.y;
    
    self.constraintTop = offset;
    self.constraintHeight = size - offset;

}


@end
