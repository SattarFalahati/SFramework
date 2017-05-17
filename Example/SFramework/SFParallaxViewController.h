//
//  SFParallaxViewController.h
//  SFramework
//
//  Created by Sattar Falahati on 12/05/17.
//  Copyright © 2017 sattar_falahati. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SFParallaxViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet SFParallaxView *parallaxView;
@property (strong, nonatomic) IBOutlet SFCarousel *carousel;

@end
