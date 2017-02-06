//
// Licensed under the terms in License.txt
//
// Copyright 2010 Allen Ding. All rights reserved.
//

#import "KWRespondToSelectorMatcher.h"
#import "KWFormatter.h"

@interface KWRespondToSelectorMatcher()

// MARK: - Properties

@property (nonatomic, assign) SEL selector;

@end

@implementation KWRespondToSelectorMatcher

// MARK: - Getting Matcher Strings

+ (NSArray *)matcherStrings {
    return @[@"respondToSelector:"];
}

// MARK: - Matching

- (BOOL)evaluate {
    return [self.subject respondsToSelector:self.selector];
}

// MARK: - Getting Failure Messages

- (NSString *)failureMessageForShould {
    return [NSString stringWithFormat:@"expected subject to respond to -%@",
                                      NSStringFromSelector(self.selector)];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"respond to -%@", NSStringFromSelector(self.selector)];
}

// MARK: - Configuring Matchers

- (void)respondToSelector:(SEL)aSelector {
    self.selector = aSelector;
}

@end
