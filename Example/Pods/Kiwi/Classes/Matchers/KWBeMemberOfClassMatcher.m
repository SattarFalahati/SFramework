//
// Licensed under the terms in License.txt
//
// Copyright 2010 Allen Ding. All rights reserved.
//

#import "KWBeMemberOfClassMatcher.h"
#import "KWFormatter.h"

@interface KWBeMemberOfClassMatcher()

@property (nonatomic, assign) Class targetClass;

@end

@implementation KWBeMemberOfClassMatcher

// MARK: - Getting Matcher Strings

+ (NSArray *)matcherStrings {
    return @[@"beMemberOfClass:"];
}

// MARK: - Matching

- (BOOL)evaluate {
    return [self.subject isMemberOfClass:self.targetClass];
}

// MARK: - Getting Failure Messages

- (NSString *)failureMessageForShould {
    return [NSString stringWithFormat:@"expected subject to be member of %@, got %@",
                                      NSStringFromClass(self.targetClass),
                                      NSStringFromClass([self.subject class])];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"be member of %@",
                                    NSStringFromClass(self.targetClass)];
}

// MARK: - Configuring Matchers

- (void)beMemberOfClass:(Class)aClass {
    self.targetClass = aClass;
}

@end
