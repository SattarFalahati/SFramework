//
//  SFCarousel.m
//  Pods
//
//  Created by Sattar Falahati on 16/05/17.
//
//

#import "SFCarousel.h"

#import "SFDefine.h"
#import "SFObject.h"
#import "SFDictionary.h"

// MARK: - Image manager

@interface SFCarouselImageManager ()

@property (nonatomic, strong) NSMutableDictionary *dicRedownloadManager;

@end

@implementation SFCarouselImageManager

+ (void)load
{
    // Set directory
    NSString *imagesDirectory = SFCarouselImagesDirectory;
    BOOL isDirectory = NO;
    
    // File manager
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExists = [fileManager fileExistsAtPath:imagesDirectory isDirectory:&isDirectory];
    
    // create directory if it's not exisst or not a directory
    if (!isExists || !isDirectory) {
        [fileManager createDirectoryAtPath:imagesDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

// Initial dictionary
- (NSMutableDictionary *)dicRedownloadManager
{
    if (!_dicRedownloadManager) {
        _dicRedownloadManager = [NSMutableDictionary dictionary];
    }
    return _dicRedownloadManager;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.repeatCountWhenDownloadFailed = 2;
    }
    return self;
}

// Check all saved imaged
- (UIImage *)imageFromSandboxWithImageURLString:(NSString *)strImageURL
{
    NSString *imagePath = SFCarouselImagePath(strImageURL);
    NSData *data = [NSData dataWithContentsOfFile:imagePath];
    if (data.length > 0 ) {
        return [UIImage imageWithData:data];
    } else {
        [[NSFileManager defaultManager] removeItemAtPath:imagePath error:NULL];
    }
    return nil;
}


/// Download Image
- (void)downloadImageFromURLString:(NSString *)imageURLString atIndex:(NSInteger)imageIndex {
    
    // Check of image already exist, return the image
    UIImage *image = [self imageFromSandboxWithImageURLString:imageURLString];
    if (image) {
        if (self.downloadImageCompletionBlockSuccess) {
            self.downloadImageCompletionBlockSuccess(image, imageIndex);
        }
        return;
    }
    
    // Download image using Nsurl session
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:imageURLString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        // USE dispatch to parse responce
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // If it failed retry it
            if (error) {
                [self redownloadWithImageURLString:imageURLString imageIndex:imageIndex error:error];
                return;
            }
            
            // Set image from data
            UIImage *image = [UIImage imageWithData:data];
            if (!image) {
                return;
            }
            
            // Return handler
            if (self.downloadImageCompletionBlockSuccess) {
                self.downloadImageCompletionBlockSuccess(image, imageIndex);
            }
            
            // Write file to the path
            if (![data writeToFile:SFCarouselImagePath(imageURLString) atomically:YES]) {
                NSLog(@"write To File Failed!");
            }
        });
    }] resume];
}

// Retry to download ( only 2 times )
- (void)redownloadWithImageURLString:(NSString *)imageURLString imageIndex:(NSInteger)imageIndex error:(NSError *)error
{
    NSNumber *redownloadNumber = [self.dicRedownloadManager safeValueForKey:imageURLString];
    NSInteger redownloadTimes = redownloadNumber ? redownloadNumber.integerValue : 0;
    
    // If it still les than 2 retry
    if (self.repeatCountWhenDownloadFailed > redownloadTimes ) {
        self.dicRedownloadManager[imageURLString] = @(++redownloadTimes);
        [self downloadImageFromURLString:imageURLString atIndex:imageIndex];
        return;
    }
    
    // Return failure block
    if (self.downloadImageCompletionBlockFailure) {
        self.downloadImageCompletionBlockFailure(error, imageURLString);
    }
}

// Clear cached images
+ (void)clearCachedImages
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *fileNames = [fileManager contentsOfDirectoryAtPath:SFCarouselImagesDirectory error:nil];
    for (NSString *fileName in fileNames) {
        if (![fileManager removeItemAtPath:[SFCarouselImagesDirectory stringByAppendingPathComponent:fileName] error:nil]) {
            NSLog(@"removeItemAtPath Failed!");
        }
    }
}

@end


// MARK: - Carousel

