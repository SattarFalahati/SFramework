//
// Licensed under the terms in License.txt
//
// Copyright 2010 Allen Ding. All rights reserved.
//

#import "KiwiConfiguration.h"

@protocol KWInvocationCapturerDelegate;

@interface KWInvocationCapturer : NSProxy

// MARK: - Initializing

- (id)initWithDelegate:(id)aDelegate;
- (id)initWithDelegate:(id)aDelegate userInfo:(NSDictionary *)aUserInfo;

+ (id)invocationCapturerWithDelegate:(id)aDelegate;
+ (id)invocationCapturerWithDelegate:(id)aDelegate userInfo:(NSDictionary *)aUserInfo;

// MARK: - Properties

@property (nonatomic, weak, readonly) id delegate;
@property (nonatomic, strong, readonly) NSDictionary *userInfo;

@end

@protocol KWInvocationCapturerDelegate

// MARK: - Capturing Invocations

- (NSMethodSignature *)invocationCapturer:(KWInvocationCapturer *)anInvocationCapturer methodSignatureForSelector:(SEL)aSelector;
- (void)invocationCapturer:(KWInvocationCapturer *)anInvocationCapturer didCaptureInvocation:(NSInvocation *)anInvocation;

@end
