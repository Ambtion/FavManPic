//
//  BMJWNagationController.m
//  JewelryApp
//
//  Created by kequ on 15/6/7.
//  Copyright (c) 2015年 jewelry. All rights reserved.
//

#import "BMJWNagationController.h"

@interface BMJWNagationController()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>
@property(nonatomic,assign)BOOL isAnimaiton;
@end

@implementation BMJWNagationController

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        self.delegate = self;
        self.isAnimaiton = NO;
        self.interactivePopGestureRecognizer.delegate = self;

    }
    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated

{
    if(self.isAnimaiton){
        return;
    }
    @try {
        [super pushViewController:viewController animated:animated];
        [viewController.navigationItem setHidesBackButton:YES];
        if (viewController.navigationItem.leftBarButtonItem == nil && [self.viewControllers count] > 1)
            
        {
            viewController.navigationItem.leftBarButtonItems = @[[self barSpaingItem],[self createBackButton]];
        }
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
    }
}

- (UIBarButtonItem*)barSpaingItem
{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       
                                       target:nil action:nil];
    negativeSpacer.width = -12;
    return negativeSpacer;
}


- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    if(self.isAnimaiton){
        return nil;
    }
    @try {
        UIViewController * controller = [super popViewControllerAnimated:animated];
        [controller.navigationItem setHidesBackButton:YES];
        return controller;
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

- (BOOL)isAnimaiton
{
    return _isAnimaiton;
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    if(self.isAnimaiton){
        return nil;
    }
    return [super popToRootViewControllerAnimated:animated];
}

-(void)popself
{
    [self popViewControllerAnimated:YES];
}

-(UIBarButtonItem*) createBackButton
{
    
    CGRect backframe= CGRectMake(0, 0, 40, 30);
    
    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
    
    backButton.frame = backframe;

    [backButton setImage:[UIImage imageNamed:@"baseNavigationBar_back_black_line_arrow"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"baseNavigationBar_back_black_line_arrow"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
    
    //定制自己的风格的  UIBarButtonItem
    UIBarButtonItem* someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:backButton];
    return someBarButtonItem;
    
}

#pragma mark - 
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(animated)
        self.isAnimaiton = YES;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    self.isAnimaiton = NO;
}

@end
