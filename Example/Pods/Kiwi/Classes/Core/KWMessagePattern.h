//
// Licensed under the terms in License.txt
//
// Copyright 2010 Allen Ding. All rights reserved.
//

#import "KiwiConfiguration.h"

@interface KWMessagePattern : NSObject

// MARK: - Initializing

- (id)initWithSelector:(SEL)aSelector;
- (id)initWithSelector:(SEL)aSelector argumentFilters:(NSArray *)anArray;
- (id)initWithSelector:(SEL)aSelector firstArgumentFilter:(id)firstArgumentFilter argumentList:(va_list)argumentList;

+ (id)messagePatternWithSelector:(SEL)aSelector;
+ (id)messagePatternWithSelector:(SEL)aSelector argumentFilters:(NSArray *)anArray;
+ (id)messagePatternWithSelector:(SEL)aSelector firstArgumentFilter:(id)firstArgumentFilter argumentList:(va_list)argumentList;

+ (id)messagePatternFromInvocation:(NSInvocation *)anInvocation;

// MARK: - Properties

@property (nonatomic, readonly) SEL selector;
@property (nonatomic, readonly) NSArray *argumentFilters;

// MARK: - Matching Invocations

- (BOOL)matchesInvocation:(NSInvocation *)anInvocation;

// MARK: - Comparing Message Patterns

- (BOOL)isEqualToMessagePattern:(KWMessagePattern *)aMessagePattern;

// MARK: - Retrieving String Representations

- (NSString *)stringValue;

@end
