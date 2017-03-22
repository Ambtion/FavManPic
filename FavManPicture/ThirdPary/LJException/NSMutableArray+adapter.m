//
//  NSMutableArray+adapter.m
//  LJException
//
//  Created by LJH on 16/1/5.
//  Copyright © 2016年 LJ. All rights reserved.
//

#import "NSMutableArray+adapter.h"

@implementation NSMutableArray (adapter)

- (id)bm_myMutableObjectAtIndex:(NSUInteger)index
{
        
    if (index > self.count -1) {
        
        index = self.count -1;
    }
    
    
    return [self bm_myMutableObjectAtIndex:index];
}


- (void)bm_myAddObject:(id)anObject
{
    
    if (anObject) {
        
        [self bm_myAddObject:anObject];
        
    }
    
}

- (void)bm_myInsertObject:(id)anObject atIndex:(NSUInteger)index
{
    if (index > self.count) {
        return;
    }
    
    if (anObject) {
        
        [self bm_myInsertObject:anObject atIndex:index];
        
    }
    
}

- (void)bm_myRemoveObjectAtIndex:(NSUInteger)index
{
    
    if (self.count == 0) {
        
        return;
    }
    
    if (index > self.count -1) {
        
        index = self.count -1;
    }
    
    [self bm_myRemoveObjectAtIndex:index];
    
}

- (void)bm_myReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    
    if (index > self.count -1) {
        
        return;
    }
    
    
    if (anObject == nil) {
        
        return;
    }
    
    
    [self bm_myReplaceObjectAtIndex:index withObject:anObject];
}

@end
