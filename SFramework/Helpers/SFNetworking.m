//
//  SFNetworking.m
//  Pods
//
//  Created by Mac on 12/07/16.
//
//

#import "SFNetworking.h"

// Frameworks
#import <netinet/in.h>
#import "UIImageView+AFNetworking.h"

// Helpers
#import "SFObject.h"
#import "SFDefine.h"

// Defines
#define HTML @"HTML"
#define JSON @"JSON"

@implementation SFNetworking

// MARK: - NETWORK STATUS

+ (BOOL)isNetworkStatusActive
{
    if([AFNetworkReachabilityManager sharedManager].reachable){
        return YES;
    }
    if([self NetworkStatus] == YES){
        return YES;
    }
    return [self isHostReachable:ReachabilityURL];
}

+ (BOOL)isReachableWithoutRequiringConnection:(SCNetworkReachabilityFlags)flags
{
    BOOL isReachable = flags & kSCNetworkReachabilityFlagsReachable;
    BOOL noConnectionRequired = !(flags & kSCNetworkReachabilityFlagsConnectionRequired);
    if ((flags & kSCNetworkReachabilityFlagsIsWWAN)) {
        noConnectionRequired = YES;
    }
    return (isReachable && noConnectionRequired) ? YES : NO;
}

+ (BOOL)isHostReachable:(NSString *)host
{
    if (!host || ![host length]) {
        return NO;
    }
    SCNetworkReachabilityFlags flags;
    SCNetworkReachabilityRef reachability =  SCNetworkReachabilityCreateWithName(NULL, [host UTF8String]);
    BOOL gotFlags = SCNetworkReachabilityGetFlags(reachability, &flags);
    CFRelease(reachability);
    if (!gotFlags) {
        return NO;
    }
    return [self isReachableWithoutRequiringConnection:flags];
}

+ (BOOL)NetworkStatus
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr*)&zeroAddress);
    if(reachability != NULL) {
        SCNetworkReachabilityFlags flags;
        if (SCNetworkReachabilityGetFlags(reachability, &flags)) {
            if ((flags & kSCNetworkReachabilityFlagsReachable) == 0){
                return NO;
            }
            if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0){
                return YES;
            }
            if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||
                 (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0)){
                if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0){
                    return YES;
                }
            }
            if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN){
                return YES;
            }
        }
    }
    return NO;
}

+ (void)getNetworkConnectionStatuseWhenReachabilityStatuseIsChanege
{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                
                NSLog(@"The reachability status is Unknown");
                
                break;
            case AFNetworkReachabilityStatusNotReachable:
                
                NSLog(@"The reachability status is not reachable");
                
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                
                NSLog(@"The reachability status is reachable via WWAN");
                
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                
                NSLog(@"The reachability status is reachable via WiFi");
                
                break;
            default:
                
                NSLog(@"The reachability status is not found");
                
                break;
        }
    }];
}

// MARK: - REQUESTS

///  IMPORTANT Explanation : SFNetworking have different JSON functions , if user have to call HTML request he have to use main request and send HTML as content type

// MARK: get requests

/// GET request without authorization
+ (void)getRequestWithURLString:(NSString *)strURL withCompletionBlock:(SFNetworkingCompletionBlock)completionBlock
{
    [self networkConnectionWithType:@"GET" withContentType:JSON withURLRequestString:strURL withAuthorization:nil withOtherHTTPHeaderFields:nil withParams:nil forMultiPartRequest:nil completionBlock:completionBlock];
}

/// GET request with authorization
+ (void)getRequestWithURLString:(NSString *)strURL withAuthorization:(NSString *)authorization withCompletionBlock:(SFNetworkingCompletionBlock)completionBlock
{
    [self networkConnectionWithType:@"GET" withContentType:JSON withURLRequestString:strURL withAuthorization:authorization withOtherHTTPHeaderFields:nil withParams:nil forMultiPartRequest:nil completionBlock:completionBlock];
}

// MARK: post requests

/// POST request with params
+ (void)postRequestWithURLString:(NSString *)strURL withParams:(NSDictionary *)params withCompletionBlock:(SFNetworkingCompletionBlock)completionBlock
{
    [self networkConnectionWithType:@"POST" withContentType:JSON withURLRequestString:strURL withAuthorization:nil withOtherHTTPHeaderFields:nil withParams:params forMultiPartRequest:nil completionBlock:completionBlock];
}

