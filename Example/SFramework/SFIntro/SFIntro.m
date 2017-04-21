//
//  SFIntro.m
//  Reevelo
//
//  Created by Sattar Falahati on 28/03/17.
//  Copyright © 2017 App to you. All rights reserved.
//

#import "SFIntro.h"

@interface SFIntro () <UIScrollViewDelegate>

@end

@implementation SFIntro

SFIntro *_intro;
+ (instancetype)initWithFrame:(CGRect)frame withParallaxBackgroundImage:(NSString *)strParallaxBGImage withDelegate:(id<SFIntroDelegate>) delegate withDataSourceArray:(NSArray *)arrDataSource
{
    // If arrDataSource is empty it will return nil and it wont work.
    if ([arrDataSource isEmpty]) return nil;
    
    @synchronized (self) {
        // Make new one
        SFIntro *intro = [SFIntro new];
        
        // Get SfIntro from Xib file
        /// EXPLNATION : We do know that inside SFIntroView.xib we do have 2 views and SFIntro is the second one (index 1)
        NSArray *views =  [[NSBundle mainBundle] loadNibNamed:@"SFIntroView" owner:nil options:nil];
        intro = [views objectAtIndex:1];
        
        // Set frame
        intro.frame = frame;
        
        // Set delegate
        intro.delegate = delegate;
        
        // Private setup
        [intro setUpSFIntroWithParallaxBackgroundImage:strParallaxBGImage andDataArray:arrDataSource];
        
        // Set SELF (intro)
        _intro = intro;
    }
    return _intro;
}

// MARK: - Private setUps

- (void)setUpSFIntroWithParallaxBackgroundImage:(NSString *)strParallaxBGImage andDataArray:(NSArray *)data
{
    // Initial array of data
    self.arrContent = data;
    
    // If strParallaxBGImage is empty, dont show parallax
    if ([strParallaxBGImage isNotEmpty]) {
        
        // Create UIImage view to hold the image
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-50, 0, self.scrollView.frame.size.width * self.arrContent.count, self.frame.size.height)];
        
        // Set image
        imageView.image = [UIImage imageNamed:strParallaxBGImage];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        // Add image to parallax scroll view
        [self.parallaxScrollView addSubview:imageView];
    }
    
    // Initial scroll view
    [self setUpScrollView];
    
    // Initial buttons
    [self initialButtons];
    
    // Initial pager
    [self initialPager];
    
    // Generate Item
    [self generatePages];
    
    // Delegate
    if (self.delegate && [self.delegate respondsToSelector:@selector(presentedIntroPage:atIndex:)]) {
        [self.delegate presentedIntroPage:self atIndex:self.presentedPageIndex];
    }
}

// MARK: ScrollView & Delegate

- (void)setUpScrollView
{
    // Scroll view
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width * self.arrContent.count, self.scrollView.frame.size.height);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    
    // Parallax scroll view
    self.parallaxScrollView.showsHorizontalScrollIndicator = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // Pager
    CGFloat pageWidth = CGRectGetWidth(self.bounds);
    CGFloat pageFraction = self.scrollView.contentOffset.x / pageWidth;
    self.pager.currentPage = roundf(pageFraction);
    
    // Get page index for delegate
    static NSInteger previousPage = 0;
    NSInteger page = lround(pageFraction);
    if (previousPage != page) {
        previousPage = page;
        
        self.presentedPageIndex = previousPage;
        
        // Delegate
        if (self.delegate && [self.delegate respondsToSelector:@selector(presentedIntroPage:atIndex:)]) {
            [self.delegate presentedIntroPage:self atIndex:previousPage];
        }
    }
    
    // Parallax
    CGFloat backgroundScrollValue = 0.5f;//self.backgroundImage.size.width/self.onboardContentArray.count/self.frame.size.width;
    [self.parallaxScrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x  * backgroundScrollValue, self.scrollView.contentOffset.y) animated:NO];
    
    // Buonce
    if (scrollView.contentOffset.x < -80) {
        scrollView.contentOffset = CGPointMake(-80, 0);
    }
}

// MARK: Initial pager

- (void)initialPager
{
    self.pager.numberOfPages = self.arrContent.count;
    self.pager.currentPageIndicatorTintColor = kCLightBlue; // This can be change by user
    self.pager.pageIndicatorTintColor = kCBlack; // This can be change by user
}

// MARK: Initial buttons

- (void)initialButtons
{
    [self.btnFirst setTitle:@"Close" forState:UIControlStateNormal]; // This can be change by user
    [self.btnSecond setTitle:@"Login" forState:UIControlStateNormal]; // This can be change by user
}

