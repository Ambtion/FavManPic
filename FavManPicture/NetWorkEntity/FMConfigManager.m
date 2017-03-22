//
//  FMConfigManager.m
//  FavManPicture
//
//  Created by quke on 2017/3/22.
//  Copyright © 2017年 linjunhou. All rights reserved.
//

#import "FMConfigManager.h"

@interface FMConfigManager()

@property(nonatomic,strong)FMCommonModel * configModel;

@end

@implementation FMConfigManager

+ (FMConfigManager *)sharedInstance
{
    
    static FMConfigManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[FMConfigManager alloc] init];
        _sharedInstance.configModel = [FMConfigManager commonModel];
    });
    return _sharedInstance;
}



- (void)quaryConfig
{
    WS(ws);
    
    [NetWorkEntity quaryConfigWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([[responseObject objectForKey:@"success"] boolValue]) {
            ws.configModel = [FMCommonModel yy_modelWithJSON:[responseObject objectForKey:@"data"]];
            [FMConfigManager storeModel:ws.configModel];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}


+ (void)storeModel:(FMCommonModel *)model
{
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:model];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"FMCommonModel"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (FMCommonModel *)commonModel
{
    NSData * data = [[NSUserDefaults standardUserDefaults] objectForKey:@"FMCommonModel"];
    FMCommonModel* model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return model;
}
@end
