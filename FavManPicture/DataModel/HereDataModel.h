//
//  HereDataModel.h
//  HRER
//
//  Created by quke on 16/5/30.
//  Copyright © 2016年 linjunhou. All rights reserved.
//


#import "YYModel.h"

@interface FMSourceModel : NSObject

@property(nonatomic,strong)NSString * id;
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSString * catalog;
@property(nonatomic,assign)NSInteger lastSuiteId;
@property(nonatomic,assign)NSInteger suiteCount;
@property(nonatomic,assign)NSInteger pictureCount;

@end


@interface FMAuthorModel : NSObject

@property(nonatomic,strong)NSString * id;
@property(nonatomic,strong)NSString * nickname;
@property(nonatomic,strong)NSString * headerUrl;
@property(nonatomic,assign)NSInteger sex; //1男 2女
@property(nonatomic,assign)CGFloat height;
@property(nonatomic,assign)CGFloat weight;
@property(nonatomic,strong)NSString * bwh;
@property(nonatomic,strong)NSString * birthday;
@property(nonatomic,strong)NSString * area;

@end

@interface FMGroupModel : NSObject
@property(nonatomic,strong)NSString * id;
@property(nonatomic,strong)NSString * authorId;
@property(nonatomic,strong)NSString * sourceId;
@property(nonatomic,strong)NSString * issue;
@property(nonatomic,strong)NSString * title;
@property(nonatomic,strong)NSString * headImageFilename;
@property(nonatomic,assign)NSInteger pictureCount;
@property(nonatomic,assign)NSInteger level;
@property(nonatomic,assign)NSInteger vip;
@property(nonatomic,assign)NSInteger createTime;

@property(nonatomic,assign)NSInteger favoriteCount;

@property(nonatomic,strong)FMSourceModel * source;
@property(nonatomic,strong)FMAuthorModel * author;

@property(nonatomic,strong)NSString * icon_url;
@property(nonatomic,strong)NSString * por_url;

@end



@interface FMCommonModel : NSObject
@property(nonatomic,strong)NSString * sound_url_header;
@property(nonatomic,strong)NSString * header_url_header;
@property(nonatomic,strong)NSString * picture_url_header;
@property(nonatomic,assign)NSInteger audio_count;

@end

@interface WebPayInfoModel : NSObject
@property(nonatomic,strong)NSString * appid;
@property(nonatomic,strong)NSString * partnerid;
@property(nonatomic,strong)NSString * prepayid;
@property(nonatomic,assign)UInt32 timestamp;
@property(nonatomic,strong)NSString * noncestr;
@property(nonatomic,strong)NSString * package;
@property(nonatomic,strong)NSString * sign;
@property(nonatomic,assign)NSInteger needPay;
@end
