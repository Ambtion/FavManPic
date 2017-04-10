//
//  FMConfigManager.h
//  FavManPicture
//
//  Created by quke on 2017/3/22.
//  Copyright © 2017年 linjunhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HereDataModel.h"

@interface FMConfigManager : NSObject

@property(nonatomic,strong,readonly)FMCommonModel * configModel;


+ (FMConfigManager *)sharedInstance;

- (void)quaryConfig;

- (BOOL)isPay;

- (void)setPay:(BOOL)isPay;

@end

