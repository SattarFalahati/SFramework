//
//  SFViewController.m
//  SFramework
//
//  Created by sattar_falahati on 06/19/2016.
//  Copyright (c) 2016 sattar_falahati. All rights reserved.
//

#import "SFViewController.h"

// View controllers
#import "SFImagePicker.h"
#import "SFIntro.h"

@interface SFViewController () <SFInAppNotificationDelegate, SFImagePickerDelegate, SFIntroDelegate>

@property (strong, nonatomic) SFIntro *intro;

@end

@implementation SFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self applyCustomGraphic];
    
    // SFString
    NSString *str = [NSString randomStringWithLength:10]; // Create random string with length
    NSLog(@"%@",str);
    
    // SFNetworking
    [self testNetworkConnection];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //MARK: - SFLocationManager
    [SFLocationManager initGeoLocationManagerWithCompletitionBlock:^(CLLocationCoordinate2D currentLocation, CLAuthorizationStatus status) {
        
        if ([SFLocationManager isValidPosition:currentLocation]) {
            NSLog(@"position is valid");
        }
        
        [SFLocationManager getAddressFromCoordinate:currentLocation withSuccessBlock:^(NSDictionary *dicAddress, NSString *strAddress, NSString *strCitty, NSString *strZipCode) {
            
            NSLog(@"\n %@ \n %@ \n %@ \n ", strCitty, strZipCode, strAddress);
            
        } andFailureBlock:^(NSError *error) {
            NSLog(@"Error : %@", error);
        }];
        
        [SFLocationManager stopGeoLocationManager];
    }];
    
    //MARK: - NSDate extentions
    NSDate *endDate = [[NSDate date] addMonth:0 addDays:1 addHours:1];
    
    [NSDate countdownFromNowToDate:endDate withCompletitionBlock:^(NSInteger year, NSInteger month, NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
        NSString *countdownText = [NSString stringWithFormat:@"%ld Year %ld Month %ld Days %ld Hours %ld Minutes %ld secoond", (long)year, (long)month, (long)day, (long)hour, (long)minute, (long)second];
        NSLog(@"%@",countdownText);
    }];
    
    NSDate *myBirthDate = [NSDate convertStringToDateWithDateString:@"1988-07-05 12:23:34" withOrginalFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *now = [NSDate getNowDateWithFormat:@"yyyy"];
    NSNumber *ageDifference = [NSDate getCalculatedYearDifferenceBetweenfirstDate:myBirthDate andSecondDate:now];
    NSLog(@"age Difference = %@",ageDifference);
    
    NSString *strMinutes = [myBirthDate convertHoursToMinutes];
    NSLog(@"Hours to Minutes = %@",strMinutes);
    
}

// MARK: UI

