//
// Licensed under the terms in License.txt
//
// Copyright 2010 Allen Ding. All rights reserved.
//

#import "KiwiConfiguration.h"
#import "KWBlockNode.h"
#import "KWExampleNode.h"

@interface KWBeforeEachNode : KWBlockNode<KWExampleNode>

// MARK: - Initializing

+ (id)beforeEachNodeWithCallSite:(KWCallSite *)aCallSite block:(void (^)(void))block;

@end
