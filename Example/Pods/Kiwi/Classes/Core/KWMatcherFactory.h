//
// Licensed under the terms in License.txt
//
// Copyright 2010 Allen Ding. All rights reserved.
//

#import "KiwiConfiguration.h"
#import "KWMatching.h"

@class KWFailure;
@class KWMatcher;
@class KWUserDefinedMatcherBuilder;

@interface KWMatcherFactory : NSObject

// MARK: - Initializing

- (id)init;

// MARK: - Properties

@property (nonatomic, readonly) NSArray *registeredMatcherClasses;

// MARK: - Registering Matcher Classes

- (void)registerMatcherClass:(Class)aClass;
- (void)registerMatcherClassesWithNamespacePrefix:(NSString *)aNamespacePrefix;

// MARK: - Getting Method Signatures

- (NSMethodSignature *)methodSignatureForMatcherSelector:(SEL)aSelector;

// MARK: - Getting Matchers

- (KWMatcher *)matcherFromInvocation:(NSInvocation *)anInvocation subject:(id)subject;

@end
