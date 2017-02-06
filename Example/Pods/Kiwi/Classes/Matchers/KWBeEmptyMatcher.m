//
// Licensed under the terms in License.txt
//
// Copyright 2010 Allen Ding. All rights reserved.
//

#import "KWBeEmptyMatcher.h"
#import "KWFormatter.h"

@interface KWBeEmptyMatcher()

// MARK: - Properties

@property (nonatomic, readwrite) NSUInteger count;

@end

@implementation KWBeEmptyMatcher

// MARK: - Getting Matcher Strings

+ (NSArray *)matcherStrings {
    return @[@"beEmpty"];
}

// MARK: - Matching

- (BOOL)evaluate {
    if ([self.subject respondsToSelector:@selector(count)]) {
        self.count = [self.subject count];
        return self.count == 0;
    }
    else if ([self.subject respondsToSelector:@selector(length)]) {
        self.count = [self.subject length];
        return self.count == 0;
    }

    [NSException raise:@"KWMatcherException" format:@"subject does not respond to -count or -length"];
    return NO;
}

// MARK: - Getting Failure Messages

- (NSString *)countPhrase {
    if (self.count == 1)
        return @"1 item";
    else
        return [NSString stringWithFormat:@"%u items", (unsigned)self.count];
}

- (NSString *)failureMessageForShould {
    return [NSString stringWithFormat:@"expected subject to be empty, got %@", [self countPhrase]];
}

- (NSString *)failureMessageForShouldNot {
    return @"expected subject not to be empty";
}

- (NSString *)description {
    return @"be empty";
}

// MARK: - Configuring Matchers

- (void)beEmpty {
}

@end
