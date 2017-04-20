//
//  BMWeChatManager.h
//  HRER
//
//  Created by quke on 16/5/24.
//  Copyright © 2016年 linjunhou. All rights reserved.
//

#import "HRWeCatManager.h"
#import <UIKit/UIKit.h>

#define AppKey_WeiXin               @"wx4c4d26d886f96ab7"
#define App_Ser                     @"079f2a818e0b341ecf2b04dcf74defac"

static HRWeCatManager *gInstance = nil;


@implementation HRWeCatManager

+ (HRWeCatManager *)shareInstance
{
    if(gInstance == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            gInstance = [[HRWeCatManager alloc] init];
        });
    }
    return gInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [WXApi registerApp:AppKey_WeiXin];
    }
    return self;
}

#pragma  mark -  注册微信
- (void)registerWeixin
{
    [WXApi registerApp:AppKey_WeiXin withDescription:@""];
}

#pragma mark - 微信回调处理
- (BOOL)isWeixinssoReturn:(NSURL *)url
{
    return [[url absoluteString] rangeOfString:@"wx"].location != NSNotFound;
}

- (BOOL)handdleOpneUrl:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}

#pragma mark - 检测微信是否安装
- (BOOL)isWXAppInstalled
{
    return [WXApi isWXAppInstalled];
}


#pragma mark - 请求回调
- (BOOL)sendReq:(BaseReq *)req callBack:(void(^)(BaseResp *resp))callBack
{
    self.reqCallBack = callBack;
    return [WXApi sendReq:req];
}


- (void)weixinrespons:(NSNotification*)note
{
    NSURL *url = [NSURL URLWithString:[note object]];
    [WXApi handleOpenURL:url delegate:self];
}


-(void)onReq:(BaseReq*)req
{
    if([req isKindOfClass:[GetMessageFromWXReq class]])
    {
        
    }
    else if([req isKindOfClass:[ShowMessageFromWXReq class]])
    {
        ShowMessageFromWXReq* temp = (ShowMessageFromWXReq*)req;
        WXAppExtendObject *obj = temp.message.mediaObject;
        NSURL *url = [NSURL URLWithString:obj.extInfo];
        [[UIApplication sharedApplication] openURL: url];
    }
}

-(void)onResp:(BaseResp*)resp
{
    if (self.reqCallBack != nil) {
        self.reqCallBack(resp);
    }
}

@end
