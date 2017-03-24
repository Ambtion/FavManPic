//
//  UIViewController+DivideAssett.m
//  SohuPhotoAlbum
//
//  Created by sohu on 13-4-27.
//  Copyright (c) 2013年 Qu. All rights reserved.
//

#import "UIViewController+Method.h"
#import <Accelerate/Accelerate.h>
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"
#import "ToastAlertView.h"
#import "RefreshTableView.h"
#import "AppDelegate.h"


@implementation UIViewController(Tips)
- (MBProgressHUD *)waitForMomentsWithTitle:(NSString*)str withView:(UIView *)view
{
    if (!view) {
        view = [[[UIApplication sharedApplication] delegate] window];
    }
    MBProgressHUD * progressView = [[MBProgressHUD alloc] initWithView:view];
    progressView.animationType = MBProgressHUDAnimationZoomOut;
    progressView.label.text = str;
    [view addSubview:progressView];
    [progressView showAnimated:YES];
    return progressView;
}

-(void)stopWaitProgressView:(MBProgressHUD *)view
{
    if (view){
        [view removeFromSuperview];
    }
    else{
        for (UIView * view in self.view.subviews) {
            if ([view isKindOfClass:[MBProgressHUD class]]) {
                [view removeFromSuperview];
            }
        }
        for (UIView * view in [[[UIApplication sharedApplication] delegate] window].subviews) {
            if ([view isKindOfClass:[MBProgressHUD class]]) {
                [view removeFromSuperview];
            }
        }
    }
    
}

- (void)showPopAlerViewWithMes:(NSString *)message withDelegate:(id<UIAlertViewDelegate>)delegate cancelButton:(NSString *)cancelTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    UIAlertView * popA = [[UIAlertView alloc] initWithTitle:nil message:message delegate:delegate cancelButtonTitle:cancelTitle otherButtonTitles:otherButtonTitles, nil];
    [popA show];
#pragma clang disgnostic pop
    
}

- (void)showTotasViewWithMes:(NSString *)message
{
    if(!message || ![message isKindOfClass:[NSString class]] || ![message length]) return;
    ToastAlertView * alertView = [[ToastAlertView alloc] initWithTitle:message controller:self];
    [alertView show];
}

- (void)showPopAlerViewWithMes:(NSString *)message
{
    [self showPopAlerViewWithMes:message withDelegate:nil cancelButton:@"确定" otherButtonTitles:nil];
}

@end


@implementation UIView(Tips)

- (void)showTotasViewWithMes:(NSString *)message
{
    if(!message || ![message isKindOfClass:[NSString class]] || ![message length]) return;
    ToastAlertView * alertView = [[ToastAlertView alloc] initWithTitle:message view:self];
    [alertView show];
    
}

@end

@implementation UIViewController(NetWork)
- (void)dealErrorResponseWithTableView:(RefreshTableView *)tableview info:(NSDictionary *)dic
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self showTotasViewWithMes:[[dic objectForKey:@"result"] objectForKey:@"msg"]];
    [tableview.refreshHeader endRefreshing];
    [tableview.refreshFooter endRefreshing];
}

- (void)netErrorWithTableView:(RefreshTableView*)tableView
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self showTotasViewWithMes:@"网络异常，稍后重试"];
    [tableView.refreshHeader endRefreshing];
    [tableView.refreshFooter endRefreshing];
    [tableView.refreshFooter.footerView setHidden:NO];

}

@end

@implementation NSObject(Window)

- (BOOL)isUserFavData
{
    AppDelegate * applicationDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return applicationDelegate.isUseFavMan;
}
@end

