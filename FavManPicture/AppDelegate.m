//
//  AppDelegate.m
//  FavManPicture
//
//  Created by quke on 2017/3/22.
//  Copyright © 2017年 linjunhou. All rights reserved.
//

#import "AppDelegate.h"
#import "LJException.h"
#import "HRWeCatManager.h"
#import "AFNetworkActivityLogger.h"
#import <UMMobClick/MobClick.h>
#import "BMJWNagationController.h"
#import "HomeViewController.h"
#import "FMConfigManager.h"

@interface AppDelegate ()

@property(nonatomic,strong)BMJWNagationController * navController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self initAllComCoreWithLangchOptions:launchOptions];
    [self setDefoultNavBarStyle];

    self.navController = [[BMJWNagationController alloc] initWithRootViewController:[[HomeViewController alloc] init]];
    self.window.rootViewController = self.navController;
    [self.window makeKeyAndVisible];

    return YES;
}


#pragma mark - Init
- (void)setDefoultNavBarStyle
{
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0xffffff)];
    NSDictionary *textAttributes1 = @{NSFontAttributeName: [UIFont systemFontOfSize:15.f],
                                      NSForegroundColorAttributeName: [UIColor whiteColor]
                                      };
    
    [[UINavigationBar appearance] setTitleTextAttributes:textAttributes1];
    
    
    [[UITabBar appearance] setTintColor:UIColorFromRGB(0x8bcdf0)];
    
}


- (void)initAllComCoreWithLangchOptions:(NSDictionary *)launchOptions
{
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    [LJException startExtern];
    
    //注册微信
    [[HRWeCatManager shareInstance] registerWeixin];
    
    [[FMConfigManager sharedInstance] quaryConfig];
    
    //开启AFNetWork
    [[AFNetworkActivityLogger sharedLogger] setLevel:AFLoggerLevelDebug];
    [[AFNetworkActivityLogger sharedLogger] startLogging];
    
    UMConfigInstance.appKey = @"57737e9267e58e6f780026b3";
    UMConfigInstance.channelId = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];
    
}


@end