@interface SFCarousel () <UIScrollViewDelegate>

@property (nonatomic, strong) SFCarouselImageManager *sfCarouselManager;
@property (nonatomic, strong) NSMutableArray *arrDataSourceImages;
@property (nonatomic, strong) NSArray *arrImages;

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) NSInteger nextIndex;
@property (nonatomic, strong) UIImage *imgPlaceholder;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView  *currentImageView;
@property (nonatomic, strong) UIImageView  *nextImageView;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation SFCarousel

- (SFCarouselImageManager *)sfCarouselManager
{
    if (!_sfCarouselManager) {
        // Initial self
        __weak typeof(self) weakSelf = self;
        
        // Initial image manager
        _sfCarouselManager = [SFCarouselImageManager new];
        
        // Handle success image manager block
        _sfCarouselManager.downloadImageCompletionBlockSuccess = ^(UIImage *image, NSInteger imageIndex) {
            
            // Add image to data source at index
            weakSelf.arrDataSourceImages[imageIndex] = image;
            
            // Set current image
            if (weakSelf.currentIndex == imageIndex) {
                weakSelf.currentImageView.image = image;
            }
        };
        
        // Handle failure image manager block
        _sfCarouselManager.downloadImageCompletionBlockFailure  = ^(NSError *error, NSString *imageURLString) {
            NSLog(@"DownloadImageCompletionBlockFailure imageURLString: %@ error: %@", imageURLString, error);
        };
    }
    
    return _sfCarouselManager;
}

// MARK: initila method

- (void)setImageArrary:(NSArray *)arrImages withPlaceholderImage:(UIImage *)imgPlaceholder withDelegate:(id<SFCarouselDelegate>)delegate
{
    // Set array
    self.arrImages = arrImages;
    
    // Set delegate
    self.delegate = delegate;
    
    // Set placeholder
    self.imgPlaceholder = imgPlaceholder;
    
    self.arrDataSourceImages = [NSMutableArray array];
    
    _currentIndex = 0;
    _nextIndex    = 0;
    
    [self setup];
}

// MARK: Setup view & layouts

- (void)setup
{
    if ([self.arrImages isEmpty]) return;
    
    [self setupSubviews];
    [self setupImages];
}

/**
 * SFCarousel subviews structure :
 *
 *  -- UIView (self)
 *  |
 *  |
 *  ---------- UIScrollview
 *  |       |
 *  |       | -- UIImageView (current imageView)
 *  |       |
 *  |       | -- UIImageView (next imageView)
 *  |
 *  |
 *  --------- UIPageControl
 *
 */

- (void)setupSubviews
{
    // Create scroll view and add it to the self (view)
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    [self addSubview:self.scrollView];
    
    // Create image view and add it to the scrollview
    self.currentImageView = [[UIImageView alloc] init];
    self.currentImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.currentImageView.userInteractionEnabled = YES;
    
    // Add tap Gesture to handle the delegate
    [self.currentImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapCurrentImageView)]];
    [self.scrollView addSubview:self.currentImageView];
    
    // Create image view and add it to the scrollview
    self.nextImageView = [[UIImageView alloc] init];
    self.nextImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.scrollView addSubview:self.nextImageView];
    
    // Create page control and add it to the self (view)
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.hidesForSinglePage = YES;
    self.pageControl.userInteractionEnabled = NO;
    self.pageControl.numberOfPages = self.arrImages.count;
    self.pageControl.currentPage = 0;
    [self addSubview:self.pageControl];
}

