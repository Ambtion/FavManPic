//
//  BMAssetsListController.m
//  basicmap
//
//  Created by quke on 2017/2/7.
//  Copyright © 2017年 baidu. All rights reserved.
//

#import "BMAssetsListController.h"
#import "BMAssetsCell.h"

@interface BMAssetsListController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,strong)FMGroupModel * groupModel;
@property(nonatomic,strong)NSArray * dataSource;

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
}

- (void)loadDataSource
{
    NSString * contentUrl = [NSString stringWithFormat:@"%@%@/%@",[FMConfigManager sharedInstance].configModel.picture_url_header,self.groupModel.source.catalog,self.groupModel.issue];
    NSMutableArray * dataMstr = [NSMutableArray arrayWithCapacity:0];
    
    for (NSInteger i = 0; i < self.groupModel.pictureCount; i++) {
        NSString * url = [NSString stringWithFormat:@"%@/%ld.jpg",contentUrl,(long)i];
        [dataMstr addObject:url];
    }

    self.dataSource = dataMstr;
    [self.collectionView reloadData];
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
    [[cell.posteImage imageView] sd_setImageWithURL:[NSURL URLWithString:url]];
    return cell;
}

#pragma mark Action
- (void)onCancelDidClick:(id)sender
{
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
