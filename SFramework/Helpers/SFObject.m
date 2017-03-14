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