- (void)setupImages
{
    for (int i = 0; i < self.arrImages.count; i++) {
        if ([self.arrImages[i] isKindOfClass:[UIImage class]]) {
            // local image (images are not URL)
            [self.arrDataSourceImages addObject:self.arrImages[i]];
        }
        if ([self.arrImages[i] isKindOfClass:[NSString class]]) {
            // URL Images
            if (self.imgPlaceholder) {
                // Hold placeholder image if setted
                [self.arrDataSourceImages addObject:self.imgPlaceholder];
            }
            else {
                // use NSNull object replace if not setted
                [self.arrDataSourceImages addObject:[NSNull null]];
            }
            
            // Download images
            [self.sfCarouselManager downloadImageFromURLString:self.arrImages[i] atIndex:i];
        }
    }
    
    if ([self.arrDataSourceImages[0] isKindOfClass:[NSNull class]]) {
        self.currentImageView.image = nil;
    }
    else {
        // show first image or placeholder image if exists
        self.currentImageView.image = self.arrDataSourceImages[0];
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.scrollView.frame = self.bounds;
    self.scrollView.contentInset = UIEdgeInsetsZero;
    
    CGFloat width = self.scrollView.frame.size.width;
    CGFloat height = self.scrollView.frame.size.height;
    
    if (self.arrDataSourceImages.count > 1) {
        self.scrollView.contentSize   = CGSizeMake(width * 3, 0);
        self.scrollView.contentOffset = CGPointMake(width, 0);
        self.currentImageView.frame   = CGRectMake(width, 0, width, height);
    } else {
        self.scrollView.contentSize   = CGSizeZero;
        self.scrollView.contentOffset = CGPointMake(0, 0);
        self.currentImageView.frame   = CGRectMake(0, 0, width, height);
    }
    
    CGFloat pageControlDotWidth = 15;
    CGFloat pageControlHeight = 20;
    
    self.pageControl.frame = CGRectMake(width * 0.5 - self.pageControl.numberOfPages * pageControlDotWidth * 0.5, height - pageControlHeight, self.pageControl.numberOfPages * pageControlDotWidth, pageControlHeight);
    
}

// MARK: Actions

- (void)didTapCurrentImageView
{
    if ([self.delegate respondsToSelector:@selector(imageCarouselViewDidSelectImageAtIndex:)]) {
        [self.delegate imageCarouselViewDidSelectImageAtIndex:self.currentIndex];
    }
}

// MARK: UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat width = _scrollView.frame.size.width;
    if (offsetX == width) {
        return;
    }
    
    CGFloat height = _scrollView.frame.size.height;
    
    if (offsetX > width) {
        self.nextImageView.frame = CGRectMake(CGRectGetMaxX(self.currentImageView.frame), 0, width, height);
        self.nextIndex = self.currentIndex + 1;
        if (self.nextIndex == self.arrDataSourceImages.count) {
            self.nextIndex = 0;
        }
    }
    
    if (offsetX < width) {
        self.nextImageView.frame = CGRectMake(0, 0, width, height);
        self.nextIndex = self.currentIndex - 1;
        if (self.nextIndex < 0) {
            self.nextIndex = self.arrDataSourceImages.count - 1;
        }
    }
    
    // Set up next image
    if ([self.arrDataSourceImages[self.nextIndex] isKindOfClass:[NSNull class]]) {
        self.nextImageView.image = nil;
    }
    else {
        self.nextImageView.image = self.arrDataSourceImages[self.nextIndex];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self updateContent];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    [self updateContent];
}

- (void)updateContent {
    
    CGFloat width = self.scrollView.frame.size.width;
    
    // if paging not finished do not update content
    if (self.scrollView.contentOffset.x == width) {
        return;
    }
    
    CGFloat height = self.scrollView.frame.size.height;
    
    self.currentIndex = self.nextIndex;
    self.pageControl.currentPage = self.currentIndex;
    
    self.currentImageView.image = self.nextImageView.image;
    self.currentImageView.frame = CGRectMake(width, 0, width, height);
    
    [self.scrollView setContentOffset:CGPointMake(width, 0) animated:NO];
}

// MARK: Public Methods

- (void)setCurrentPageIndicatorColor:(UIColor *)currentPageIndicatorColor
{
    if (_currentPageIndicatorColor != currentPageIndicatorColor) {
        _currentPageIndicatorColor = currentPageIndicatorColor;
        _pageControl.currentPageIndicatorTintColor = currentPageIndicatorColor;
    }
}

- (void)setBasePageIndicatorColor:(UIColor *)basePageIndicatorColor
{
    if (_basePageIndicatorColor != basePageIndicatorColor) {
        _basePageIndicatorColor = basePageIndicatorColor;
        _pageControl.pageIndicatorTintColor = basePageIndicatorColor;
    }
}

@end
