//
//  HRWebCatShare.m
//  HRER
//
//  Created by quke on 16/5/25.
//  Copyright © 2016年 linjunhou. All rights reserved.
//

#import "HRWebCatShare.h"
#import "UIImage+Scale.h"


@implementation HRWebCatShare


+ (NSInteger)sendWeixinWebContentTitle:(NSString*)title description:(NSString*)description thumbImage:(UIImage*)thumbImage webpageURL:(NSString*)webpageURL scene:(NSInteger)scene withcallBack:(void (^)(BaseResp *))callBack
{
    
    NSInteger res = 0;
    
    if (description.length == 0) {
        description = nil;
    }
    
    if ([[HRWeCatManager shareInstance] isWXAppInstalled]) {
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = title;
        message.description = description;
        [message setThumbImage:thumbImage];
        
        WXWebpageObject *ext = [WXWebpageObject object];
        ext.webpageUrl = webpageURL;
        
        message.mediaObject = ext;
        
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        
        if (ext.webpageUrl == nil && thumbImage == nil)
        {
            
            req.bText = YES;
            req.text = description;
            
        }
        else
        {
            req.bText = NO;
            req.message = message;
            
        }
        
        
        req.scene = (int)scene;
        
        res = [[HRWeCatManager shareInstance]sendReq:req callBack:callBack];
        
    }else{
        res = -1;
    }
    return res;
}


+ (NSInteger)sendWeixinWebContentTitle:(NSString*)title description:(NSString*)description thumbImage:(UIImage*)thumbImage image:(UIImage*)img webpageURL:(NSString*)webpageURL scene:(NSInteger)scene withcallBack:(void(^)(BaseResp *resp))callBack
{
    NSInteger res = 0;
    
    if ([[HRWeCatManager shareInstance] isWXAppInstalled]) {
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = title;
        message.description = description;
        
        WXImageObject *imgObject = [WXImageObject object];
        imgObject.imageData = UIImageJPEGRepresentation(img, 0.8); //UIImagePNGRepresentation(img); ////UIImagePNGRepresentation会把图片大小由放大，不要采用；
        message.mediaObject = imgObject;
        
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.text = description;
        req.bText = NO;
        req.message = message;
        req.scene = (int)scene;

        if (!thumbImage) {
            thumbImage = [img imageByScalingAndCroppingForSize:CGSizeMake(100, 100)];
        }
        [message setThumbImage:thumbImage];

        res = [[HRWeCatManager shareInstance]sendReq:req callBack:callBack];
        
    }else{
        res = -1;
    }
    return res;
}


@end

