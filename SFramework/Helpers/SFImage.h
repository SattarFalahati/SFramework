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
+ (nonnull UIImage *)imageWithColor:(nonnull UIColor *)color;

/// Change image scale
- (nonnull UIImage *)scaleToWidth:(CGFloat)width;

/// Set blur effect on an image (Its working fine but slow)
- (nonnull UIImage *)convertToBlurredImage;

/// Get image type from data
+ (nullable NSString *)getImageMimeTypeFormData:(nonnull NSData *)data;

@end
