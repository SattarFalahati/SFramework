//
// Licensed under the terms in License.txt
//
// Copyright 2010 Allen Ding. All rights reserved.
//

#import "KWBlock.h"

@interface KWBlock()

// MARK: - Properties

@property (nonatomic, readonly, copy) void (^block)(void);

@end

@implementation KWBlock

// MARK: - Initializing

- (id)initWithBlock:(void (^)(void))block {
    self = [super init];
    if (self) {
        _block = [block copy];
    }

    return self;
}

+ (id)blockWithBlock:(void (^)(void))aBlock {
    return [[self alloc] initWithBlock:aBlock];
}

// MARK: - Calling Blocks

- (void)call {
    self.block();
}

@end

// MARK: - Creating Blocks

KWBlock *theBlock(void (^block)(void)) {
    return lambda(block);
}

KWBlock *lambda(void (^block)(void)) {
    return [KWBlock blockWithBlock:block];
}
