//
// Licensed under the terms in License.txt
//
// Copyright 2010 Allen Ding. All rights reserved.
//

#import "KWEqualMatcher.h"
#import "KWFormatter.h"
#import "KWValue.h"

@interface KWEqualMatcher()

// MARK: - Properties

@property (nonatomic, readwrite, strong) id otherSubject;

@end

@implementation KWEqualMatcher

// MARK: - Initializing


// MARK: - Properties

@synthesize otherSubject;

// MARK: - Getting Matcher Strings

+ (NSArray *)matcherStrings {
    return @[@"equal:"];
}

// MARK: - Matching

- (BOOL)evaluate {
    /** handle this as a special case; KWValue supports NSNumber equality but not vice-versa **/
    if ([self.subject isKindOfClass:[NSNumber class]] && [self.otherSubject isKindOfClass:[KWValue class]]) {
        return [self.otherSubject isEqual:self.subject];
    }
    return [self.subject isEqual:self.otherSubject];
}

// MARK: - Getting Failure Messages

- (NSString *)failureMessageForShould {
    return [NSString stringWithFormat:@"expected subject to equal %@, got %@",
                                      [KWFormatter formatObjectIncludingClass:self.otherSubject],
                                      [KWFormatter formatObjectIncludingClass:self.subject]];
}

- (NSString *)failureMessageForShouldNot {
    return [NSString stringWithFormat:@"expected subject not to equal %@",
                                      [KWFormatter formatObjectIncludingClass:self.otherSubject]];
}

- (NSString *)description
{
  return [NSString stringWithFormat:@"equal %@", [KWFormatter formatObjectIncludingClass:self.otherSubject]];
}

// MARK: - Configuring Matchers

- (void)equal:(id)anObject {
    self.otherSubject = anObject;
}

@end
