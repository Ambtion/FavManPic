//
//  TripSegmentController.h
//  SliderMenuDemon
//
//  Created by quke on 15/12/15.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TripSegmentController;
@protocol TripSegmentControllerDelegate <NSObject>
@optional

- (void)tripSegmentController:(TripSegmentController *)segmentedControl selectedIndex:(NSInteger)index;
- (void)tripSegmentController:(TripSegmentController *)segmentedControl selectedIndex:(NSInteger)index fromIndex:(NSInteger)fromIndex;
@end

@interface TripSegmentController : UIView
@property(nonatomic,weak)id<TripSegmentControllerDelegate>delegate;
@property(nonatomic,assign,readonly)CGFloat spacing;            //按钮间的间距
@property(nonatomic,assign,readonly)UIEdgeInsets insets;
@property(nonatomic,assign)CGFloat contentOffset;      //contentOffset
@property(nonatomic,assign)NSInteger seletedIndex;    //选择的Index
@property(nonatomic,strong)UIFont * titleFont;
@property(nonatomic,strong)UIColor * normalColor;
@property(nonatomic,strong)UIColor * seletedColor;

- (instancetype)initWithFrame:(CGRect)frame data:(NSArray *)dataArray Inset:(UIEdgeInsets)insets spacing:(CGFloat)spacing;


/**
 *  刷新seg界面
 *
 *  @param titleArray @[NSString,NSString]格式
 */

- (void)refreshContentWithTitleArray:(NSArray *)titleArray;

/*
 * 特别注意：由于seletedIndex都有对应的contetnOffest,所以在用户手动移动了ScrollView的offset的时候，
 * 先使用setSeletedIndex展示选择态，然后使用setContentOffset:(CGFloat)contentOffset函数确定offset
 *
 *  setSeletedIndex调用会触发ScrollView setContentOffset，
 *  setContentOffset要保证在setSeletedIndex之后调用
 */
- (void)setSeletedIndex:(NSInteger)seletedIndex;
- (void)setContentOffset:(CGFloat)contentOffset;


/**
 *  Item显示小红点
 *
 *  @param isShow 是否显示小红点
 *  @param index  要显示小红点的Item
 */
- (void)showHotRed:(BOOL)isShow AtIndex:(NSInteger)index;

@end
