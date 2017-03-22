//
//  HRWebCatShare.h
//  HRER
//
//  Created by quke on 16/5/25.
//  Copyright © 2016年 linjunhou. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HRWeCatManager.h"

@interface HRWebCatShare : NSObject

/**
 *  微信分享 (网页)
 *
 *  @param title          标题
 *  @param description    描述
 *  @param thumbImage     缩略图
 *  @param webpageURL     网页的url地址
 *  @param scene          发送的目标场景，可以选择发送到会话(WXSceneSession)或者朋友圈(WXSceneTimeline)。 默认发送到会话。
 *  @param objectDelegate 废弃参数，传nil
 *
 *  @return 返回状态 正常（0），未安装微信（－1)
 */

+ (NSInteger)sendWeixinWebContentTitle:(NSString*)title description:(NSString*)description thumbImage:(UIImage*)thumbImage webpageURL:(NSString*)webpageURL scene:(NSInteger)scene withcallBack:(void(^)(BaseResp *resp))callBack;

/**
 *  微信分享 (图片UIImage)
 *
 *  @param title          标题
 *  @param description    描述
 *  @param thumbImage     缩略图
 *  @param img            大图
 *  @param webpageURL     废弃参数，传nil
 *  @param scene          发送的目标场景，可以选择发送到会话(WXSceneSession)或者朋友圈(WXSceneTimeline)。 默认发送到会话。
 *  @param objectDelegate 废弃参数，传nil
 *
 *  @return 返回状态 正常（0），未安装微信（－1）
 */
+ (NSInteger)sendWeixinWebContentTitle:(NSString*)title description:(NSString*)description thumbImage:(UIImage*)thumbImage image:(UIImage*)img webpageURL:(NSString*)webpageURL scene:(NSInteger)scene withcallBack:(void(^)(BaseResp *resp))callBack;

@end
