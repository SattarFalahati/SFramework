//
// Licensed under the terms in License.txt
//
// Copyright 2010 Allen Ding. All rights reserved.
//

#import "KiwiConfiguration.h"
#import "KWMatcher.h"

@interface KWRespondToSelectorMatcher : KWMatcher

// MARK: - Configuring Matchers

- (void)respondToSelector:(SEL)aSelector;

@end