// MARK: - Actions

- (IBAction)firstButton:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(firstButtonDidSelectWithIntro:)]) {
        [self.delegate firstButtonDidSelectWithIntro:self];
    }
}

- (IBAction)secondButton:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(secondButtonDidSelectWithIntro:)]) {
        [self.delegate secondButtonDidSelectWithIntro:self];
    }
}

// MARK: - Generate pages

- (void)generatePages
{
    [self.arrContent enumerateObjectsUsingBlock:^(NSDictionary *pageDict, NSUInteger idx, BOOL *stop) {
        
        /// EXPLNATION : We do know that inside SFIntroView.xib we do have 2 views and SFIntroView is the first one (index 0)
        NSArray *views =  [[NSBundle mainBundle] loadNibNamed:@"SFIntroView" owner:nil options:nil];
        SFIntroView *introView = [views objectAtIndex:0];
        
        // Set frame
        introView.frame = CGRectMake(self.frame.size.width * idx, 0, self.frame.size.width, self.frame.size.height);
        
        // Set image
        introView.img.image = [UIImage imageNamed:(pageDict[kSFIntroObjectImage]) ? pageDict[kSFIntroObjectImage] : @""];
        
        // Set title
        introView.lblTitle.text = (pageDict[kSFIntroObjectTitle]) ? pageDict[kSFIntroObjectTitle] : @"";
        
        // Set description
        introView.lblDescription.text = (pageDict[kSFIntroObjectDescription]) ? pageDict[kSFIntroObjectDescription] : @"";
        
        // Add self to scroll view
        [self.scrollView addSubview:introView];
        
        // Delegate
        [self introViewPage:introView atIndex:idx withObjets:pageDict];
    }];
}

// MARK: - Public functions

- (void)goToPageAtIndex:(NSUInteger)page
{
    CGRect frame = self.scrollView.frame;
    
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [self.scrollView scrollRectToVisible:frame animated:YES];
}

- (void)hideFirstButton
{
    [self hideButton:self.btnFirst];
}

- (void)hideSecondButton
{
    [self hideButton:self.btnSecond];
}



- (void)showFirstButton
{
    [self showButton:self.btnFirst];
}

- (void)showSecondButton
{
    [self showButton:self.btnSecond];
}

- (void)hideButtons
{
    self.buttons.alpha = 1;
    
    // Show Buttons
    [UIView animateWithDuration:0.1 animations:^{
        
        self.buttons.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        self.buttons.hidden = YES;
        
        // Update layouts with animation
        [UIView animateWithDuration:0.1 animations:^{
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            
        }];
        
    }];
}

- (void)showButtons
{
    self.buttons.alpha = 0;
    
    // Show Buttons
    [UIView animateWithDuration:0.1 animations:^{
        
        self.buttons.alpha = 1;
        
    } completion:^(BOOL finished) {
        
        self.buttons.hidden = NO;
        
        // Update layouts with animation
        [UIView animateWithDuration:0.1 animations:^{
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            
        }];
        
    }];
}

// MARK: - Private functions

- (void)introViewPage:(SFIntroView *)page atIndex:(NSInteger)pageIndex withObjets:(NSDictionary *)dic
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(presentedIntroViewPage:atIndex:withSFIntroObject:)]) {
        [self.delegate presentedIntroViewPage:page atIndex:pageIndex withSFIntroObject:dic];
    }
}

- (void)hideButton:(UIButton *)btn
{
    btn.alpha = 1;
    // Hide Buttons
    [UIView animateWithDuration:0.1 animations:^{
        
        btn.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        btn.hidden = YES;
        
        // Update layouts with animation
        [UIView animateWithDuration:0.1 animations:^{
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            
        }];
        
    }];
}

- (void)showButton:(UIButton *)btn
{
    btn.alpha = 0;
    // Show Buttons
    [UIView animateWithDuration:0.1 animations:^{
        
        btn.alpha = 1;
        
    } completion:^(BOOL finished) {
        
        btn.hidden = NO;
        
        // Update layouts with animation
        [UIView animateWithDuration:0.1 animations:^{
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            
        }];
        
    }];
}

@end

@implementation SFIntroView

- (void)initialize
{
    self.backgroundColor = [UIColor clearColor];
}

- (id)initWithCoder:(NSCoder *)aCoder
{
    if(self = [super initWithCoder:aCoder]){
        [self initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)rect
{
    if(self = [super initWithFrame:rect]){
        [self initialize];
    }
    return self;
}

@end
