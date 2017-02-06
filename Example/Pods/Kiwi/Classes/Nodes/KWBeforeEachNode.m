//
// Licensed under the terms in License.txt
//
// Copyright 2010 Allen Ding. All rights reserved.
//

#import "KWBeforeEachNode.h"
#import "KWExampleNodeVisitor.h"

@implementation KWBeforeEachNode

// MARK: - Initializing

+ (id)beforeEachNodeWithCallSite:(KWCallSite *)aCallSite block:(void (^)(void))block {
    return [[self alloc] initWithCallSite:aCallSite description:nil block:block];
}

// MARK: - Accepting Visitors

- (void)acceptExampleNodeVisitor:(id<KWExampleNodeVisitor>)aVisitor {
    [aVisitor visitBeforeEachNode:self];
}

@end
