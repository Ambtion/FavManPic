//
//  BMAssetsListController.m
//  basicmap
//
//  Created by quke on 2017/2/7.
//  Copyright © 2017年 baidu. All rights reserved.
//

#import "BMAssetsListController.h"
#import "BMAssetsCell.h"
#import "PhotoScrollController.h"
#import "HcdActionSheet.h"
#import "HTWebPay.h"
#import <UMMobClick/MobClick.h>
#import "NetWorkEntity.h"

@interface BMAssetsListController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,strong)FMGroupModel * groupModel;
@property(nonatomic,strong)NSArray * dataSource;
@property(nonatomic,strong)NSArray * oriSource;

@end

@implementation BMAssetsListController
- (instancetype)initWithGropAsset:(FMGroupModel *)groupModel
{
    self = [super init];
    if (self) {
        self.groupModel = groupModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
    [self loadDataSource];
}

- (void)initUI
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[BMAssetsCell class] forCellWithReuseIdentifier:@"BMAssetsCell"];
    [self.view addSubview:self.collectionView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = self.groupModel.title;
    [self  refreshRighButton];
}

- (void)refreshRighButton
{
    
    if ([self isUserFavData] && ![[FMConfigManager sharedInstance] isPay] ) {
        self.navigationItem.rightBarButtonItems = @[[self createBuyButton],[self barSpaingItem]];
    }else{
        self.navigationItem.rightBarButtonItem = nil;
    }
}

-(UIBarButtonItem*) createBuyButton
{
    CGRect backframe= CGRectMake(0, 0, 28, 28);
    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = backframe;
    [backButton setImage:[UIImage imageNamed:@"buy"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"buy"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(payForAction) forControlEvents:UIControlEventTouchUpInside];
    //定制自己的风格的  UIBarButtonItem
    UIBarButtonItem* someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:backButton];
    return someBarButtonItem;
    
}

- (UIBarButtonItem*)barSpaingItem
{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       
                                       target:nil action:nil];
    negativeSpacer.width = -12;
    return negativeSpacer;
}

- (void)loadDataSource
{
    
    if ([self isUserFavData]) {
        NSString * contentUrl = [NSString stringWithFormat:@"%@%@/%@",[FMConfigManager sharedInstance].configModel.picture_url_header,self.groupModel.source.catalog,self.groupModel.issue];
        NSMutableArray * dataMstr = [NSMutableArray arrayWithCapacity:0];
        
        for (NSInteger i = 0; i < self.groupModel.pictureCount; i++) {
            NSString * url = [NSString stringWithFormat:@"%@/%ld.jpg",contentUrl,(long)i];
            [dataMstr addObject:url];
        }
        
        self.dataSource = dataMstr;
        [self.collectionView reloadData];
    }else{
        if(![MBProgressHUD HUDForView:self.view])
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        [NetWorkEntity quaryCategoryDetailWithCatergoryId:self.groupModel.id Success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            if ([[responseObject objectForKey:@"result"] isEqualToString:@"ok"] && [[[responseObject objectForKey:@"data"] objectForKey:@"wallpaper"] count]) {
                NSArray * sourceList = [[responseObject objectForKey:@"data"] objectForKey:@"wallpaper"];
                NSMutableArray * thumbUrl = [NSMutableArray arrayWithCapacity:0];
                NSMutableArray * orUrl = [NSMutableArray arrayWithCapacity:0];
                for (NSDictionary * info in sourceList) {
                    [thumbUrl addObject:[info objectForKey:@"thumbnail"]];
                    [orUrl addObject:[info objectForKey:@"img_url"]];
                }
                self.dataSource = thumbUrl;
                self.oriSource = orUrl;
                [self.collectionView reloadData];
            }else{
                [self showTotasViewWithMes:@"网络异常稍后重试"];
            }
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self showTotasViewWithMes:@"网络异常稍后重试"];
        }];

    }
   
}

#pragma mark - Delegate
#pragma mark layout
static float itemSpacing = 3;
static float itemOffset = 3.5;
static NSInteger lineCount = 3;

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(itemOffset, itemOffset, itemOffset, itemOffset);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellMargin = (collectionView.width - itemOffset * 2 - (lineCount - 1) * itemSpacing)/ lineCount;
    cellMargin = floor(cellMargin*100)/100;
    return CGSizeMake(cellMargin, cellMargin);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return itemSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return itemSpacing;
}

