//
//  NSMutableArray+adapter.h
//  LJException
//
//  Created by LJH on 16/1/5.
//  Copyright © 2016年 LJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (adapter)

- (void)bm_myAddObject:(id)anObject;
- (id)bm_myMutableObjectAtIndex:(NSUInteger)index;
- (void)bm_myInsertObject:(id)anObject atIndex:(NSUInteger)index;
- (void)bm_myRemoveObjectAtIndex:(NSUInteger)index;
- (void)bm_myReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;

@end
