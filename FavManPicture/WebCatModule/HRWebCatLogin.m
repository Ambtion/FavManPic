//
//  WebCatLogin.m
//  HRER
//
//  Created by quke on 16/5/24.
//  Copyright © 2016年 linjunhou. All rights reserved.
//

#import "HRWebCatLogin.h"

@implementation HRWebCatLogin

+ (void)sendAuthRequestcallBack:(void(^)(BaseResp *resp))callBack
{
    SendAuthReq* req =[[SendAuthReq alloc ] init];
    req.scope = @"snsapi_userinfo" ;
    req.state = @"123";
    [[HRWeCatManager shareInstance] sendReq:req callBack:callBack];
}

@end
