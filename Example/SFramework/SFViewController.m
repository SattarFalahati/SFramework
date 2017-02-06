//
//  SFViewController.m
//  SFramework
//
//  Created by sattar_falahati on 06/19/2016.
//  Copyright (c) 2016 sattar_falahati. All rights reserved.
//

#import "SFViewController.h"


@interface SFViewController ()

@end

@implementation SFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self applyCustomeGrafic];
    
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
    
}

- (void)applyCustomeGrafic
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
    [SFUtils showProgressHUDWithMessage:@"Loading ..." onView:self.view];
    
    NSString *strURL = @"http://jsonplaceholder.typicode.com/todos";
    
    // SFNetworking GET method
    [SFNetworking getRequestWithURLString:strURL withCompletionBlock:^(ErrorCode errorCode, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (errorCode == code_Success) {
            NSLog(@"%@",responseObject);
        }
        
        // SFUtils (hide progress hud)
        [SFUtils hideProgressHUDFromView:self.view];
    }];
}


- (IBAction)selectorBtnDidSelect:(id)sender
{
    // SFALertController ( action sheet type )
    [self showActionSheet];
}

- (void)showActionSheet
{
    [SFAlertController showActionSheetWithOneButtonOnTarget:self withTitle:@"Call" withMessage:@"Do you want to call to this number : 123456" withButtonTitle:@"Yes" andButtonBlock:^{
        [SFUtils callToNumber:@"3246128309"];
    } withCancelButtonTitle:@"No" withBlock:^{
        
    }];
}


@end
