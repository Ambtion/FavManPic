//
//  NSDictionary+adapter.h
//  LJException
//
//  Created by LJH on 16/1/5.
//  Copyright © 2016年 LJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (adapter)

- (id)objectForKeyOrNil:(id)aKey;

@end


@interface NSMutableDictionary (adapter)


- (void)bm_mySetObject:(id)anObject forKey:(id <NSCopying>)aKey;

@end
