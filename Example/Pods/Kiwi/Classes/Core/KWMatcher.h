//
// Licensed under the terms in License.txt
//
// Copyright 2010 Allen Ding. All rights reserved.
//

#import "KiwiConfiguration.h"
#import "KWMatching.h"

@interface KWMatcher : NSObject<KWMatching>

// MARK: - Initializing

- (id)initWithSubject:(id)anObject;

+ (id)matcherWithSubject:(id)anObject;

// MARK: - Properties

@property (nonatomic, strong) id subject;

// MARK: - Getting Matcher Strings

+ (NSArray *)matcherStrings;

// MARK: - Getting Matcher Compatability

+ (BOOL)canMatchSubject:(id)anObject;

// MARK: - Matching

- (BOOL)evaluate;

// MARK: - Getting Failure Messages

- (NSString *)failureMessageForShould;
- (NSString *)failureMessageForShouldNot;

@end
