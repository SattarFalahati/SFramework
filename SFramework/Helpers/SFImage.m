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
    @autoreleasepool {
        CGRect rect = CGRectMake(0, 0, 1, 1);
        UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
        [color setFill];
        UIRectFill(rect);
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
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

// MARK: GRADIANT

+ (UIImage *)gradiantImageForView:(UIView *)view withColors:(NSArray<UIColor *> *)colors withDirection:(SFImageGradiantDirection)direction
{
    CGPoint startPoint = CGPointZero;
    CGPoint endPoint = CGPointZero;
    
    // Direzione
    switch (direction) {
        case SFImageGradiantCenter:{
            return [self createCenterGradientImageOnView:view withColors:colors];
        }
            break;
        case SFImageGradiantDirectionTowardsTop:
            startPoint = CGPointMake(0.0, 1.0);
            endPoint   = CGPointMake(0.0, 0.0);
            break;
        case SFImageGradiantDirectionFromTopRightToBottomLeft:
            startPoint = CGPointMake(1.0, 0.0);
            endPoint   = CGPointMake(0.0, 1.0);
            break;
        case SFImageGradiantDirectionFromTopLeftToBottomRight:
            startPoint = CGPointMake(0.0, 0.0);
            endPoint   = CGPointMake(1.0, 1.0);
            break;
        case SFImageGradiantDirectionTowardsBottom:
            startPoint = CGPointMake(0.0, 0.0);
            endPoint   = CGPointMake(0.0, 1.0);
            break;
            
        case SFImageGradiantDirectionFromBottomLeftToTopRight:
            startPoint = CGPointMake(0.0, 1.0);
            endPoint   = CGPointMake(1.0, 0.0);
            break;
        case SFImageGradiantDirectionFromBottomRightToTopLeft:
            startPoint = CGPointMake(1.0, 1.0);
            endPoint   = CGPointMake(0.0, 0.0);
            break;
        case SFImageGradiantDirectionTowardsRight:
            startPoint = CGPointMake(0.0, 0.0);
            endPoint   = CGPointMake(1.0, 0.0);
            break;
        case SFImageGradiantDirectionTowardsLeft:
            startPoint = CGPointMake(1.0, 0.0);
            endPoint   = CGPointMake(0.0, 0.0);
            break;
    }
    
    startPoint.x *= view.frame.size.width;
    startPoint.y *= view.frame.size.height;
    
    endPoint.x *= view.frame.size.width;
    endPoint.y *= view.frame.size.height;
    
    return [self createGradientImageWithSize:view.frame.size withColors:colors withStartPoint:startPoint withEndPoint:endPoint];
}

/// Helper : http://stackoverflow.com/questions/8098130/how-can-i-tint-a-uiimage-with-gradient
+ (UIImage *)createGradientImageWithSize:(CGSize)size withColors:(NSArray<UIColor *> *)colors withStartPoint:(CGPoint)startPoint withEndPoint:(CGPoint)endPoint
{
    // Create frame
    CGRect frame = CGRectMake(0.0, 0.0, size.width, size.height);
    
    // Create Context
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Create arry of CGcolors
    NSMutableArray *arrColors = [NSMutableArray array];
    for (UIColor *color in colors) {
        [arrColors addObject:(__bridge id)color.CGColor];
    }
    
    // Create gradient
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColors(space, (__bridge CFArrayRef)arrColors, NULL);
    
    // Apply gradient
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation|kCGGradientDrawsAfterEndLocation);
    UIImage *gradientImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(space);
    
    return gradientImage;
}

/// Helper: http://stackoverflow.com/questions/26907352/how-to-draw-radial-gradients-in-a-calayer
+ (UIImage *)createCenterGradientImageOnView:(UIView *)view withColors:(NSArray<UIColor *> *)colors
{
    // Create frame
    CGRect frame = view.frame;
    
    // Create Context
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Create arry of CGcolors
    NSMutableArray *arrColors = [NSMutableArray array];
    for (UIColor *color in colors) {
        [arrColors addObject:(__bridge id)color.CGColor];
    }
    
    // Create gradient
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColors(space, (__bridge CFArrayRef)arrColors, NULL);
    
    //  Create positions (ceter)
    CGPoint gradCenter= CGPointMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds));
    float gradRadius = MIN(frame.size.width , frame.size.height);
    
    CGContextDrawRadialGradient (context, gradient, gradCenter, 0, gradCenter, gradRadius, kCGGradientDrawsAfterEndLocation);
    
    UIImage *gradientImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(space);
    
    return gradientImage;
}

// MARK: - COMBINE PHOTOS

+ (UIImage *)combinedPhotosWithBackgroundImage:(UIImage *)backgroundImage withBGImageFrame:(CGRect)bgFrame andTopImage:(UIImage *)topImage withTopImageFrame:(CGRect)topFrame withTopImageAlpha:(CGFloat)topAlpha
{
    UIImage *finalImage;
    
    @autoreleasepool {
        UIView *sharingView = [[UIView alloc] initWithFrame:bgFrame];
        
        UIImageView *imgBackground = [[UIImageView alloc] initWithFrame:bgFrame];
        imgBackground.image = backgroundImage;
        imgBackground.contentMode = UIViewContentModeTop;
        [sharingView addSubview:imgBackground];
        
        UIImageView *imgTop = [[UIImageView alloc] initWithFrame:topFrame];
        imgTop.image = topImage;
        imgTop.backgroundColor = [UIColor colorWithRed:26.0f/255.0f green:25.0f/255.0f blue:32.0f/255.0f alpha:.5f];
        imgTop.contentMode = UIViewContentModeScaleAspectFit;
        [sharingView addSubview:imgTop];
        [imgTop setAlpha:topAlpha];
        
        UIGraphicsBeginImageContextWithOptions(bgFrame.size, YES, 0.0f);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [sharingView.layer renderInContext:context];
        finalImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    return finalImage;
}

// MARK: SCREENSHOT

+ (UIImage *)makeScreenShot
{
    // create graphics context with screen size
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIGraphicsBeginImageContext(screenRect.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor blackColor] set];
    CGContextFillRect(ctx, screenRect);
    
    // grab reference to our window
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    // transfer content into our context
    [window.layer renderInContext:ctx];
    UIImage *screengrab = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return screengrab;
}

