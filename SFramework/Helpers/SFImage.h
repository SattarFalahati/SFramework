//
//  SFImage.h
//  Pods
//
//  Created by Mac on 22/07/16.
//
//

#import <UIKit/UIKit.h>

@interface SFImage : UIImage

/// Create image from color
+ (UIImage *)imageWithColor:(UIColor *)color;

/// Change image scale
+ (UIImage *)scaleImage:(UIImage *)orginalImage toWidth:(CGFloat)width;

/// Set blur effect on an image (Its working fine but slow)
+ (UIImage *)blurredImage:(UIImage *)orginalImage;

/// Get image type from data
+ (NSString *)getMimeTypeFormData:(NSData *)data;
@end
