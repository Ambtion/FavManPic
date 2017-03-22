//
//  SCPAlert_CustomeView.m
//  SohuCloudPics
//
//  Created by sohu on 12-12-28.
//
//

#import "ToastAlertView.h"

@implementation ToastAlertView

- (id)initWithTitle:(NSString *)title
{
    if (self = [super init]) {
        [self initUIWithTitle:title];
    }
    return self;
}

- (id)initWithTitle:(NSString *)title view:(UIView *)view
{
    self = [super init];
    if (self) {
        _superView = view;
        [self initUIWithTitle:title];
    }
    return self;
}


- (void)dismiss
{
    [self removeFromSuperview];
}

- (id)initWithTitle:(NSString *)title controller:(id)viewcontroller
{
    if (self = [super init]) {
        _controller = [viewcontroller isKindOfClass:[UIViewController class]]? viewcontroller :nil;
        [self initUIWithTitle:title];
    }
    return self;
}


- (void)initUIWithTitle:(NSString *)title
{
    CGRect rect = [[UIScreen mainScreen] bounds];
    _alertboxImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _alertboxImageView.image = [[UIImage imageNamed:@"popup_alert.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(4, 4, 4, 4)];
    [self addSubview:_alertboxImageView];
    
    _title = [[UILabel alloc] initWithFrame:CGRectZero];
    _title.textAlignment = NSTextAlignmentCenter;
    _title.backgroundColor = [UIColor clearColor];
    _title.font = [UIFont systemFontOfSize:16];
    _title.textColor = [UIColor whiteColor];
    _title.text = title;
    [_title sizeToFit];
    _alertboxImageView.frame = CGRectMake(0, 0, _title.frame.size.width + 56, 44);
    _alertboxImageView.center = CGPointMake(rect.size.width / 2.f, rect.size.height / 2.f);
    _title.center = CGPointMake(_alertboxImageView.frame.size.width /2.f, _alertboxImageView.frame.size.height/2.f);
    [_alertboxImageView addSubview:_title];
}

- (void)show
{
    if (_controller && [self isTopShowController:_controller]){
        UIWindow * win = [[UIApplication sharedApplication].delegate window];
        for (UIView * view in [win subviews]) {
            if ([view isKindOfClass:[ToastAlertView class]] ) {
                return;
            }
        }
        for (UIView * view in [_controller.view subviews]) {
            if ([view isKindOfClass:[ToastAlertView class]] ) {
                return;
            }
        }
        [_controller.view addSubview:self];
    }else if(_superView){
        [_superView addSubview:self];
        
    }else{
        UIWindow * win = [[UIApplication sharedApplication].delegate window];
        for (UIView * view in [win subviews]) {
            if ([view isKindOfClass:[ToastAlertView class]] ) {
                return;
            }
        }
        [win addSubview:self];
    }
    
    double delayInSeconds = 1.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self dismiss];
    });
}

- (BOOL)isTopShowController:(UIViewController *)controller
{
    UIViewController * rootController = [[UIApplication sharedApplication].delegate window].rootViewController;
    if ([rootController isKindOfClass:[UINavigationController class]]) {
        return controller == [(UINavigationController *)rootController topViewController];
    }
    
    if ([rootController isKindOfClass:[UITabBarController class]]) {
        return controller == [(UITabBarController *)rootController selectedViewController];
    }
    return controller == rootController;
}
@end
