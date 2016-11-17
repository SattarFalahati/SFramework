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
    
    NSString *strImg = @"http://www.qdtricks.org/wp-content/uploads/2015/12/2016-iphone-6-wallpaper.jpg";
    
    [self.imgBG setImageWithURLString:strImg withPlaceholderImage:[UIImage imageNamed:@"Placeholder"] withActivityIndicator:nil withCompletionBlock:^(BOOL succeed, UIImage * _Nullable image) {
        // Do sth if needed
        
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
        [SFUtils hideProgressHUDFromView:self.view];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
