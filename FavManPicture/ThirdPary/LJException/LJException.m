//
//  LJException.m
//  LJException
//
//  Created by LJH on 16/1/5.
//  Copyright © 2016年 LJ. All rights reserved.
//

#import "LJException.h"
#import "JRSwizzle.h"
#import "NSArray+adapter.h"
#import "NSMutableArray+adapter.h"
#import "NSDictionary+adapter.h"
#import <objc/runtime.h>

@implementation LJException

+ (void)startExtern
{
    
#ifndef DEBUG
    
    NSArray* arr = @[@(123),@(345)];
    NSArray* arr0 = [NSArray array];
    arr0 = [NSArray array];
    
    NSMutableArray* mutableArr = [NSMutableArray array];
    NSDictionary * tableDic = @{
                                @"LJ":@"LJ"
                                };
    NSMutableDictionary* mutableDic = [NSMutableDictionary dictionary];

    
    
    Class tmpI = objc_getClass(NSStringFromClass([arr class]).UTF8String);//objc_getClass("__NSArrayI");
    Class tmp0 = objc_getClass(NSStringFromClass([arr0 class]).UTF8String);//objc_getClass("__NSArray0");
    Class tmpM = objc_getClass(NSStringFromClass([mutableArr class]).UTF8String);//objc_getClass("__NSArrayM");
    Class tmpDM = objc_getClass(NSStringFromClass([mutableDic class]).UTF8String);//objc_getClass("__NSDictionaryM");
    Class tmpDic = objc_getClass(NSStringFromClass([tableDic class]).UTF8String);//objc_getClass("__NSDictionaryM");
    
    
    [tmpI jr_swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(bm_myObjectAtIndex:) error:nil];
    if (tmp0 != tmpI) {
        [tmp0 jr_swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(bm_myObjectAtIndex:) error:nil];
    }
        
    [[NSArray class] jr_swizzleClassMethod:@selector(arrayWithObjects:count:) withClassMethod:@selector(bm_myArrayWithObjects:count:) error:nil];
    
    [tmpM jr_swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(bm_myMutableObjectAtIndex:) error:nil];
    [tmpM jr_swizzleMethod:@selector(addObject:) withMethod:@selector(bm_myAddObject:) error:nil];
    [tmpM jr_swizzleMethod:@selector(insertObject:atIndex:) withMethod:@selector(bm_myInsertObject:atIndex:) error:nil];
    [tmpM jr_swizzleMethod:@selector(removeObjectAtIndex:) withMethod:@selector(bm_myRemoveObjectAtIndex:) error:nil];
    [tmpM jr_swizzleMethod:@selector(replaceObjectAtIndex:withObject:) withMethod:@selector(bm_myReplaceObjectAtIndex:withObject:) error:nil];
    [tmpDM jr_swizzleMethod:@selector(setObject:forKey:) withMethod:@selector(bm_mySetObject:forKey:) error:nil];
    [tmpDic jr_swizzleMethod:@selector(objectForKey:) withMethod:@selector(objectForKeyOrNil:) error:NULL];

#endif
    
}

@end