/// POST request with params with authorization
+ (void)postRequestWithURLString:(NSString *)strURL withParams:(NSDictionary *)params withAuthorization:(NSString *)authorization withCompletionBlock:(SFNetworkingCompletionBlock)completionBlock
{
    [self networkConnectionWithType:@"POST" withContentType:JSON withURLRequestString:strURL withAuthorization:authorization withOtherHTTPHeaderFields:nil withParams:params forMultiPartRequest:nil completionBlock:completionBlock];
}

/// POST request with params with multipart
+ (void)multipartPostRequestWithURLString:(NSString *)strURL withParams:(NSDictionary *)params forMultiPartRequest:(SFNetworkingMultiPartCompletionBlock)multipartBlock withCompletionBlock:(SFNetworkingCompletionBlock)completionBlock
{
    [self networkConnectionWithType:@"POST" withContentType:JSON withURLRequestString:strURL withAuthorization:nil withOtherHTTPHeaderFields:nil withParams:params forMultiPartRequest:multipartBlock completionBlock:completionBlock];
}

/// POST request with params with multipart and authorization
+ (void)multipartPostRequestWithURLString:(NSString *)strURL withParams:(NSDictionary *)params withAuthorization:(NSString *)authorization forMultiPartRequest:(SFNetworkingMultiPartCompletionBlock)multipartBlock withCompletionBlock:(SFNetworkingCompletionBlock)completionBlock
{
    [self networkConnectionWithType:@"POST" withContentType:JSON withURLRequestString:strURL withAuthorization:authorization withOtherHTTPHeaderFields:nil withParams:params forMultiPartRequest:multipartBlock completionBlock:completionBlock];
}

// MARK: delete requests

/// DELETE request with params without authorization
+ (void)deleteRequestWithURLString:(NSString *)strURL withParams:(NSDictionary *)params withCompletionBlock:(SFNetworkingCompletionBlock)completionBlock
{
    [self networkConnectionWithType:@"DELETE" withContentType:JSON withURLRequestString:strURL withAuthorization:nil withOtherHTTPHeaderFields:nil withParams:params forMultiPartRequest:nil completionBlock:completionBlock];
}

/// DELETE request with params with authorization
+ (void)deleteRequestWithURLString:(NSString *)strURL withParams:(NSDictionary *)params withAuthorization:(NSString *)authorization withCompletionBlock:(SFNetworkingCompletionBlock)completionBlock
{
    [self networkConnectionWithType:@"DELETE" withContentType:JSON withURLRequestString:strURL withAuthorization:authorization withOtherHTTPHeaderFields:nil withParams:params forMultiPartRequest:nil completionBlock:completionBlock];
}

// MARK: put requests

/// PUT request with params without authorization
+ (void)putRequestWithURLString:(NSString *)strURL withParams:(NSDictionary *)params withCompletionBlock:(SFNetworkingCompletionBlock)completionBlock
{
    [self networkConnectionWithType:@"PUT" withContentType:JSON withURLRequestString:strURL withAuthorization:nil withOtherHTTPHeaderFields:nil withParams:params forMultiPartRequest:nil completionBlock:completionBlock];
}

/// PUT request with params with authorization
+ (void)putRequestWithURLString:(NSString *)strURL withParams:(NSDictionary *)params withAuthorization:(NSString *)authorization withCompletionBlock:(SFNetworkingCompletionBlock)completionBlock
{
    [self networkConnectionWithType:@"PUT" withContentType:JSON withURLRequestString:strURL withAuthorization:authorization withOtherHTTPHeaderFields:nil withParams:params forMultiPartRequest:nil completionBlock:completionBlock];
}

// MARK: main request

/*
 *** type            : @"GET" , @"POST" , @"DELETE" ...
 *** contentType     : application/json  , text/html
 *** strURL          : Request Url string
 *** params          : A dictionary of params for request body
 *** Authorization   : If request must have an authorization send the Authorization value (key) as a string
 *** HTTPHeaderFields: If request must have more than one header field pass it as a key valu object (dictionary)
 *** multiPart       : If it is a multi part request base on web service programmer have to create [formData appendPartWithFileData:nil name:nil fileName:nil mimeType:nil]; to send it as completition multi part block
 */

