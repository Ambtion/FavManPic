//
//  NSArray+adapter.h
//  test
//
//  Created by LJH on 16/1/5.
//  Copyright (c) 2013年 xing lion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (adapter)

- (id)bm_myObjectAtIndex:(NSUInteger)index;

+ (instancetype)bm_myArrayWithObjects:(const id [])objects count:(NSUInteger)cnt;
@end
