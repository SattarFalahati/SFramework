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
	
    [self.view setBackgroundColor:CBlack]; // Collor test
    
    NSString *strURL = @"http://jsonplaceholder.typicode.com/todos";
    
    [SFNetworking networkConnectionWithType:@"GET" withURLRequestString:strURL withAuthorization:nil withOtherHTTPHeaderFields:nil withParams:nil forMultiPartRequest:nil completionBlock:^(ErrorCode errorCode, id  _Nullable responseObject, NSError * _Nullable error) {
        NSLog(@"%@",responseObject);
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
