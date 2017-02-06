//
// Licensed under the terms in License.txt
//
// Copyright 2010 Allen Ding. All rights reserved.
//

#import "KiwiConfiguration.h"

@protocol KWMatching<NSObject>

// MARK: - Initializing

- (id)initWithSubject:(id)anObject;

// MARK: - Getting Matcher Strings

+ (NSArray *)matcherStrings;

// MARK: - Getting Matcher Compatability

+ (BOOL)canMatchSubject:(id)anObject;

// MARK: - Matching

@optional

- (BOOL)isNilMatcher;
- (BOOL)shouldBeEvaluatedAtEndOfExample;
- (BOOL)willEvaluateMultipleTimes;
- (void)setWillEvaluateMultipleTimes:(BOOL)shouldEvaluateMultipleTimes;
- (void)setWillEvaluateAgainstNegativeExpectation:(BOOL)willEvaluateAgainstNegativeExpectation;

@required

- (BOOL)evaluate;

// MARK: - Getting Failure Messages

- (NSString *)failureMessageForShould;
- (NSString *)failureMessageForShouldNot;

@end
