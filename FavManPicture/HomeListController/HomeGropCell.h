//
//  HomeGropCell.h
//  FavManPicture
//
//  Created by quke on 2017/3/22.
//  Copyright © 2017年 linjunhou. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HomeGropCell;

@protocol HomeGropCellDelegate <NSObject>

- (void)homeGropCellheadViewDidCick:(HomeGropCell *)cell;

@end

@interface HomeGropCell : UITableViewCell

@property(nonatomic,strong)FMGroupModel * groupModel;

@property(nonatomic,weak)id<HomeGropCellDelegate>delegate;

+ (CGFloat)heightForCell;


@end
