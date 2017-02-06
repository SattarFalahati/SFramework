//
// Licensed under the terms in License.txt
//
// Copyright 2010 Allen Ding. All rights reserved.
//

#import "KiwiConfiguration.h"
#import "KWMatcher.h"
#import "KWMatchVerifier.h"

@interface KWContainMatcher : KWMatcher

// MARK: - Configuring Matchers

- (void)contain:(id)anObject;
- (void)containObjectsInArray:(NSArray *)anArray;

@end

@interface KWMatchVerifier(KWContainMatcherAdditions)

// MARK: - Verifying

- (void)containObjects:(id)firstObject, ... NS_REQUIRES_NIL_TERMINATION;

@end
