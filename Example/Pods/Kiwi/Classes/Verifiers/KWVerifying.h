//
// Licensed under the terms in License.txt
//
// Copyright 2010 Allen Ding. All rights reserved.
//

#import "KiwiConfiguration.h"

@class KWCallSite;

@protocol KWVerifying<NSObject>

@property (nonatomic, readonly) KWCallSite *callSite;

- (NSString *)descriptionForAnonymousItNode;

// MARK: - Subjects

@property (nonatomic, strong) id subject;

// MARK: - Ending Examples

- (void)exampleWillEnd;

@end
