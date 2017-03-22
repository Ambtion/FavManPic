//
//  NetWorkEntiry.h
//  JewelryApp
//
//  Created by kequ on 15/5/12.
//  Copyright (c) 2015年 jewelry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

#define  KNETBASEURL           @"http://api.pmkoo.cn/aiss/"

@interface NetWorkEntity : NSObject


+ (void)quaryConfigWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/*
 * page 从零开始
 * hot  0:普通 1 最新
 * authorId 作者id，有这个参数表示获取作者列表，无获取正常列表
 */

+ (void)quaryPhotoListWithPage:(NSInteger)page
                     photoPype:(NSInteger)type
                      authorId:(NSString *)authorId
                       success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end

