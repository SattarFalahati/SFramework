//
// Licensed under the terms in License.txt
//
// Copyright 2010 Allen Ding. All rights reserved.
//

#import "KiwiConfiguration.h"
#import "KWMatcher.h"

@interface KWBeSubclassOfClassMatcher : KWMatcher

// MARK: - Configuring Matchers

- (void)beSubclassOfClass:(Class)aClass;

@end
