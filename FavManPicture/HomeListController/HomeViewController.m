//
//  HomeViewController.m
//  FavManPicture
//
//  Created by quke on 2017/3/22.
//  Copyright © 2017年 linjunhou. All rights reserved.
//

#import "HomeViewController.h"
#import "RefreshTableView.h"
#import "HomeGropCell.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)RefreshTableView * tableView;

@property(nonatomic,strong)NSMutableArray* dataSource;
@property(nonatomic,assign)NSInteger page;
@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initUI];
    [self quaryDataWithRefresh:YES];
}

- (void)initUI
{
    UIView * view = [UIView new];
    [self.view addSubview:view];
    
    self.tableView = [[RefreshTableView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self initRefreshView];
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
}

- (void)initRefreshView
{
    WS(ws);
    self.tableView.refreshHeader.beginRefreshingBlock = ^(){
        [ws quaryDataWithRefresh:YES];
    };
    
    ws.tableView.refreshFooter.beginRefreshingBlock = ^(){
        [ws quaryDataWithRefresh:NO];
    };
    
}

#pragma mark - Quary

/*
 * 1 : 刷新
 * 2 : 翻页
 */
- (void)quaryDataWithRefresh:(BOOL)isRefresh
{
    
    if(![MBProgressHUD HUDForView:self.view])
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    WS(ws);
    
    void (^ failure)(AFHTTPRequestOperation *, NSError *) = ^(AFHTTPRequestOperation *operation, NSError *error){
        [ws netErrorWithTableView:self.tableView];
    };
    
    NSInteger page = 1;
    if (isRefresh) {
        page = 1;
    }else{
        page = self.page + 1;
    }
    
    [NetWorkEntity quaryPhotoListWithPage:page photoPype:0 authorId:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD hideHUDForView:ws.view animated:YES];
        [ws.tableView.refreshHeader endRefreshing];
        [ws.tableView.refreshFooter endRefreshing];
        
        if ([[responseObject objectForKey:@"success"] boolValue]) {
            
            NSArray * list = [[responseObject objectForKey:@"data"] objectForKey:@"list"];
            if (list.count == 0) {
                [self showTotasViewWithMes:@"已经最多"];
                return ;
            }

            if (isRefresh) {
                ws.dataSource = [[ws analysisPoiListModelFromArray:list] mutableCopy];
                self.page = 1;

            }else{
                [ws.dataSource addObjectsFromArray:[ws analysisPoiListModelFromArray:list]];
                self.page++;
            }
            [ws.tableView reloadData];
            
        }else{
            [ws showTotasViewWithMes:[responseObject objectForKey:@"msg"]];
        }
    } failure:failure];
}

- (NSArray *)analysisPoiListModelFromArray:(NSArray *)array
{
    if (![array isKindOfClass:[NSArray class]]) {
        return nil;
    }
    
    NSMutableArray * mArray = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary * dic  in array) {
        FMGroupModel * model = [FMGroupModel yy_modelWithJSON:dic];
        if (model) {
            [mArray addObject:model];
        }
    }
    return mArray;
}


#pragma mark - TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [HomeGropCell heightForCell];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HomeGropCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HomeGropCell"];
    if (!cell) {
        cell = [[HomeGropCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeGropCell"];
    }
    cell.groupModel = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark Action

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
