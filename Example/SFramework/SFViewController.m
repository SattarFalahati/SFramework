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

@interface SFViewController () <SFInAppNotificationDelegate, SFImagePickerDelegate>

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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // SFLocationManager
    [SFLocationManager initGeoLocationManagerWithCompletitionBlock:^(CLLocationCoordinate2D currentLocation) {
        
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
    
    //MARK: - NSDate extentions test
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
    [self.btn setAttributedTitleWithString:@"  Open SFActionSheet  " withBaseFont:[UIFont systemFontOfSize:13] andBaseColor:RGB(151, 127, 45) withAttributedString:@"SFActionSheet" withAttributedFont:[UIFont boldSystemFontOfSize:15] andAttributedColor:[UIColor colorWithHexString:@"#afeeee"] forState:UIControlStateNormal];
    
    [self.btn setBackgroundColor:RGBA(0, 0, 0, 0.8)];
    [self.btn addCornerRadius:5];
    
    // SFImageView (SFNetworking)
    NSString *strImg = @"https://www.campsites.co.uk/getupload/campsite/20979/9edb6e5b-3789-423c-8cc4-5d267d451546/700/-/width/cobleland-campsite.jpg";
    
    [self.imgBG setImageWithURLString:strImg withPlaceholderImage:[UIImage imageNamed:@"Placeholder"] withActivityIndicator:nil withCompletionBlock:^(BOOL succeed, UIImage * _Nullable image) {
        
        // Do sth if needed
        if (succeed) {
            [self.imgBG setImage:image];
        }
    }];
}

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
            //            NSLog(@"%@",responseObject);
        }
        
        // SFUtils (hide progress hud)
        [SFProgressHUD hideProgressHUDFromView:self.view];
    }];
}


- (IBAction)selectorBtnDidSelect:(id)sender
{
    // SFALertController ( action sheet type )
    //    [self showActionSheet];
    //    [self initialInAppNotification];
    
    [self openSFImagePicker];
}

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
    [self presentViewController:next animated:YES completion:^{
        
    }];
}

- (void)selectedPhoto:(UIImage *)photo
{
    self.imgBG.image = photo;
}

@end