// MARK: RANDOM COLOR

+ (UIImage *)generateRandomImageColor
{
    UIColor *randomColor = [[UIColor alloc] initWithRed:arc4random()%256/256.0 green:arc4random()%256/256.0 blue:arc4random()%256/256.0 alpha:1.0];
    
    return [SFImage imageWithColor:randomColor];
}

// MARK: Effects on image

// https://developer.apple.com/library/content/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIColorClamp

- (UIImage *)imageWithGrayScaleEffect
{
    UIImage *newImage;
    
    @autoreleasepool {
        
        // Create image rectangle with current image width/height
        CGRect imageRect = CGRectMake(0, 0, self.size.width, self.size.height);
        
        // Grayscale color space
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
        
        // Create bitmap content with current image size and grayscale colorspace
        CGContextRef context = CGBitmapContextCreate(nil, self.size.width, self.size.height, 8, 0, colorSpace, kCGImageAlphaNone);
        
        // Draw image into current context, with specified rectangle
        // using previously defined context (with grayscale colorspace)
        CGContextDrawImage(context, imageRect, [self CGImage]);
        
        // Create bitmap image info from pixel data in current context
        CGImageRef imageRef = CGBitmapContextCreateImage(context);
        
        // Create a new UIImage object
        newImage = [UIImage imageWithCGImage:imageRef];
        
        // Release colorspace, context and bitmap information
        CGColorSpaceRelease(colorSpace);
        CGContextRelease(context);
        CFRelease(imageRef);
    }
    
    // Return the new grayscale image
    return newImage;
}

- (UIImage *)filterEffectsOnImageWithFillterType:(SFImageFilterType)type
{
    UIImage *newImage;
    @autoreleasepool
    {
        // Get Orientation
        UIImageOrientation orientation = self.imageOrientation;
        
        // Create CI Image
        CIImage *img = [CIImage imageWithCGImage:self.CGImage];
        
        // Create Context
        CIContext *context = [CIContext contextWithOptions:nil];
        
        // Create Filter and options
        CIFilter *filter = [self filterWithType:type];
        [filter setValue:img forKey:kCIInputImageKey];
        
        // Get Output image
        CIImage *outputImage = [filter outputImage];
        
        // Get image
        CGImageRef cgImg = [context createCGImage:outputImage fromRect:[outputImage extent]];
        newImage = [UIImage imageWithCGImage:cgImg scale:1.0 orientation:orientation];
        
        // Release
        CGImageRelease(cgImg);
        context = nil;
    }
    return newImage;
}

- (CIFilter *)filterWithType:(SFImageFilterType)type
{
    // Create Filter and options
    if (type == SFImageFilterType_Sepia) {
        CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone"];
        NSNumber *scale = [NSNumber numberWithFloat:0.6];
        [filter setValue:scale forKey:@"inputIntensity"];
        return filter;
    }
    else if (type == SFImageFilterType_Blur) {
        CIFilter *filter = [CIFilter filterWithName:@"CIBoxBlur"];
        NSNumber *scale = [NSNumber numberWithFloat:50];
        [filter setValue:scale forKey:@"inputRadius"];
        return filter;
    }
    else if (type == SFImageFilterType_Clamp) {
        CIFilter *filter = [CIFilter filterWithName:@"CIColorClamp"];
        CIVector *extentMin = [CIVector vectorWithX:-0.1 Y:-0.1 Z:-0.1 W:-0.1];
        CIVector *extentMax = [CIVector vectorWithX:0.7 Y:0.7 Z:0.7 W:0.7];
        [filter setValue:extentMin forKey:@"inputMinComponents"];
        [filter setValue:extentMax forKey:@"inputMaxComponents"];
        
        return filter;
    }
    else if (type == SFImageFilterType_Adjust) {
        CIFilter *filter = [CIFilter filterWithName:@"CIExposureAdjust"];
        NSNumber *scale = [NSNumber numberWithFloat:0.99];
        [filter setValue:scale forKey:@"inputEV"];
        return filter;
    }
    else if (type == SFImageFilterType_ToneCurve) {
        CIFilter *filter = [CIFilter filterWithName:@"CILinearToSRGBToneCurve"];
        return filter;
    }
    else if (type == SFImageFilterType_Hot) {
        CIFilter *filter = [CIFilter filterWithName:@"CITemperatureAndTint"];
        CIVector *inputNeutral = [CIVector vectorWithX:6500 Y:500];
        CIVector *inputTargetNeutral = [CIVector vectorWithX:4000 Y:0];
        [filter setValue:inputNeutral forKey:@"inputNeutral"]; // Default value: [6500, 0] Identity: [6500, 0]
        [filter setValue:inputTargetNeutral forKey:@"inputTargetNeutral"]; // Default value: [6500, 0] Identity: [6500, 0]
        return filter;
    }
    else if (type == SFImageFilterType_Transfer) {
        CIFilter *filter = [CIFilter filterWithName:@"CIPhotoEffectTransfer"];
        return filter;
    }
    else if (type == SFImageFilterType_Edges) {
        CIFilter *filter = [CIFilter filterWithName:@"CIEdges"]; // Default value: 1.0
        return filter;
    }
    return nil;
}


@end
