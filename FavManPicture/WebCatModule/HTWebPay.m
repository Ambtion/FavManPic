//
//  HTWebPay.m
//  LuggageForFree
//
//  Created by kequ on 2017/1/16.
//  Copyright © 2017年 ke. All rights reserved.
//

#import "HTWebPay.h"

@implementation HTWebPay

+ (void)sendPayRequestWithPayInfo:(WebPayInfoModel *)payInfo callBack:(void(^)(BaseResp *resp))callBack{
    
    //调起微信支付
    PayReq* wxreq             = [[PayReq alloc] init];
    /** appid */
    wxreq.openID              = payInfo.appid;
    /** 商家向财付通申请的商家id */
    wxreq.partnerId           = payInfo.partnerid;
    /** 预支付订单 */
    wxreq.prepayId            = payInfo.prepayid;
    /** 随机串，防重发 */
    wxreq.nonceStr            = payInfo.noncestr;
    /** 时间戳，防重发 */
    wxreq.timeStamp           = payInfo.timestamp;
    
    /** 商家根据财付通文档填写的数据和签名 */
    wxreq.package             = payInfo.package;
    /** 商家根据微信开放平台文档对数据做的签名 */
    wxreq.sign                = payInfo.sign;
    
    [[HRWeCatManager shareInstance] sendReq:wxreq callBack:callBack];

}

@end
