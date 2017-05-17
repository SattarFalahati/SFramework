//
//  SFParallaxView.m
//  Pods
//
//  Created by Sattar Falahati on 11/05/17.
//
//

#import "SFParallaxView.h"

// Helper
#import "SFConstraints.h"

@interface SFParallaxView()

@property (strong, nonatomic) NSLayoutConstraint *topConstraint;
@property (strong, nonatomic) NSLayoutConstraint *heightConstraint;
@property (nonatomic) float originalHeight;

@end

@implementation SFParallaxView

- (void)setupParallaxView
{
    // Setup constraints
    self.topConstraint = [self constraintWithAttribute:NSLayoutAttributeTop];
    self.heightConstraint = [self constraintWithAttribute:NSLayoutAttributeHeight];

    // Original height
    self.originalHeight = self.constraintHeight;
}

- (void)parallaxWithScroll:(UIScrollView *)scrollView
{
    // Do the parallax magic
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat height = self.originalHeight - offset;
    
//     NSLog(@"height == %f", height);
//     NSLog(@"offset == %f", offset);
    
    self.topConstraint.constant = offset;
    
    if (height >= 0) {
        self.heightConstraint.constant = height;
    }
    else {
        self.heightConstraint.constant = 0;
    }
}


@end
