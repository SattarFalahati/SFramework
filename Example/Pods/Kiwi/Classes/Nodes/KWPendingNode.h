//
// Licensed under the terms in License.txt
//
// Copyright 2010 Allen Ding. All rights reserved.
//

#import "KiwiConfiguration.h"
#import "KWExampleNode.h"

@class KWContextNode;
@class KWCallSite;

@interface KWPendingNode : NSObject<KWExampleNode>

@property (nonatomic, readonly, strong) KWContextNode *context;

// MARK: - Initializing

- (id)initWithCallSite:(KWCallSite *)aCallSite context:(KWContextNode *)context description:(NSString *)aDescription;

+ (id)pendingNodeWithCallSite:(KWCallSite *)aCallSite context:(KWContextNode *)context description:(NSString *)aDescription;

// MARK: - Getting Call Sites

@property (nonatomic, readonly) KWCallSite *callSite;

// MARK: - Getting Descriptions

@property (readonly, copy) NSString *description;

@end
