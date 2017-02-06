//
// Licensed under the terms in License.txt
//
// Copyright 2010 Allen Ding. All rights reserved.
//

#import "KiwiConfiguration.h"

@interface KWBlock : NSObject

// MARK: - Initializing
- (id)initWithBlock:(void (^)(void))block;

+ (id)blockWithBlock:(void (^)(void))block;

// MARK: - Calling Blocks

- (void)call;

@end

// MARK: - Creating Blocks

KWBlock *theBlock(void (^block)(void));
KWBlock *lambda(void (^block)(void));