- (void)applyCustomGraphic
{
    // SFColor (ways to set color)
    [self.view setBackgroundColor:RGB(151, 127, 45)];
    // [self.view setBackgroundColor:[UIColor colorWithHexString:@"#afeeee"]];
    
    // SFLable
    [self.lblTitle setAttributedTextWithString:@"  Wellcome to SFramework  " withBaseFont:[UIFont systemFontOfSize:13] andBaseColor:[UIColor whiteColor] withAttributedString:@"SFramework" withAttributedFont:[UIFont boldSystemFontOfSize:15] andAttributedColor:[UIColor redColor]];
    
    [self.lblTitle setBackgroundColor:RGBA(0, 0, 0, 0.8)];
    [self.lblTitle addCornerRadius:5];
    
    // SFButton
    
    [self.btnActionSheet setAttributedTitleWithString:@"  Open SFActionSheet  " withBaseFont:[UIFont systemFontOfSize:13] andBaseColor:RGB(151, 127, 45) withAttributedString:@"SFActionSheet" withAttributedFont:[UIFont boldSystemFontOfSize:15] andAttributedColor:[UIColor colorWithHexString:@"#afeeee"] forState:UIControlStateNormal];
    
    [self.btnActionSheet setBackgroundColor:RGBA(0, 0, 0, 0.8)];
    [self.btnActionSheet addCornerRadius:5];
    self.btnActionSheet.option = SFButtonBounce; // To animate
    
    self.btnGallery.option = SFButtonBounce;
    self.btnGallery.backgroundColor = RGBA(0, 0, 0, 0.5);
    [self.btnGallery makeViewCircular];
    
    self.btnIntro.option = SFButtonNormal;
    self.btnIntro.backgroundColor = RGBA(0, 0, 0, 0.5);
    [self.btnIntro makeViewCircular];
    
    // SFImageView (SFNetworking)
//    NSString *strImg = @"https://www.campsites.co.uk/getupload/campsite/20979/9edb6e5b-3789-423c-8cc4-5d267d451546/700/-/width/cobleland-campsite.jpg";
    
//    [self.imgBG setImageWithURLString:strImg withPlaceholderImage:[UIImage imageNamed:@"Placeholder"] withActivityIndicator:nil withCompletionBlock:^(BOOL succeed, UIImage * _Nullable image) {
//        
//        // Do sth if needed
//        if (succeed) {
//            [self.imgBG setImage:image];
//        }
//    }];
    
//    self.imgBG.image = [UIImage gradiantImageForView:self.imgBG withColors:@[kCWhite, kCLightBlue, kCDarkBlue] withDirection:SFImageGradiantDirectionFromBottomLeftToTopRight];

    
    self.imgBG.image = [UIImage generateRandomImageColor];
    
    
//    self.imgBG.image = [UIImage combinedPhotosWithBackgroundImage:[UIImage imageNamed:@"trolltunga"] withBGImageFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) andTopImage:[UIImage imageNamed:@"Placeholder"]  withTopImageFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100) withTopImageAlpha:0.5f];
    
    
    /// Constraints
    self.btnActionSheet.constraintHeight = 55;
    
    // Btn Parallax
    self.btnOpenParallax.option = SFButtonBounce;
    self.btnOpenParallax.backgroundColor = RGBA(0, 0, 0, 0.5);
    [self.btnOpenParallax addCornerRadius:self.btnOpenParallax.frame.size.height /2];


}

// MARK: SFNetworking

- (void)testNetworkConnection
{
    if (![SFNetworking isNetworkStatusActive]) {
        [SFAlertController showAlertNetworkIsNotConnectOnTarget:self withRetryBlock:^{
            [self testNetworkConnection];
        } withCancelBlock:^{
            // Do sth if needed
        }];
        return;
    }
    
    // SFUtils (show progress hud)
    [SFProgressHUD showProgressHUDWithMessage:@"Loading ..." onView:self.view];
    
    NSString *strURL = @"http://jsonplaceholder.typicode.com/todos";
    
    // SFNetworking GET method
    [SFNetworking getRequestWithURLString:strURL withCompletionBlock:^(ErrorCode errorCode, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (errorCode == code_Success) {
            // NSLog(@"%@",responseObject);
        }
        
        // SFUtils (hide progress hud)
        [SFProgressHUD hideProgressHUDFromView:self.view];
    }];

}

// MARK: Action

- (IBAction)selectorBtnActionSheetDidSelect:(id)sender
{
    // SFALertController ( action sheet type )
    [self showActionSheet];
    // [self initialInAppNotification];
    
}

- (IBAction)btnGallery:(id)sender
{
    [self openSFImagePicker];
}

- (IBAction)btnIntro:(id)sender
{
    [self.btnIntro rotateButton];
    [self initSFIntro];
}

// MARK: Action Sheet

- (void)showActionSheet{
    [SFAlertController showActionSheetWithOneButtonOnTarget:self withTitle:@"Call" withMessage:@"Do you want to call to this number : 123456" withButtonTitle:@"Yes" andButtonBlock:^{
        [SFUtils callToNumber:@"3246128309"];
    } withCancelButtonTitle:@"No" withBlock:^{
        
    }];
}

//MARK: - InAppNotification and Delegate

- (void)initialInAppNotification
{
    SFInAppNotification *inAppNotifView = [SFInAppNotification showSFInAppNotificationOnView:self.view withTitle:@"This is A Title This is A Title A Title This is A Title A Title This is A Title A Title This is A Title A Title This is A Title A Title This is A Title A Title This is A Title " withSubtitle:@"This is a subtitle This is a subtitle This is a subtitle This is a subtitle This is a subtitle This is a subtitle This is a subtitle  This is a subtitle T This is a subtitle T This is a subtitle T" withImage:[UIImage imageNamed:@"Placeholder"] withDismissalDuration:0 withDelegate:self withTapHandler:^{
        
        NSLog(@"TAP");
    } withSwipeHandler:^{
        
        NSLog(@"SWIPE");
    } withDismissHandler:^{
        
        NSLog(@"DISMISS");
    }];
    
    [inAppNotifView setTitleFont:[UIFont systemFontOfSize:18] andColor:[UIColor greenColor]];
    [inAppNotifView setSFInAppNotificationBackGroundColor:[UIColor whiteColor]];
    [inAppNotifView setSubtitleFont:[UIFont systemFontOfSize:12] andColor:[UIColor redColor]];
    [inAppNotifView setBackgroundColor:RGBA(0, 0, 0, .8)];
}

