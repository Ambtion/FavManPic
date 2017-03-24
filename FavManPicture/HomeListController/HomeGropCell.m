//
//  HomeGropCell.m
//  FavManPicture
//
//  Created by quke on 2017/3/22.
//  Copyright © 2017年 linjunhou. All rights reserved.
//

#import "HomeGropCell.h"
#import "PortraitView.h"
#import "DataConvert.h"

@interface HomeGropCell()

@property(nonatomic,strong)PortraitView * contentImageView;
@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UILabel * createTime;
@property(nonatomic,strong)UIView * headView;

@property(nonatomic,strong)PortraitView * authorView;

@property(nonatomic,strong)UIView * footView;
@property(nonatomic,strong)UILabel * groupTitle;

@property(nonatomic,strong)UILabel * sourceName;
@property(nonatomic,strong)UIView * sourcebgView;

@property(nonatomic,strong)UIImageView * iconView;
@property(nonatomic,strong)UILabel * countLabel;



@end

@implementation HomeGropCell

+ (CGFloat)heightForCell
{
    return 460;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = UIColorFromRGB(0xf4f4f4);
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    self.headView = [[UIView alloc] init];
    self.headView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.headView];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headViewDidClick:)];
    [self.headView addGestureRecognizer:tap];
    
    
    self.authorView = [[PortraitView alloc] init];
    self.authorView.layer.cornerRadius = 22.f;
    [self.headView addSubview:self.authorView];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.font = [UIFont systemFontOfSize:13.f];
    self.nameLabel.textColor = UIColorFromRGB(0x5b5b5b);
    [self.headView addSubview:self.nameLabel];
    
    self.createTime = [[UILabel alloc] init];
    self.createTime.textColor = UIColorFromRGB(0xa9a9a9);
    self.createTime.font = [UIFont systemFontOfSize:12.f];

    [self.headView addSubview:self.createTime];
    
    
    
    self.contentImageView = [[PortraitView alloc] init];
    [self.contentView addSubview:self.contentImageView];
    
    self.footView = [[UIView alloc] init];
    self.footView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.footView];
    
    
    self.groupTitle = [[UILabel alloc] init];
    self.groupTitle.font = [UIFont boldSystemFontOfSize:13.f];
    self.groupTitle.textColor = UIColorFromRGB(0x5b5b5b);
    [self.footView addSubview:self.groupTitle];
    
    
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.width.equalTo(self);
        make.height.equalTo(@(54));
        make.top.equalTo(self);
    }];
    
    [self.authorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headView).offset(10);
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.centerY.equalTo(self.headView);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.authorView.mas_right).offset(5.f);
        make.centerY.equalTo(self.authorView);
    }];
    
    [self.createTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headView);
        make.right.equalTo(self.headView).offset(-10);
    }];
        
    
    [self.contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.width.equalTo(self);
        make.top.equalTo(self.headView.mas_bottom);
        make.bottom.equalTo(self.footView.mas_top);
    }];

    
    [self.footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.width.equalTo(self);
        make.height.equalTo(@(38));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    
    [self.groupTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.authorView);
        make.centerY.equalTo(self.footView);
    }];
    
}

- (void)setGroupModel:(FMGroupModel *)groupModel
{
    if (_groupModel == groupModel) {
        return;
    }
    _groupModel = groupModel;
    
    NSString * porImage = [NSString stringWithFormat:@"%@%@",[FMConfigManager sharedInstance].configModel.header_url_header,groupModel.author.headerUrl];
    [self.authorView.imageView sd_setImageWithURL:[NSURL URLWithString:porImage]];
    
    self.nameLabel.text = _groupModel.author.nickname;
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:_groupModel.createTime/ 1000.f];
    self.createTime.text = [[[DataConvert shareInstance] dateFormatter] stringFromDate:date];
    
    if ([self isUserFavData]) {
        NSString * contentUrl = [NSString stringWithFormat:@"%@%@/%@/%@",[FMConfigManager sharedInstance].configModel.picture_url_header,groupModel.source.catalog,groupModel.issue,groupModel.headImageFilename];
        [self.contentImageView.imageView sd_setImageWithURL:[NSURL URLWithString:contentUrl] placeholderImage:[UIImage imageNamed:@"default_cell"]];
    }else{
        [self.contentImageView.imageView sd_setImageWithURL:[NSURL URLWithString:_groupModel.icon_url] placeholderImage:[UIImage imageNamed:@"default_cell"]];

    }
    
    self.groupTitle.text = _groupModel.title;
    
    
}

#pragma mark - Action
- (void)headViewDidClick:(UIButton *)button
{
    if([_delegate respondsToSelector:@selector(homeGropCellheadViewDidCick:)]){
        [_delegate homeGropCellheadViewDidCick:self];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{}
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{}



@end
