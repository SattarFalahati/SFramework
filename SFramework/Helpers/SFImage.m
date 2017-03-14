//
//  SFImage.m
//  Pods
//
//  Created by Mac on 22/07/16.
//
//

#import "SFImage.h"

@implementation SFImage

// MARK: - Images

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

+ (NSString *)getImageMimeTypeFormData:(NSData *)data
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

@implementation UIImage (SFImage)

- (UIImage *)resizeImageWithResolution:(CGFloat)resolution
{
    @autoreleasepool {
        
        CGFloat width = self.size.width;
        CGFloat height = self.size.height;
        CGRect  bounds = CGRectMake(0, 0, width, height);
        
        // Check if current image is not lower than size
        if (width <= resolution && height <= resolution) {
            return self;
        }
        
        CGFloat ratio = width / height;
        
        if (ratio > 1.0) {
            bounds.size.width = resolution;
            bounds.size.height = bounds.size.width / ratio;
        } else {
            bounds.size.height = resolution;
            bounds.size.width = bounds.size.height * ratio;
        }
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, NO, 0.0);
        [self drawInRect:CGRectMake(0.0, 0.0, bounds.size.width, bounds.size.height)];
        
        UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return resizedImage;
    }
}

- (UIImage *)changeImageColor:(UIColor *)color
{
    @autoreleasepool {
        UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [color setFill];
        
        CGContextTranslateCTM(context, 0, self.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextClipToMask(context, CGRectMake(0, 0, self.size.width, self.size.height), [self CGImage]);
        CGContextFillRect(context, CGRectMake(0, 0, self.size.width, self.size.height));
        
        UIImage *nuovaImmagine = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return nuovaImmagine;
    }
}

- (UIImage *)scaleToWidth:(CGFloat)width
{
    @autoreleasepool {
        
        UIImage *scaledImage = self;
        
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
}

- (UIImage *)convertToBlurredImage
{
    //  Create our blurred image
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:self.CGImage];
    
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

@end
