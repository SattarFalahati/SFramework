//
//  SFParallaxViewController.m
//  SFramework
//
//  Created by Sattar Falahati on 12/05/17.
//  Copyright © 2017 sattar_falahati. All rights reserved.
//

#import "SFParallaxViewController.h"

@interface SFParallaxViewController () <UIScrollViewDelegate, SFCarouselDelegate>

@end

@implementation SFParallaxViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.parallaxView setupParallaxView];
    self.scrollView.delegate = self;
    
    // local images
    NSArray *imageArray = @[@"http://i1.piimg.com/4851/859cc36239f5a49e.png",
                            @"http://i1.piimg.com/4851/a47d409e267eb871.png",
                            [UIImage generateRandomImageColor],
                            [UIImage generateRandomImageColor],
                            [UIImage generateRandomImageColor]];
    
    [self.carousel setImageArrary:imageArray withPlaceholderImage:[UIImage imageNamed:@"Placeholder"] withDelegate:self];
    [self.carousel setBasePageIndicatorColor:kCRed];
    [self.carousel setCurrentPageIndicatorColor:kCYellow];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

// MARK: - Scrollview Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.parallaxView parallaxWithScroll:scrollView];
    [self.view layoutIfNeeded];
}

// MARK: - SFCarousel Delegate

- (void)carouselViewDidSelectImageAtIndex:(NSInteger)index
{
    NSLog(@"Selected image");
}

@end
