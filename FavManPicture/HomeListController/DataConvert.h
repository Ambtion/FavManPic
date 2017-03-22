//
//  DataConvert.h
//  LuggageForFree
//
//  Created by kequ on 2017/2/8.
//  Copyright © 2017年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataConvert : NSObject

+ (instancetype)shareInstance;

@property(nonatomic,strong)NSDateFormatter * dateFormatter;

@end
