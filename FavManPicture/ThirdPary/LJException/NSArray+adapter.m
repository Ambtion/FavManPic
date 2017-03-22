//
//  NSArray+adapter.m
//  test
//
//  Created by LJH on 16/1/5.
//  Copyright (c) 2013年 xing lion. All rights reserved.
//

#import "NSArray+adapter.h"

@implementation NSArray (adapter)


- (id)bm_myObjectAtIndex:(NSUInteger)index
{

    if (self.count == 0) {
        return nil;
    }
    
    if (index >= self.count) {
        return nil;
    }
    
    return [self bm_myObjectAtIndex:index];
}


+ (instancetype)bm_myArrayWithObjects:(const id [])objects count:(NSUInteger)cnt
{

    for (int i = 0 ; i < cnt; i++) {
        
      id objc =  objects[i];
        
        if (objc == nil) {
            
            return nil;
            
        }
        
    }
    
    
   return  [self bm_myArrayWithObjects:objects count:cnt];

}

@end
