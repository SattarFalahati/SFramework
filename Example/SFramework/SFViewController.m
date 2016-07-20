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
    
    [self testNetworkConnection];
}


- (void)testNetworkConnection
{
    if ([SFNetworking isNetworkStatusActive]) {
        [SFAlertView showAlertNetworkIsNotConnectOnTarget:self withRetryBlock:^{
            [self testNetworkConnection];
        } withCancelBlock:^{
            // Do sth if needed
        }];
        return;
    }
    
    [SFUtils showProgressHUDWithMessage:@"Loading ..." onView:self.view];
    
    NSString *strURL = @"http://jsonplaceholder.typicode.com/todos";
    
    [SFNetworking networkConnectionWithType:@"GET" withURLRequestString:strURL withAuthorization:nil withOtherHTTPHeaderFields:nil withParams:nil forMultiPartRequest:nil completionBlock:^(ErrorCode errorCode, id  _Nullable responseObject, NSError * _Nullable error) {
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
