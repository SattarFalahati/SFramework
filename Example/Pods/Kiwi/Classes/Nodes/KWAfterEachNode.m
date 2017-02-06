//
// Licensed under the terms in License.txt
//
// Copyright 2010 Allen Ding. All rights reserved.
//

#import "KWAfterEachNode.h"
#import "KWExampleNodeVisitor.h"

@implementation KWAfterEachNode

// MARK: - Initializing

+ (id)afterEachNodeWithCallSite:(KWCallSite *)aCallSite block:(void (^)(void))block {
    return [[self alloc] initWithCallSite:aCallSite description:nil block:block];
}

// MARK: - Accepting Visitors

- (void)acceptExampleNodeVisitor:(id<KWExampleNodeVisitor>)aVisitor {
    [aVisitor visitAfterEachNode:self];
}

@end
