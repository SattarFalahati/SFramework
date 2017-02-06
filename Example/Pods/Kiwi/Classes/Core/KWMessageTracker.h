//
// Licensed under the terms in License.txt
//
// Copyright 2010 Allen Ding. All rights reserved.
//

#import "KiwiConfiguration.h"
#import "KWCountType.h"
#import "KWMessageSpying.h"

@class KWMessagePattern;

@interface KWMessageTracker : NSObject<KWMessageSpying>

// MARK: - Initializing

- (id)initWithSubject:(id)anObject messagePattern:(KWMessagePattern *)aMessagePattern countType:(KWCountType)aCountType count:(NSUInteger)aCount;

+ (id)messageTrackerWithSubject:(id)anObject messagePattern:(KWMessagePattern *)aMessagePattern countType:(KWCountType)aCountType count:(NSUInteger)aCount;

// MARK: - Properties

@property (nonatomic, readonly) id subject;
@property (nonatomic, readonly) KWMessagePattern *messagePattern;
@property (nonatomic, readonly) KWCountType countType;
@property (nonatomic, readonly) NSUInteger count;

// MARK: - Stopping Tracking

- (void)stopTracking;

// MARK: - Getting Message Tracker Status

- (BOOL)succeeded;

// MARK: - Getting Phrases

- (NSString *)expectedCountPhrase;
- (NSString *)receivedCountPhrase;

@end