#pragma mark source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BMAssetsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BMAssetsCell" forIndexPath:indexPath];
    NSString * url = self.dataSource[indexPath.row];
    [[cell.posteImage imageView] sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"default_cell"]];
    return cell;
}

#pragma mark Action
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self isUserFavData] && ![[FMConfigManager sharedInstance] isPay] ) {
        [self payForAction];
        return;
    }
    
    NSArray * dataSource = self.dataSource;
    if (!self.isUserFavData) {
        dataSource = self.oriSource;
    }
    PhotoScrollController * phS = [[PhotoScrollController alloc] initWithGropAsset:dataSource defaultIndex:indexPath.row];
    [self.navigationController pushViewController:phS animated:YES];
}

#pragma mark - 

- (void)payForAction
{
    
    NSInteger payUnit = 100;

    HcdActionSheet *sheet = [[HcdActionSheet alloc] initWithCancelStr:@"取消"
                                                    otherButtonTitles:@[@"6元/月(微信支付)",@"36元/年(微信支付)"]
                                                          attachTitle:nil];
    
    sheet.selectButtonAtIndex = ^(NSInteger index) {
        if (index == 1) {
            // paySucess
            // failPay
            [MobClick event:@"payForAction" attributes:@{
                                                      @"type":@"month"
                                                      }];

            
            WS(ws);
            
            if(![MBProgressHUD HUDForView:self.view])
                [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            
            [NetWorkEntity getDepositInfoWithWithManayCount:payUnit * 6 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                [MBProgressHUD hideHUDForView:ws.view animated:YES];
                
                if ([[[responseObject objectForKey:@"result"] objectForKey:@"error"] intValue] == 0) {
                    NSDictionary * dic = [responseObject objectForKey:@"content"];
                    WebPayInfoModel * model  = [WebPayInfoModel yy_modelWithJSON:dic];
                    [HTWebPay sendPayRequestWithPayInfo:model callBack:^(BaseResp *resp) {
                        if (resp.errCode == 0) {
                            [ws showTotasViewWithMes:@"支付成功"];
                            [[FMConfigManager sharedInstance] setPay:YES];
                            [self refreshRighButton];
                            //[MobClick event:@"paySucess" attributes:@{ @"type":@"month"} counter:6];
                        }else{
                            [ws showTotasViewWithMes:@"支付失败"];
                            
                        }
                    }];
                    
                }else{
                    [ws showTotasViewWithMes:[[responseObject objectForKey:@"result"] objectForKey:@"msg"]];
                }
                
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [self showTotasViewWithMes:@"网络异常,稍后重试"];
                [MBProgressHUD hideHUDForView:ws.view animated:YES];
                
            }];


        }
        
        if (index == 2) {
            [MobClick event:@"payForAction" attributes:@{
                                                      @"type":@"year"
                                                      }];

            WS(ws);
            
            if(![MBProgressHUD HUDForView:self.view])
                [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            
            [NetWorkEntity getDepositInfoWithWithManayCount:payUnit * 36 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                [MBProgressHUD hideHUDForView:ws.view animated:YES];
                
                if ([[[responseObject objectForKey:@"result"] objectForKey:@"error"] intValue] == 0) {
                    NSDictionary * dic = [responseObject objectForKey:@"content"];
                    WebPayInfoModel * model  = [WebPayInfoModel yy_modelWithJSON:dic];
                    [HTWebPay sendPayRequestWithPayInfo:model callBack:^(BaseResp *resp) {
                        if (resp.errCode == 0) {
                            [ws showTotasViewWithMes:@"支付成功"];
                            [[FMConfigManager sharedInstance] setPay:YES];
                            [self refreshRighButton];
                            //[MobClick event:@"paySucess" attributes:@{ @"type":@"month"} counter:36];
                        }else{
                            [ws showTotasViewWithMes:@"支付失败"];
                        }
                    }];
                    
                }else{
                    [ws showTotasViewWithMes:[[responseObject objectForKey:@"result"] objectForKey:@"msg"]];
                }
                
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [self showTotasViewWithMes:@"网络异常,稍后重试"];
                [MBProgressHUD hideHUDForView:ws.view animated:YES];
                
            }];
            
            

        }
    };
    [[UIApplication sharedApplication].keyWindow addSubview:sheet];
    [sheet showHcdActionSheet];

}
@end
