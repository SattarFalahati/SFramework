//
// Licensed under the terms in License.txt
//
// Copyright 2010 Allen Ding. All rights reserved.
//

#import "KiwiConfiguration.h"

@interface NSInvocation(KiwiAdditions)

// MARK: - Creating NSInvocation Objects

+ (NSInvocation *)invocationWithTarget:(id)anObject selector:(SEL)aSelector;
+ (NSInvocation *)invocationWithTarget:(id)anObject selector:(SEL)aSelector messageArguments:(const void *)firstBytes, ...;

// MARK: - Accessing Message Arguments

// Message arguments are invocation arguments that begin after the target and selector arguments. These methods provide
// convenient ways to access them.

- (NSData *)messageArgumentDataAtIndex:(NSUInteger)anIndex;
- (void)getMessageArgument:(void *)buffer atIndex:(NSUInteger)anIndex;
- (void)setMessageArgument:(const void *)bytes atIndex:(NSUInteger)anIndex;
- (void)setMessageArguments:(const void *)firstBytes, ...;

@end
