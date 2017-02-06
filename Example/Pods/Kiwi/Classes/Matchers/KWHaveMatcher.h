//
// Licensed under the terms in License.txt
//
// Copyright 2010 Allen Ding. All rights reserved.
//

#import "KiwiConfiguration.h"
#import "KWMatcher.h"
#import "KWMatchVerifier.h"

@interface KWHaveMatcher : KWMatcher

// MARK: - Configuring Matchers

- (void)haveCountOf:(NSUInteger)aCount;
- (void)haveCountOfAtLeast:(NSUInteger)aCount;
- (void)haveCountOfAtMost:(NSUInteger)aCount;
- (void)haveLengthOf:(NSUInteger)aCount;
- (void)haveLengthOfAtLeast:(NSUInteger)aCount;
- (void)haveLengthOfAtMost:(NSUInteger)aCount;
- (void)have:(NSUInteger)aCount itemsForInvocation:(NSInvocation *)anInvocation;
- (void)haveAtLeast:(NSUInteger)aCount itemsForInvocation:(NSInvocation *)anInvocation;
- (void)haveAtMost:(NSUInteger)aCount itemsForInvocation:(NSInvocation *)anInvocation;

@end

@protocol KWContainmentCountMatcherTerminals

// MARK: - Terminals

- (id)objects;
- (id)items;
- (id)elements;

@end

// MARK: - Verifying

@interface KWMatchVerifier(KWHaveMatcherAdditions)

// MARK: - Invocation Capturing Methods

- (id)have:(NSUInteger)aCount;
- (id)haveAtLeast:(NSUInteger)aCount;
- (id)haveAtMost:(NSUInteger)aCount;

@end
