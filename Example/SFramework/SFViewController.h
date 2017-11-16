//
//  SFViewController.h
//  SFramework
//
//  Created by sattar_falahati on 06/19/2016.
//  Copyright (c) 2016 sattar_falahati. All rights reserved.
//

@import UIKit;

@interface SFViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imgBG;

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet SFButton *btnActionSheet;
@property (weak, nonatomic) IBOutlet UIButton *btnGallery;
@property (weak, nonatomic) IBOutlet UIButton *btnIntro;
@property (weak, nonatomic) IBOutlet UIButton *btnOpenParallax;

@end
