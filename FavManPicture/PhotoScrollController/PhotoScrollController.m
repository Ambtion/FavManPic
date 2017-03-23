//
//  PhotoScrollController.m
//  FavManPicture
//
//  Created by quke on 2017/3/23.
//  Copyright © 2017年 linjunhou. All rights reserved.
//

#import "PhotoScrollController.h"
#import "PhotoImageScaleCell.h"

const NSTimeInterval CarOwnerActivityScrollTimerInterval = 3.0f;


@interface PhotoScrollController ()<UICollectionViewDelegate,UICollectionViewDataSource,PhotoImageScaleCellDelegate>

@property(nonatomic,strong)NSArray * dataSource;
@property(nonatomic,strong)UICollectionView * colletctionView;

@property(nonatomic,strong)UIView * cusNavBar;
@property(nonatomic,strong)UILabel * navLabel;
@property(nonatomic,strong)UIButton * playButton;
@property(nonatomic,strong)UIButton * downloadButton;

@property(nonatomic,strong)NSTimer * rotateTimer;
@end

@implementation PhotoScrollController

- (instancetype)initWithGropAsset:(NSArray *)photoArrays
{
    self = [super init];
    if (self) {
        self.dataSource = photoArrays;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)initUI
{
    
    
    UIView * view = [UIView new];
    [self.view addSubview:view];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = self.view.frame.size;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;

    self.colletctionView =  [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.colletctionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.colletctionView.clipsToBounds = YES;
    self.colletctionView.pagingEnabled = YES;
    self.colletctionView.backgroundColor = [UIColor whiteColor];
    
    self.colletctionView.delegate = self;
    self.colletctionView.dataSource = self;
    [self.view addSubview:self.colletctionView];
    
    [self.colletctionView registerClass:[PhotoImageScaleCell class] forCellWithReuseIdentifier:@"PhotoImageScaleCell"];
    
    [self initCustNavBar];
    
}

- (void)initCustNavBar
{
    self.cusNavBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 64)];
    self.cusNavBar.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.cusNavBar];
    
    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    [backButton setImage:[UIImage imageNamed:@"baseNavigationBar_back_black_line_arrow"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"baseNavigationBar_back_black_line_arrow"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
    
    [self.cusNavBar addSubview:backButton];
    
    self.navLabel = [[UILabel alloc] init];
    self.navLabel.font = [UIFont boldSystemFontOfSize:15.f];
    self.navLabel.textColor = [UIColor blackColor];
    self.navLabel.text = [NSString stringWithFormat:@"%ld/%lu",(long)[self curIndexPage] + 1,(unsigned long)self.dataSource.count];
    [self.cusNavBar addSubview:self.navLabel];
    
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cusNavBar).offset(12);
        make.centerY.equalTo(self.cusNavBar).offset(10);
        make.size.mas_equalTo(CGSizeMake(40, 30));
    }];
    
    [self.navLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.cusNavBar);
        make.centerY.equalTo(backButton);
    }];
    
    
    self.playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.playButton addTarget:self action:@selector(playButtonDidCilck:) forControlEvents:UIControlEventTouchUpInside];
    [self.cusNavBar addSubview:self.playButton];
    
    self.downloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.downloadButton addTarget:self action:@selector(downPicture) forControlEvents:UIControlEventTouchUpInside];
    [self.cusNavBar addSubview:self.downloadButton];
    
    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backButton);
        make.right.equalTo(self.cusNavBar).offset(-12);
        make.size.equalTo(backButton);
    }];
    
    [self.downloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(backButton);
        make.centerY.equalTo(backButton);
        make.right.equalTo(self.playButton.mas_left).offset(-20);
    }];
    
    self.playButton.backgroundColor = [UIColor redColor];
    [self.playButton setTitle:@"播放" forState:UIControlStateNormal];
    [self.playButton setTitle:@"停止" forState:UIControlStateSelected];
    
    self.downloadButton.backgroundColor = [UIColor greenColor];
    [self.downloadButton setTitle:@"保存" forState:UIControlStateSelected];

}

#pragma mark -- 滚动视图的代理方法

- (void)play
{
    self.rotateTimer = [NSTimer scheduledTimerWithTimeInterval:2.f target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    
}

- (void)stop
{
    [self.rotateTimer invalidate];
    self.rotateTimer = nil;
}

- (void)nextPage
{
    if (!self.dataSource.count) {
        [self stop];
        return;
    }
    
    NSInteger indexPage = [self curIndexPage];
    NSInteger nextPage = indexPage + 1;
    NSInteger totalIndex = self.dataSource.count;
    
    if (nextPage >= totalIndex) {
        nextPage = 0;
        [self.colletctionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:nextPage inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];

    }else{
        [self.colletctionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:nextPage inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
}

#pragma mark - navBar
- (BOOL)ishidenBar
{
    return self.cusNavBar.bottom == 0;
}
- (void)hideNavBar
{
    [UIView animateWithDuration:0.3 animations:^{
        self.cusNavBar.bottom = 0;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)showNavBar
{
    [UIView animateWithDuration:0.3 animations:^{
        self.cusNavBar.top = 0;
    } completion:^(BOOL finished) {
        
    }];

}

#pragma mark - Download

- (void)image: (UIImage *) image didFinishSavingWithError:(NSError *)error contextInfo: (void *) contextInfo
{
    [self stopWaitProgressView:nil];
    if (error) {
        [self showTotasViewWithMes:@"保存失败"];
    }else{
        [self showTotasViewWithMes:@"图片已保存到本地"];
    }
}


#pragma mark - Delegate
#pragma mark source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoImageScaleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoImageScaleCell" forIndexPath:indexPath];
    cell.delegate = self;
    NSString * url = self.dataSource[indexPath.row];
    [[cell scaleImageView].imageView startLoading];
    [cell.scaleImageView.imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [[cell scaleImageView].imageView stopLoading];
    }];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.navLabel.text = [NSString stringWithFormat:@"%ld/%lu",(long)[self curIndexPage] + 1,(unsigned long)self.dataSource.count];
}

- (NSInteger)curIndexPage
{

    NSInteger curPage = floorf(([self.colletctionView contentOffset].x + self.colletctionView.bounds.size.width/2.f) / self.colletctionView.bounds.size.width);
    return curPage;
}

#pragma mark - Action
- (void)popself
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)playButtonDidCilck:(UIButton *)button
{
    if (button.isSelected) {
        [self stop];
    }else{
        [self play];
    }
    
    button.selected = !button.isSelected;
    
}

- (void)downPicture
{
    
    NSInteger curIndex = [self curIndexPage];
    
    if (curIndex >= 0 && curIndex < self.dataSource.count) {
        
        NSString * urlStr = self.dataSource[curIndex];
        [self waitForMomentsWithTitle:@"保存到本地..." withView:self.view];
        UIImageView * view = [[UIImageView alloc] init];
        [view sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (!error && image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
                });
                
            }else{
                [self stopWaitProgressView:nil];
                [self showTotasViewWithMes:@"保存失败"];
                
            }
            
        }];
        
    }
}

- (void)photoImageScaleCellDidClick:(PhotoImageScaleCell *)cell
{
    if ([self ishidenBar]) {
        [self showNavBar];
    }else{
        [self hideNavBar];
    }
}

@end
