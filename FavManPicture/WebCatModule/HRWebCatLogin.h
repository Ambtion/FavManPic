//
//  WebCatLogin.h
//  HRER
//
//  Created by quke on 16/5/24.
//  Copyright © 2016年 linjunhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HRWeCatManager.h"

@interface HRWebCatLogin : NSObject
+ (void)sendAuthRequestcallBack:(void(^)(BaseResp *resp))callBack;
@end
