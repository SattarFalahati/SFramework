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

#pragma mark - REQUESTS

///  IMPORTANT Explanation : SFNetworking have different JSON functions , if user have to call HTML request he have to use main request and send HTML as content type.

/// Completion Block that will be used for response of the request if request not succeed it will return error otherwise it will return response objects
typedef void (^SFNetworkingCompletionBlock)(ErrorCode errorCode, id  _Nullable responseObject, NSError * _Nullable error);

/// Completion Block for Multi part
typedef void (^SFNetworkingMultiPartCompletionBlock)(id <AFMultipartFormData> _Nullable formData);

#pragma mark get request

/// GET request without authorization
+ (void)getRequestWithURLString:(nonnull NSString *)strURL withCompletionBlock:(nullable SFNetworkingCompletionBlock)completionBlock;

/// GET request with authorization
+ (void)getRequestWithURLString:(nonnull NSString *)strURL withAuthorization:(nullable NSString *)authorization withCompletionBlock:(nullable SFNetworkingCompletionBlock)completionBlock;

#pragma mark post requests

/// POST request with params
+ (void)postRequestWithURLString:(nonnull NSString *)strURL withParams:(nullable NSDictionary *)params withCompletionBlock:(nullable SFNetworkingCompletionBlock)completionBlock;

/// POST request with params with authorization
+ (void)multipartPostRequestWithURLString:(nonnull NSString *)strURL withParams:(nullable NSDictionary *)params withAuthorization:(nullable NSString *)authorization withCompletionBlock:(nullable SFNetworkingCompletionBlock)completionBlock;

/// POST request with params with multipart
+ (void)postRequestWithURLString:(nonnull NSString *)strURL withParams:(nullable NSDictionary *)params forMultiPartRequest:(nullable SFNetworkingMultiPartCompletionBlock)multipartBlock withCompletionBlock:(nullable SFNetworkingCompletionBlock)completionBlock;

/// POST request with params with multipart and authorization
+ (void)multipartPostRequestWithURLString:(nonnull NSString *)strURL withParams:(nullable NSDictionary *)params withAuthorization:(nullable NSString *)authorization forMultiPartRequest:(nullable SFNetworkingMultiPartCompletionBlock)multipartBlock withCompletionBlock:(nullable SFNetworkingCompletionBlock)completionBlock;

#pragma mark delete requests

/// DELETE request with params without authorization
+ (void)deleteRequestWithURLString:(nonnull NSString *)strURL withParams:(nullable NSDictionary *)params withCompletionBlock:(nullable SFNetworkingCompletionBlock)completionBlock;

/// DELETE request with params with authorization
+ (void)deleteRequestWithURLString:(nonnull NSString *)strURL withParams:(nullable NSDictionary *)params withAuthorization:(nullable NSString *)authorization withCompletionBlock:(nullable SFNetworkingCompletionBlock)completionBlock;

#pragma mark put requests

/// PUT request with params without authorization
+ (void)putRequestWithURLString:(nonnull NSString *)strURL withParams:(nullable NSDictionary *)params withCompletionBlock:(nullable SFNetworkingCompletionBlock)completionBlock;

/// PUT request with params with authorization
+ (void)putRequestWithURLString:(nonnull NSString *)strURL withParams:(nullable NSDictionary *)params withAuthorization:(nullable NSString *)authorization withCompletionBlock:(nullable SFNetworkingCompletionBlock)completionBlock;

#pragma mark main request

/// make a request
/*
 *** type            : @"GET" , @"POST" , @"DELETE" ...
 *** contentType     : application/json  , text/html
 *** strURL          : Request Url string
 *** params          : A dictionary of params for request body
 *** Authorization   : If request must have an authorization send the Authorization value (key) as a string
 *** HTTPHeaderFields: If request must have more than one header field pass it as a key valu object (dictionary)
 *** multiPart       : If it is a multi part request base on web service programmer have to create [formData appendPartWithFileData:nil name:nil fileName:nil mimeType:nil]; to send it as completition multi part block *** if block is empty
 */
+ (void)networkConnectionWithType:(nonnull NSString *)type withContentType:(nonnull NSString *)contentType withURLRequestString:(nonnull NSString *)strURL withAuthorization:(nullable NSString *)authorization withOtherHTTPHeaderFields:(nullable NSDictionary *)HTTPHeaderFields withParams:(nullable NSDictionary *)params  forMultiPartRequest:(nullable SFNetworkingMultiPartCompletionBlock)multipartBlock completionBlock:(nullable SFNetworkingCompletionBlock)completionBlock;

@end

#pragma mark - SFImageView

@interface UIImageView (SFNetworking)

/// A function to set image from a URLString with placeholder and activity indicator , which will return downloaded Image and a succeed flag.
- (void)setImageWithURLString:(nonnull NSString *)URLString withPlaceholderImage:(nullable UIImage *)placeholder withActivityIndicator:(nullable UIActivityIndicatorView *)activityIndicator withCompletionBlock:(void ( ^ _Nullable )(BOOL succeed,  UIImage * _Nullable image))completionBlock;

@end
