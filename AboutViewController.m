//
//  AboutViewController.m
//  FavManPicture
//
//  Created by quke on 2017/4/20.
//  Copyright © 2017年 linjunhou. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"关于";
    
    UIImageView * image = [[UIImageView alloc] init];
    image.image = [UIImage imageNamed:@"icon"];
    [self.view addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    
    UILabel * version = [[UILabel alloc] init];
    version.text = @"v1.0.0";
    version.textColor = UIColorFromRGB(0x333333);
    version.font = [UIFont systemFontOfSize:12.f];
    [self.view addSubview:version];
    
    [version mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(image.mas_bottom).offset(5);
        make.centerX.equalTo(self.view);
    }];
    
    UILabel * bottom = [[UILabel alloc] init];
    bottom.text = @"2017 Yijiameng Inc 北京忆嘉萌文化传播有限公司";
    bottom.textColor = UIColorFromRGB(0x333333);
    bottom.font = [UIFont systemFontOfSize:10];
    [self.view addSubview:bottom];
    
    [bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-10);
    }];
}


@end
