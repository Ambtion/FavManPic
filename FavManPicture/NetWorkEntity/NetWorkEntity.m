//
//  NetWorkEntiry.m
//  JewelryApp
//
//  Created by kequ on 15/5/12.
//  Copyright (c) 2015年 jewelry. All rights reserved.
//

#import "NetWorkEntity.h"


typedef     void (^CallBack)(AFHTTPRequestOperation *operation, id responseObject);
static CallBack upSucess;

@implementation NetWorkEntity

+ (void)quaryConfigWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSString * urlStr = [NSString stringWithFormat:@"%@/system/config.do",KNETBASEURL];
    [self postMethodWithUrl:urlStr parameters:nil success:success failure:failure];
}

+ (void)quaryPhotoListWithPage:(NSInteger)page
                     photoPype:(NSInteger)type
                      authorId:(NSString *)authorId
                       success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSMutableDictionary  * dic = [NSMutableDictionary dictionaryWithCapacity:0];
    [dic setValue:@(page) forKey:@"page"];
    [dic setValue:@(type) forKey:@"hot"];
    if (authorId) {
        [dic setValue:authorId forKey:@"authorId"];
    }
    NSString * urlStr = [NSString stringWithFormat:@"%@/suite/suiteList.do",KNETBASEURL];
    [self postMethodWithUrl:urlStr parameters:dic success:success failure:failure];

}


/*
 * 壁纸
 */

+ (void)quaryCategoryListWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSString * urlStr = @"http://zaijiawan.com/matrix_common/api/image/wallpaperCategory?appname=daibizhidaquan";
    [self getMethodWithUrl:urlStr parameters:nil success:success failure:failure];
}

+ (void)quaryCategoryDetailWithCatergoryId:(NSString *)catgoryId
                                  Success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSString * urlStr = [NSString stringWithFormat:@"http://zaijiawan.com/matrix_common/api/image/wallpaperList?appname=daibizhidaquan&category_id=%@&page=1&count=100",catgoryId];
    [self getMethodWithUrl:urlStr parameters:nil success:success failure:failure];
}

#pragma mark - Common

+ (void)getMethodWithUrl:(NSString *)url
              parameters:(id)parameters
                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure

{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manager GET:url parameters:parameters success:success failure:failure];
}


+ (void)postMethodWithUrl:(NSString *)url
               parameters:(id)parameters
                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager POST:url parameters:parameters success:success failure:failure];
    
}

+ (void)missParagramercallBackFailure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSError * error = [NSError errorWithDomain:@"Deomin" code:0
                                      userInfo:@{@"error":@"缺少参数"}];
    failure(nil,error);
}
@end
