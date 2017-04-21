//
//  SFObject.m
//  SFramevork
//
//  Created by Sattar Falahati on 12/07/16.
//
//

#import "SFObject.h"

// SFImporst ( to have access to all classes )
#import "SFImports.h"

@implementation NSObject (SFObject)

// MARK: - Objects

- (BOOL)isEmpty
{
    return ![self isNotEmpty];
}

- (BOOL)isNotEmpty
{
    if(self && ![self isKindOfClass:[NSNull class]] && (NSNull *)self!=[NSNull null]){
        if([self isKindOfClass:[NSString class]]){
            return ![(NSString *)self isEmptyString];
        }
        if([self isKindOfClass:[NSArray class]]){
            NSArray *arr = (NSArray *)self;
            if(arr && [arr count]>0){
                return YES;
            }
        }
        if([self isKindOfClass:[NSMutableArray class]]){
            NSMutableArray *arr = (NSMutableArray *)self;
            if(arr && [arr count]>0){
                return YES;
            }
        }
        if([self isKindOfClass:[NSDictionary class]]){
            NSDictionary *dic = (NSDictionary *)self;
            if(dic && [dic count]>0 && [[dic allKeys] count]>0){
                return YES;
            }
        }
        if([self isKindOfClass:[NSMutableDictionary class]]){
            NSMutableDictionary *dic = (NSMutableDictionary *)self;
            if(dic && [dic count]>0 && [[dic allKeys] count]>0){
                return YES;
            }
        }
        if([self isKindOfClass:[NSURL class]]){
            NSURL *url = (NSURL *)self;
            if(url && [url absoluteString] && ![[url absoluteString] isEmptyString]){
                return YES;
            }
        }
        if([self isKindOfClass:[NSNumber class]]){
            NSNumber *num = (NSNumber *)self;
            if(num){
                return YES;
            }
        }
        if([self isKindOfClass:[NSData class]]){
            NSData *data = (NSData *)self;
            if(data && [data length]>0){
                return YES;
            }
        }
    }
    return NO;
}

- (BOOL)isEqualTo:(id)object
{
    SEL comparisonSelector = @selector(compare:);
    NSAssert([self respondsToSelector:comparisonSelector], @"To use the comparison methods, this object must respond to the selector `compare:`");
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[[self class] instanceMethodSignatureForSelector:comparisonSelector]];
    invocation.selector = comparisonSelector;
    invocation.target = self;
    [invocation setArgument:&object atIndex:2];
    [invocation invoke];
    NSComparisonResult comparisonResult;
    [invocation getReturnValue:&comparisonResult];
    
    return comparisonResult == NSOrderedSame ;
}

- (BOOL)isLessThanOrEqualTo:(id)object
{
    SEL comparisonSelector = @selector(compare:);
    NSAssert([self respondsToSelector:comparisonSelector], @"To use the comparison methods, this object must respond to the selector `compare:`");
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[[self class] instanceMethodSignatureForSelector:comparisonSelector]];
    invocation.selector = comparisonSelector;
    invocation.target = self;
    [invocation setArgument:&object atIndex:2];
    [invocation invoke];
    NSComparisonResult comparisonResult;
    [invocation getReturnValue:&comparisonResult];
    
    return comparisonResult == NSOrderedSame || comparisonResult == NSOrderedAscending;
}

- (BOOL)isLessThan:(id)object
{
    SEL comparisonSelector = @selector(compare:);
    NSAssert([self respondsToSelector:comparisonSelector], @"To use the comparison methods, this object must respond to the selector `compare:`");
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[[self class] instanceMethodSignatureForSelector:comparisonSelector]];
    invocation.selector = comparisonSelector;
    invocation.target = self;
    [invocation setArgument:&object atIndex:2];
    [invocation invoke];
    NSComparisonResult comparisonResult;
    [invocation getReturnValue:&comparisonResult];
    
    return comparisonResult == NSOrderedAscending;
}

