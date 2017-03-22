//
//  HTWebPay.h
//  LuggageForFree
//
//  Created by kequ on 2017/1/16.
//  Copyright © 2017年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HRWeCatManager.h"

@interface HTWebPay : NSObject

+ (void)sendPayRequestWithPayInfo:(id)payInfo callBack:(void(^)(BaseResp *resp))callBack;

@end
