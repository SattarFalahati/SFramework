//
//  SFCarousel.h
//  Pods
//
//  Created by Sattar Falahati on 16/05/17.
//
//

#import <UIKit/UIKit.h>

/** 
 * Special thanks to SRInfiniteCarouselView For giving me the idea of creating a simple edition of carousel. the original link is:
 * https://github.com/guowilling/SRCarouselView
 */

/** 
 * SFCarousel
 *
 * This is a class to create carousel view.
 *
 * How it's work?
 * Create a view in storyboard and set the Custom class to SFCarousel then in your .m file call "- (void)setImageArrary:(NSArray *)arrImages withPlaceholderImage:(UIImage *)imgPlaceholder withDelegate:(id<SFCarouselDelegate>)delegate"
 *
 * SFCarousel will work with url or image and you can set placeholder image.
 * TIP: Don't forget that the property must be STRONG
 */



// MARK: - Image Manager

@interface SFCarouselImageManager : NSObject

// MARK: Completion blocks

/// Completion success block
@property (nonatomic, copy) void(^downloadImageCompletionBlockSuccess)(UIImage *image, NSInteger imageIndex);

/// Completion failure block
@property (nonatomic, copy) void(^downloadImageCompletionBlockFailure)(NSError *error, NSString *strImageURL);

// MARK: Public methods

/// Download image for index
- (void)downloadImageFromURLString:(NSString *)strImageURL atIndex:(NSInteger)imageIndex;

/// Clear cached images
+ (void)clearCachedImages;

@property (nonatomic, assign) NSUInteger repeatCountWhenDownloadFailed;

@end


// MARK: - Carousel

/// DELEGATE
@protocol SFCarouselDelegate <NSObject>

// Use this to handle the selected image
- (void)imageCarouselViewDidSelectImageAtIndex:(NSInteger)index;

@end

@interface SFCarousel : UIView

@property (nonatomic, weak) id<SFCarouselDelegate> delegate;

// Setup carousel (initial method)
- (void)setImageArrary:(NSArray *)arrImages withPlaceholderImage:(UIImage *)imgPlaceholder withDelegate:(id<SFCarouselDelegate>)delegate;

// Options

@property (nonatomic, strong) UIColor *currentPageIndicatorColor;;
@property (nonatomic, strong) UIColor *basePageIndicatorColor;

@end