- (BOOL)isGreaterThanOrEqualTo:(id)object
{
    SEL comparisonSelector = @selector(compare:);
    NSAssert([self respondsToSelector:comparisonSelector], @"To use the comparison methods, this object must respond to the selector `compare:`");
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[[self class] instanceMethodSignatureForSelector:comparisonSelector]];
    invocation.selector = comparisonSelector;
    invocation.target = self;
    [invocation setArgument:&object atIndex:2];
    [invocation invoke];
    NSComparisonResult comparisonResult;
    [invocation getReturnValue:&comparisonResult];
    
    return comparisonResult == NSOrderedSame || comparisonResult == NSOrderedDescending;
}

- (BOOL)isGreaterThan:(id)object
{
    SEL comparisonSelector = @selector(compare:);
    NSAssert([self respondsToSelector:comparisonSelector], @"To use the comparison methods, this object must respond to the selector `compare:`");
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[[self class] instanceMethodSignatureForSelector:comparisonSelector]];
    invocation.selector = comparisonSelector;
    invocation.target = self;
    [invocation setArgument:&object atIndex:2];
    [invocation invoke];
    NSComparisonResult comparisonResult;
    [invocation getReturnValue:&comparisonResult];
    
    return comparisonResult == NSOrderedDescending;
}

- (BOOL)isNotEqualTo:(id)object
{
    return ![self isEqualTo:object];
}

@end

@implementation NSArray (SFArr)

- (id)safeObjectAtIndex:(NSUInteger)index
{
    @try {
        id value = [self objectAtIndex:index];
        if (value && value != [NSNull null]) return value;
        return nil;
    }
    @catch (NSException *exception) {
        return nil;
    }
}

+ (NSArray *)getCountriesName
{
    NSArray *countryArray = [NSLocale ISOCountryCodes];
    NSMutableArray *sortedCountryArray = [NSMutableArray new];
    
    for (NSString *countryCode in countryArray) {
        
        NSString *displayNameString = [CURRENT_LOCAL displayNameForKey:NSLocaleCountryCode value:countryCode];
        [sortedCountryArray addObject:displayNameString];
    }
    
    [sortedCountryArray sortUsingSelector:@selector(localizedCompare:)];
    
    return sortedCountryArray;
}

- (NSArray *)arrayWithRemovedDuplicatedObjects
{
    return [[NSOrderedSet orderedSetWithArray:self] array];
}

- (NSArray *)arrayWithSortedAscendingOrder
{
    return [self sortedArrayUsingSelector:@selector(compare:)];
}

- (NSArray *)arrayWithSortedReversedOrder
{
    return [[self reverseObjectEnumerator] allObjects];
}

- (NSArray *)flattenedArray
{
    NSMutableArray *array = [NSMutableArray array];
    
    for (id object in self) {
        if ([object isKindOfClass:NSArray.class]) {
            [array addObjectsFromArray:[object flattenedArray]];
        } else {
            [array addObject:object];
        }
    }
    return array;
}

- (NSArray *)arrayWithRemovedNullObjects
{
    NSMutableArray *mutableArray = [self mutableCopy];
    [mutableArray removeObjectIdenticalTo:[NSNull null]];
    return mutableArray;
}

- (id)getRandomObject
{
    if (self.count == 0) {
        return nil;
    }
    NSUInteger randomIndex = arc4random_uniform((u_int32_t)self.count);
    return self[randomIndex];
}

- (NSString *)createJSONString
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end

@implementation NSMutableArray (SFMutArr)

- (void)moveObjectFromIndext:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex
{
    // A) Check if index(s) are presented in the array
    if (self.count <= fromIndex) return;
    if (self.count <= toIndex) return;
    
    // B) Get Object
    id obj = [self safeObjectAtIndex:fromIndex];
    
    if (obj) {
        // C) Romove object from index
        [self removeObjectAtIndex:fromIndex];
        
        // D) Add object to new index
        [self insertObject:obj atIndex:toIndex];
    }
}

- (void)toggleObject:(id)object
{
    if ([self containsObject:object]) {
        [self removeObject:object];
    }
    else {
        [self addObject:object];
    }
}

@end

