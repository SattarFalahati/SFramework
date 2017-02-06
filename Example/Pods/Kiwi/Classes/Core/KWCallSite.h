//
// Licensed under the terms in License.txt
//
// Copyright 2010 Allen Ding. All rights reserved.
//

#import "KiwiConfiguration.h"

@interface KWCallSite : NSObject

// MARK: - Initializing

- (id)initWithFilename:(NSString *)aFilename lineNumber:(NSUInteger)aLineNumber;

+ (id)callSiteWithFilename:(NSString *)aFilename lineNumber:(NSUInteger)aLineNumber;

// MARK: - Properties

@property (nonatomic, readonly, copy) NSString *filename;
@property (nonatomic, readonly) NSUInteger lineNumber;

// MARK: - Identifying and Comparing

- (BOOL)isEqualToCallSite:(KWCallSite *)aCallSite;

@end
