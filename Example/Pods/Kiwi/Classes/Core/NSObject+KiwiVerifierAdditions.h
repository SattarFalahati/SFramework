//
// Licensed under the terms in License.txt
//
// Copyright 2010 Allen Ding. All rights reserved.
//

#import "KiwiConfiguration.h"

@protocol KWVerifying;

@interface NSObject(KiwiVerifierAdditions)

// MARK: - Attaching to Verifiers

- (id)attachToVerifier:(id<KWVerifying>)aVerifier;

@end