/// make a request
+ (void)networkConnectionWithType:(NSString *)type withContentType:(NSString *)contentType withURLRequestString:(NSString *)strURL withAuthorization:(NSString *)authorization withOtherHTTPHeaderFields:(NSDictionary *)HTTPHeaderFields withParams:(NSDictionary *)params forMultiPartRequest:(SFNetworkingMultiPartCompletionBlock)multipartBlock completionBlock:(SFNetworkingCompletionBlock)completionBlock
{
    // Check if type is empty
    if ([type isEmpty]) {
        if (completionBlock) {
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey:@""}; // Fixme : show error
            NSError *err = [NSError errorWithDomain:@"" code:code_Generic userInfo:nil];
            completionBlock(code_MandatoryFieldEmpty,nil,err);
        }
        return;
    }
    
    // Check if strUrl is empty
    if ([strURL isEmpty]) {
        if (completionBlock) {
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey:@""}; // Fixme : show error
            NSError *err = [NSError errorWithDomain:@"" code:code_Generic userInfo:nil];
            completionBlock(code_MandatoryFieldEmpty,nil,err);
        }
        return;
    }
    
    // Check Done , lets start the request using AFHTTPSessionManager && NSURLSessionDataTask
    
    // A : create AFHTTPSessionManager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    
    if ([contentType isEqualToString:JSON]) {
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json"]];
    }
    else if  ([contentType isEqualToString:HTML]) {
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/html"]];
    }
    
    // B : Check for Authorization
    if ([authorization isNotEmpty]) [manager.requestSerializer setValue:authorization forHTTPHeaderField:@"Authorization"];
    
    // C : Get all HTTP Header Fields
    if ([HTTPHeaderFields isNotEmpty]) {
        for (NSString *key in [HTTPHeaderFields allKeys]) {
            NSString *str = HTTPHeaderFields[key];
            [manager.requestSerializer setValue:str forHTTPHeaderField:key];
        }
    }
    
    // D : Create Mutable URL Request
    NSMutableURLRequest *request = nil;
    
    // D-1 : Check if its multi part or not
    if (multipartBlock) {
        request = [manager.requestSerializer multipartFormRequestWithMethod:type URLString:strURL parameters:params constructingBodyWithBlock:multipartBlock error:nil];
    }
    else {
        request = [manager.requestSerializer requestWithMethod:type URLString:strURL parameters:params error:nil];
    }
    
    // E : create NSURLSessionDataTask
    NSURLSessionDataTask  *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        // 1 : we have result hide Network Activity Indicator
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        // 2 : Check for the error
        if (error != nil) {
            if (completionBlock) completionBlock(code_NetworkTaskError,nil,error);
        }
        else {
            if (completionBlock) completionBlock(code_Success,responseObject,nil);
        }
        
    }];
    
    // F : show Network Activity Indicator
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    // G : run data task to make a call
    [dataTask resume];
}

@end

// MARK: - SFImageView

@implementation UIImageView (SFNetworking)

/// A function to set image from a URLString with placeholder and activity indicator , which will return downloaded Image and a succeed flag.

- (void)setImageWithURLString:(nonnull NSString *)URLString withPlaceholderImage:(nullable UIImage *)placeholder withActivityIndicator:(nullable UIActivityIndicatorView *)activityIndicator withCompletionBlock:(void ( ^ _Nullable )(BOOL succeed,  UIImage * _Nullable image))completionBlock
{
    self.image = nil;
    
    // Check URLString
    if (!URLString || [URLString isEmpty]) {
        if (completionBlock) completionBlock(NO, nil);
        return;
    }
    
    // Start Activity indicator
    [activityIndicator startAnimating];
    
    // Download the image
    NSURL *URL = [NSURL URLWithString:URLString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:URL];
    __block UIImageView *blockImageView = self;
    
    [self setImageWithURLRequest:request placeholderImage:placeholder success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        [blockImageView setImage:image];
        [activityIndicator stopAnimating];
        if (completionBlock) completionBlock(YES, image);
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        [activityIndicator stopAnimating];
        if (completionBlock) completionBlock(NO, nil);
    }];
}

@end
