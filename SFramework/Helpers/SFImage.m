//
//  SFImage.m
//  Pods
//
//  Created by Mac on 22/07/16.
//
//

#import "SFImage.h"

@implementation SFImage

#pragma mark - Images

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)scaleImage:(UIImage *)orginalImage toWidth:(CGFloat)width
{
    UIImage *scaledImage = orginalImage;
    if (scaledImage.size.width != width) {
        CGFloat height = floorf(scaledImage.size.height * (width / scaledImage.size.width));
        CGSize size = CGSizeMake(width, height);
        
        // Create an image context
        UIGraphicsBeginImageContext(size);
        
        // Draw the scaled image
        [scaledImage drawInRect:CGRectMake(0.0f, 0.0f, size.width, size.height)];
        
        // Create a new image from context
        scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        
        // Pop the current context from the stack
        UIGraphicsEndImageContext();
    }
    // Return the new scaled image
    return scaledImage;
}

+ (UIImage *)blurredImage:(UIImage *)orginalImage
{
    //  Create our blurred image
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:orginalImage.CGImage];
    
    //  Setting up Gaussian Blur
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:5.0f] forKey:@"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    
    /*  CIGaussianBlur has a tendency to shrink the image a little, this ensures it matches
     *  up exactly to the bounds of our original image */
    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
    
    UIImage *blurredImage = [UIImage imageWithCGImage:cgImage];
    return blurredImage;
}

+ (NSString *)getMimeTypeFormData:(NSData *)data
{
    uint8_t c;
    [data getBytes:&c length:1];
    
    switch (c) {
        case 0xFF:
            return @"image/jpeg";
        case 0x89:
            return @"image/png";
        case 0x47:
            return @"image/gif";
        case 0x49:
        case 0x4D:
            return @"image/tiff";
    }
    return nil;
}


@end
