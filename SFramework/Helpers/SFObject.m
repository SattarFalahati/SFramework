//
//  SFObject.m
//  SFramevork
//
//  Created by Sattar Falahati on 12/07/16.
//
//

#import "SFObject.h"

// Helper
#import "SFString.h"

@implementation NSObject (SFObject)

#pragma mark - Objects

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
