//
//  SFParallaxView.h
//  Pods
//
//  Created by Sattar Falahati on 11/05/17.
//
//

#import <UIKit/UIKit.h>

/** 
 * SFParallaxView
 *
 * This class will help to have a parallax view inside a UIScrollView
 *
 * How it works ? 
 * Create a view in storyboard and set the Custom class to SFParallaxView then set constriants (Top, Bottom, left, right, height) in 'viewDidLoaed' call 'setupParallaxView' and in scrollview delegate method (scrollViewDidScroll) call 'parallaxWithScroll:scrollView'
 * In case you want to have an image in this view insert imageView Or SFcarousel (from stroyboard) into SFParallaxView then add constraint (Bottom, left, right, equal height to the SFParallaxView.
 *
 * TIPS: 1) Don't forget about clip to bounds and aspect fill for image
         2) Don't set topConstraint for image to the SFParallaxView.
 
 */


@interface SFParallaxView : UIView

/// Prepare and setup elements to have parallax effect
- (void)setupParallaxView;

/// Call this method in scrollview delegate method (scrollViewDidScroll) to do the parallax magic.
- (void)parallaxWithScroll:(UIScrollView *)scrollView;

@end