- (void)SFInAppNotificationWillAppear:(SFInAppNotification *)notification
{
    NSLog(@"WILL APPEAR");
}

-(void)SFInAppNotificationDidAppear:(SFInAppNotification *)notification
{
    NSLog(@"DID APPEAR");
}

-(void)SFInAppNotificationWillDisimiss:(SFInAppNotification *)notification
{
    NSLog(@"WILL DISMISS");
}

- (void)SFInAppNotificationDidDismiss:(SFInAppNotification *)notification
{
    NSLog(@"DID DISMISS");
}


//MARK: - SFImagePicker and Delegate

- (void)openSFImagePicker
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ImagePicker" bundle:nil];
    SFImagePicker *next = [storyboard instantiateViewControllerWithIdentifier:@"SFImagePicker"];
    next.delegate = self;
    next.option = SFImagePickerCameraFront;
    next.showPreview = YES;
    [self presentViewController:next animated:YES completion:^{
        
    }];
}

- (void)selectedPhoto:(UIImage *)photo
{
    self.imgBG.image = photo;
}

//MARK: - SFIntro && delegate

- (void)initSFIntro
{
    NSArray *arr = @[@{kSFIntroObjectImage : @"trolltunga",
                       kSFIntroObjectTitle : @"Trolltunga is amazing",
                       kSFIntroObjectDescription : @"One day i'll go there and took some amazing picture to hold in my life album.\n This is my goal and i have to gain it before next summer. \n This is a promiss to myself",
                       },
                     @{kSFIntroObjectImage : @"colorFullLife",
                       kSFIntroObjectTitle : @"Color Full Life",
                       kSFIntroObjectDescription : @"“Failure is simply the opportunity to begin again, this time more intelligently.”\n Henry Ford",
                       },
                     @{kSFIntroObjectImage : @"Placeholder",
                       kSFIntroObjectTitle : @"title for third page",
                       kSFIntroObjectDescription : @"This is a description for third page",
                       },
                     ];
    
    self.intro = [SFIntro initWithFrame:self.view.frame withParallaxBackgroundImage:@"BG" withDelegate:self withDataSourceArray:arr];
    
    
    self.intro.alpha = 0;
    [self.view addSubview:self.intro];
    
    // Open the page
    [UIView animateWithDuration:0.7f animations:^{
        self.intro.alpha = 1;
    } completion:^(BOOL finished) {
    }];
}

- (void)firstButtonDidSelectWithIntro:(SFIntro *)intro
{
    // Close the page
    [UIView animateWithDuration:0.7f animations:^{
        self.intro.alpha = 0;
    } completion:^(BOOL finished) {
        [self.intro removeFromSuperview];
    }];
}

- (void)secondButtonDidSelectWithIntro:(SFIntro *)intro
{
    [self.intro goToPageAtIndex:1];
}

- (void)presentedIntroViewPage:(SFIntroView *)page atIndex:(NSInteger)pageIndex withSFIntroObject:(NSDictionary *)dicSFIntroObject
{
    NSLog(@"%lu", (unsigned long)pageIndex);
    
    if (pageIndex == 2) {
        [page.lblTitle setText:@"Go fuck yourself"];
    }
}

- (void)presentedIntroPage:(SFIntro *)intro atIndex:(NSUInteger)pageIndex
{
    //    NSLog(@"%lu", (unsigned long)pageIndex);
    if (pageIndex+1 == intro.arrContent.count) {
        [intro hideSecondButton];
    }
    else {
        [intro showSecondButton];
    }
}

// MARK: - SFParallaxView

- (IBAction)openParallaxView:(id)sender
{
    [self performSegueWithIdentifier:@"goToParallax" sender:nil];
}


@end
