//
//  BMAssetsCell.m
//  basicmap
//
//  Created by quke on 2017/2/7.
//  Copyright © 2017年 baidu. All rights reserved.
//

#import "BMAssetsCell.h"
#import <AssetsLibrary/AssetsLibrary.h>


@interface BMAssetsCell()
@property(nonatomic,strong)UIImageView * posteImage;
@property(nonatomic,strong)UIImageView * vedioTag;

@end

@implementation BMAssetsCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    self.posteImage = [[UIImageView alloc] init];
    [self addSubview:self.posteImage];
    [self.posteImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    self.vedioTag = [[UIImageView alloc] init];
    self.vedioTag.image = [UIImage imageNamed:@"vedio_tag"];
    [self.posteImage addSubview:self.vedioTag];
    
    [self.vedioTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.posteImage).offset(5);
        make.bottom.equalTo(self.posteImage).offset(-5);
    }];
}

- (void)setAsset:(ALAsset *)asset
{
    _asset = asset;
    self.posteImage.image = [UIImage imageWithCGImage:[asset aspectRatioThumbnail]];
    
    NSString * type = [asset valueForProperty:ALAssetPropertyType];
    [self.vedioTag setHidden:![type isEqualToString:ALAssetTypeVideo]];
}
@end
