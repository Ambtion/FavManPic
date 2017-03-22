//
//  NSDictionary+adapter.m
//  LJException
//
//  Created by LJH on 16/1/5.
//  Copyright © 2016年 LJ. All rights reserved.
//

#import "NSDictionary+adapter.h"

@implementation NSDictionary (adapter)

- (id)objectForKeyOrNil:(id)aKey
{
    id val = [self objectForKeyOrNil:aKey];
    if ([val isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return val;
}

@end


@implementation NSMutableDictionary (adapter)

- (void)bm_mySetObject:(id)anObject forKey:(id <NSCopying>)aKey
{
    
    if (anObject && aKey) {
        
        [self bm_mySetObject:anObject forKey:aKey];
        
    }
}


@end