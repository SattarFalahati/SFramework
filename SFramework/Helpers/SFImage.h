//
//  SFImage.h
//  Pods
//
//  Created by Mac on 22/07/16.
//
//

#import <UIKit/UIKit.h>

/// Directions for gradient image
typedef NS_ENUM(NSUInteger, SFImageGradiantDirection) {
    SFImageGradiantCenter,
    SFImageGradiantDirectionTowardsTop,
    SFImageGradiantDirectionTowardsLeft,
    SFImageGradiantDirectionTowardsRight,
    SFImageGradiantDirectionTowardsBottom,
    SFImageGradiantDirectionFromTopLeftToBottomRight,
    SFImageGradiantDirectionFromTopRightToBottomLeft,
    SFImageGradiantDirectionFromBottomLeftToTopRight,
    SFImageGradiantDirectionFromBottomRightToTopLeft,
    SFImageGradiantDirectionUnknown = 0
};


@interface SFImage : UIImage

/// Create image from color
+ (nonnull UIImage *)imageWithColor:(nonnull UIColor *)color;

/// Get image type from data
+ (nullable NSString *)getImageMimeTypeFormData:(nonnull NSData *)data;

@end

@interface UIImage (SFImage)

/// Change image size with resolution ==> case of use : set profile picture befor calling multipart web service
- (nonnull UIImage *)resizeImageWithResolution:(CGFloat)resolution;

/// Change current color of image to another color
- (nullable UIImage *)changeImageColor:(nonnull UIColor *)color;

/// Change image scale
- (nonnull UIImage *)scaleToWidth:(CGFloat)width;

/// Set blur effect on an image (Its working fine but slow)
- (nonnull UIImage *)convertToBlurredImage;

/**
 *  Creates gradient image
 *  @param view : to use frame and size of the view that we want to create image for.
 *  @param colors : An array of colors
 *  @param direction : set up a direction for gradients using `SFImageGradiantDirection`
 *  @return An NSString containing the JSON representation of the array.
 */
+ (nonnull UIImage *)gradiantImageForView:(nonnull UIView *)view withColors:( NSArray<UIColor *> * _Nonnull)colors withDirection:(SFImageGradiantDirection)direction;

/**
 * Combine two photos 
 * EXPLNATION : This will create a photo from two photos. The Background photo will cover the Background of combined photo and top photo Will be positioned above the background image.
 * @param backgroundImage : An image for background
 * @param bgFrame : Frame (size) to hold the background Image
 * @param topImage : An image to set above the background image 
 * @param topFrame : Frame (size) to set size of the top image  
 * @param topAlpha : Alpha for top to make some transparent top image
 */

+ (nonnull UIImage *)combinedPhotosWithBackgroundImage:(nonnull UIImage *)backgroundImage withBGImageFrame:(CGRect)bgFrame andTopImage:(nonnull UIImage *)topImage withTopImageFrame:(CGRect)topFrame withTopImageAlpha:(CGFloat)topAlpha;

/**
 * Make screenshot
 * This will use top layer on ui window UIWINDOW to take screen shot
 */
+ (nonnull UIImage *)makeScreenShot;

/**
 * Generate random
 */
+ (nonnull UIImage *)generateRandomImageColor;

/**
 * Generate Image with effects
 */

/// To have Image with grayScake (black & whit) use this metthod
- (UIImage *_Nullable)imageWithGrayScaleEffect;

@end
