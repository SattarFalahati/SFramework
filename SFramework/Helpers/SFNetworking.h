//
//  SFNetworking.h
//  Pods
//
//  Created by Mac on 12/07/16.
//
//

#import <Foundation/Foundation.h>

// Frameworks
#import "AFNetworking.h"

typedef NS_ENUM(NSInteger, ErrorCode)
{
    code_Success = 0,
    code_InvalidToken,
    code_MandatoryFieldEmpty,
    code_Generic,
    code_NoNetworkConnection,
    code_NetworkTaskError,
    code_Ok
    
};

@interface SFNetworking : NSObject

#pragma mark - NETWORK STATUS

+ (BOOL)isNetworkStatusActive;
+ (BOOL)isReachableWithoutRequiringConnection:(SCNetworkReachabilityFlags)flags;
+ (BOOL)isHostReachable:(nullable NSString *)host;
+ (BOOL)NetworkStatus;
/// This method is a helper to know when reachability status is changing
+ (void)getNetworkConnectionStatuseWhenReachabilityStatuseIsChanege;

#pragma mark - REQUEST

/// Completion Block that will be used for response of the request if request not succeed it will return error otherwise it will return response objects
typedef void (^SFNetworkingCompletionBlock)(ErrorCode errorCode, id  _Nullable responseObject, NSError * _Nullable error);

/// Completion Block for Multi part
typedef void (^SFNetworkingMultiPartCompletionBlock)(id <AFMultipartFormData> _Nullable formData);

/// make a request
/*
    *** type            : @"GET" , @"POST" , @"DELETE" ...
    *** strURL          : Request Url string
    *** params          : A dictionary of params for request body
    *** Authorization   : If request must have an authorization send the Authorization value (key) as a string
    *** HTTPHeaderFields: If request must have more than one header field pass it as a key valu object (dictionary)
    *** multiPart       : If it is a multi part request base on web service programmer have to create [formData appendPartWithFileData:nil name:nil fileName:nil mimeType:nil]; to send it as completition multi part block *** if block is empty 
*/
+ (void)networkConnectionWithType:(nonnull NSString *)type withURLRequestString:(nonnull NSString *)strURL withAuthorization:(nullable NSString *)authorization withOtherHTTPHeaderFields:(nullable NSDictionary *)HTTPHeaderFields withParams:(nullable NSDictionary *)params  forMultiPartRequest:(nullable SFNetworkingMultiPartCompletionBlock)multipartBlock completionBlock:(nullable SFNetworkingCompletionBlock)completionBlock;
@end
