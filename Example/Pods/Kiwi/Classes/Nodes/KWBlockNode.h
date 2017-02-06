//
// Licensed under the terms in License.txt
//
// Copyright 2010 Allen Ding. All rights reserved.
//

#import "KiwiConfiguration.h"
#import "KWBlock.h"

@class KWCallSite;

@interface KWBlockNode : NSObject

// MARK: - Initializing

- (id)initWithCallSite:(KWCallSite *)aCallSite description:(NSString *)aDescription block:(void (^)(void))block;

// MARK: - Getting Call Sites

@property (nonatomic, strong, readonly) KWCallSite *callSite;

// MARK: - Getting Descriptions

@property (nonatomic, copy) NSString *description;

// MARK: - Getting Blocks

@property (nonatomic, copy, readonly) void (^block)(void);

// MARK: - Performing blocks

- (void)performBlock;

@end
