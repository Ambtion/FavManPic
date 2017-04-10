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


/*
 * 壁纸
 */

+ (void)quaryCategoryListWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


+ (void)quaryCategoryDetailWithCatergoryId:(NSString *)catgoryId
                                  Success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/*
 * https://pay.weixin.qq.com/wiki/doc/api/jsapi.php?chapter=9_1&pass_ticket=s%2FrUv1HUNNFVWlO%2Fc9OaEPMTd5ZTugXUTXZ2%2FRcnSjgImlodidKdoiuKqdV8OZgt
 */
+ (void)quaryPayOrderIdWithAppleId:(NSString *)appleId
                            mch_id:(NSString *)mch_id
                         nonce_str:(NSString *)nonce_str
                              body:(NSString *)body
                      out_trade_no:(NSString *)out_trade_no
                         total_fee:(NSString *)total_fee
                  spbill_create_ip:(NSString *)spbill_create_ip //Native支付填调用微信支付API的机器IP
                        trade_type:(NSString *)trade_type
                        notify_url:(NSString *)notify_url
                           Success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


@end

