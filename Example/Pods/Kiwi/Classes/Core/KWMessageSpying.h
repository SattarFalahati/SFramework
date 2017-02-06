//
// Licensed under the terms in License.txt
//
// Copyright 2010 Allen Ding. All rights reserved.
//

#import "KiwiConfiguration.h"

@protocol KWMessageSpying<NSObject>

// MARK: - Spying on Messages

- (void)object:(id)anObject didReceiveInvocation:(NSInvocation *)anInvocation;

@end
