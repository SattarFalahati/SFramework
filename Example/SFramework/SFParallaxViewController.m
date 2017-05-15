//
//  SFParallaxViewController.m
//  SFramework
//
//  Created by Sattar Falahati on 12/05/17.
//  Copyright © 2017 sattar_falahati. All rights reserved.
//

#import "SFParallaxViewController.h"

@interface SFParallaxViewController () <UIScrollViewDelegate>

@end

@implementation SFParallaxViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.parallaxView setupParallaxView];
    self.scrollView.delegate = self;
    
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

@end
