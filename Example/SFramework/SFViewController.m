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
    
    // Collor test
    [self.view setBackgroundColor:RGB(151, 127, 45)];
    // [self.view setBackgroundColor:[UIColor colorWithHexString:@"#afeeee"]];
    
    NSString *str = [NSString randomStringWithLength:10];
    NSLog(@"%@",str);
    
    NSString *strImg = @"https://www.campsites.co.uk/getupload/campsite/20979/9edb6e5b-3789-423c-8cc4-5d267d451546/700/-/width/cobleland-campsite.jpg";
    
    [self.imgBG setImageWithURLString:strImg withPlaceholderImage:[UIImage imageNamed:@"Placeholder"] withActivityIndicator:nil withCompletionBlock:^(BOOL succeed, UIImage * _Nullable image) {
        // Do sth if needed
        NSLog(@"This is a test");
    }];
    
    [self testNetworkConnection];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
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
    
    
    [SFUtils showProgressHUDWithMessage:@"Loading ..." onView:self.view];
    
    NSString *strURL = @"http://jsonplaceholder.typicode.com/todos";
    
    [SFNetworking getRequestWithURLString:strURL withCompletionBlock:^(ErrorCode errorCode, id  _Nullable responseObject, NSError * _Nullable error) {
        
        NSLog(@"%@",responseObject);
        
        [self showActionSheet];
        
        [SFUtils hideProgressHUDFromView:self.view];
    }];
}

- (void)showActionSheet
{
    [SFAlertController showActionSheetWithOneButtonOnTarget:self withTitle:@"Call" withMessage:@"Do you want to call to this number : 123456" withButtonTitle:@"Yes" andButtonBlock:^{
        [SFUtils callToNumber:@"3246128309"];
    } withCancelButtonTitle:@"No" withBlock:^{
        
    }];}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
