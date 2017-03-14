//
//  SFObject.h
//  SFramevork
//
//  Created by Sattar Falahati on 12/07/16.
//
//

#import <Foundation/Foundation.h>

@interface  NSObject (SFObject)

/// Check if an object is empty
- (BOOL)isEmpty;

/// Check if an object is NOT empty 
- (BOOL)isNotEmpty;

@end

@interface NSArray (SFArr)

- (id)safeObjectAtIndex:(NSUInteger)index;

/// GET list of countries
+ (NSArray *)getCountriesName;

@end

@interface NSMutableArray (SFMutArr)

/// Move object from index to index in an array
- (void)moveObjectFromIndext:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

/// Add or remove object inisde an array
- (void)toggleObject:(id)object;

@end
