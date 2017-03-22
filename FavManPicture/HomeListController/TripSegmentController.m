//
//  TripSegmentController.m
//  SliderMenuDemon
//
//  Created by quke on 15/12/15.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "TripSegmentController.h"
#import "Masonry.h"

@interface HotRedButton : UIButton
@property(nonatomic,strong)UIImageView * hotRed;
@end


@implementation HotRedButton


- (UIImageView *)hotRed
{
    if (!_hotRed) {
        UIImage *dotImage = [UIImage imageNamed: @"icon_dot"];
        _hotRed = [[UIImageView alloc] initWithImage:dotImage];
        [self addSubview:_hotRed];
    }
    return _hotRed;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.hotRed.frame = CGRectMake(self.titleLabel.right, self.titleLabel.top, 8, 8);
}
@end

#define BUTTONEXPANDWIDHT 10

@interface TripSegmentController()
@property(nonatomic,strong)UIScrollView * scrollView;
@property(nonatomic,strong)NSArray * dataSource;
@property(nonatomic,strong)NSMutableArray * titleUIArray;
@property(nonatomic,strong)UIView * seleteIndicatorView;
@property(nonatomic,strong)UIImageView * leftMask;
@property(nonatomic,strong)UIImageView * rightMask;
@end
@implementation TripSegmentController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

- (instancetype)initWithFrame:(CGRect)frame data:(NSArray *)dataArray Inset:(UIEdgeInsets)insets spacing:(CGFloat)spacing
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0x33/255.f green:0x85/255.f blue:0xff/255.f alpha:1];
        self.backgroundColor = [UIColor clearColor];
        _spacing = spacing;
        _insets = insets;
        [self dataInit];
        [self UIInitWithTitleArray:dataArray];
    }
    return self;
}

- (void)dataInit
{
    _seletedIndex = 0;
    _contentOffset = 0.f;
    _titleFont = [UIFont boldSystemFontOfSize:16.f];
    _normalColor = UIColorFromRGB(0x989898);
    _seletedColor = UIColorFromRGB(0xcd446b);
}

- (void)UIInitWithTitleArray:(NSArray *)titleArray
{
    [self scrollViewInit];
    [self refreshContentWithTitleArray:titleArray];
}

- (void)scrollViewInit
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.backgroundColor = [UIColor clearColor];
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:NULL];
    [self addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)refreshContentWithTitleArray:(NSArray *)titleArray
{
    NSAssert([titleArray isKindOfClass:[NSArray class]] && titleArray.count, @"titleArray containted  must not be empty");
    if([self isArray:titleArray EqualToArray:self.dataSource]) return;
    self.dataSource = titleArray;
    [self generateContentWithTitleArray:titleArray];
    [self refreshIndicatorView];
    
    [self refreshMaskView];
}

- (BOOL)isArray:(NSArray *)titleArray EqualToArray:(NSArray *)oriArray
{
    if (titleArray.count == 0) {
        return NO;
    }
    
    if (titleArray.count != oriArray.count) {
        return NO;
    }
    
    BOOL isEqual = YES;
    for (NSInteger index = 0; index < titleArray.count; index++) {
        NSString * title = [titleArray objectAtIndex:index];
        NSString * oriTitle = [oriArray objectAtIndex:index];
        NSAssert([title isKindOfClass:[NSString class]] && title.length, @"dataArray containted  must be NSString");
        if (![oriTitle isEqualToString:title]) {
            isEqual = NO;
        }
    }
    return isEqual;
}

- (void)generateContentWithTitleArray:(NSArray *)titleArray
{
    
    for (UIView * item in self.scrollView.subviews) {
        if ([item superview]) {
            [item removeFromSuperview];
        }
    }
    
    self.titleUIArray = [NSMutableArray arrayWithCapacity:0];
    
    UIView * lastItem;
    for (NSUInteger i= 0; i < titleArray.count;i++) {
        NSString * title = [titleArray objectAtIndex:i];
        NSAssert([title isKindOfClass:[NSString class]] && title.length, @"dataArray containted  must be NSString");
        HotRedButton * item = [[HotRedButton alloc] init];
        [[item titleLabel] setFont:_titleFont];
        [item setTitleColor:self.normalColor forState:UIControlStateNormal];
        [item setTitleColor:self.seletedColor forState:UIControlStateSelected];
        [item setTitle:title forState:UIControlStateNormal];
        [item setTitle:title forState:UIControlStateSelected];
        [item.hotRed setHidden:YES];
        item.tag = i;
        [item addTarget:self action:@selector(segItemClick:) forControlEvents:UIControlEventTouchUpInside];
        [item sizeToFit];
        item.frame = CGRectMake(!lastItem ? self.insets.left : CGRectGetMaxX(lastItem.frame) + self.spacing,
                                self.frame.size.height/2.f - 15.f,
                                item.frame.size.width,
                                30.f);
        [self.scrollView addSubview:item];
        [self.titleUIArray addObject:item];
        
        lastItem = item;
    }
    
    //纠正button热区
    for (UIButton * button in self.titleUIArray ) {
        button.width += BUTTONEXPANDWIDHT;
        button.left -=5;
//        button.backgroundColor = [UIColor redColor];
    }
    
    CGFloat scrollViewRight = CGRectGetMaxX(lastItem.frame) + self.insets.right;
    
    if (scrollViewRight < self.scrollView.width) {
        //按钮不足布满全局
        self.scrollView.contentSize = CGSizeMake(self.scrollView.width, 0);
        CGFloat leftSpacing = self.scrollView.width - scrollViewRight;
        //居中纠正
        for (UIButton * button in self.titleUIArray ) {
            button.centerX += leftSpacing/2.f;
        }
        
    }else{
        self.scrollView.contentSize = CGSizeMake(scrollViewRight, 0);
    }
    
}

- (void)refreshIndicatorView
{
    if (!self.seleteIndicatorView) {
        self.seleteIndicatorView = [[UIView alloc] init];
        self.seleteIndicatorView.frame = CGRectMake(0, 0, 45.f, 2.5);
        self.seleteIndicatorView.backgroundColor = self.seletedColor;
        [self addSubview:self.seleteIndicatorView];
    }
    [self bringSubviewToFront:self.seleteIndicatorView];
}


- (void)refreshMaskView
{
    if(!self.leftMask){
        self.leftMask = [[UIImageView alloc] init];
        self.leftMask.image = [UIImage imageNamed:@"bg_left"];
        [self addSubview:self.leftMask];
        [self.leftMask mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.height.equalTo(self);
            make.width.equalTo(@(16.f));
        }];
    }
   
    if (!self.rightMask) {
        self.rightMask = [[UIImageView alloc] init];
        self.rightMask.image = [UIImage imageNamed:@"bg_rignt"];
        [self addSubview:self.rightMask];
        [self.rightMask mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.height.equalTo(self);
            make.width.equalTo(@(16.f));
        }];
    }
    [self bringSubviewToFront:self.leftMask];
    [self bringSubviewToFront:self.rightMask];
  
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    UIButton * button = [[self titleUIArray] objectAtIndex:_seletedIndex];
    [self canCelAllSeletedState];
    [button setSelected:YES];
    [self moveSeleteButtonToWithAnimation:NO Completion:NULL];
    
}

#pragma mark - 主题更换通知

- (void)themeChanged:(NSNotification*)notif
{
    self.leftMask.image = [UIImage imageNamed:@"bg_left"];
    self.rightMask.image = [UIImage imageNamed:@"bg_rignt"];
}

#pragma mark - IndexSeleted
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([@"contentOffset" isEqualToString:keyPath]) {
        if (_seletedIndex >= 0 && (_seletedIndex < self.titleUIArray.count)) {
            UIButton * button = [[self titleUIArray] objectAtIndex:_seletedIndex];
            CGPoint centerPoint = [self convertPoint:button.center fromView:button.superview];
            self.seleteIndicatorView.frame = CGRectMake(centerPoint.x - 45/2.f, self.frame.size.height - 2.5, 45.f, 2.5f);
        }
    }
}

- (void)canCelAllSeletedState
{
    for (UIButton * button in self.titleUIArray) {
        [button setSelected:NO];
    }
}

- (void)moveSeleteButtonToWithAnimation:(BOOL)isAmination Completion:(void (^ __nullable)(BOOL finished))completion
{
    if (_seletedIndex < 0 || (_seletedIndex >= self.titleUIArray.count)) {
        return;
    }
    
    UIButton * button = [[self titleUIArray] objectAtIndex:_seletedIndex];
    
    CGFloat centerX = button.centerX;
    centerX = centerX - self.scrollView.frame.size.width/2.f;
    CGFloat originX = centerX;
    originX = MAX(originX, 0);
    originX = MIN(originX, self.scrollView.contentSize.width - self.scrollView.frame.size.width);
    
    if (originX == [self scrollView].contentOffset.x) {
        
        CGPoint centerPoint = [self convertPoint:button.center fromView:button.superview];
        if (isAmination) {
            [self animations:^{
                self.seleteIndicatorView.frame = CGRectMake(centerPoint.x - 45/2.f, self.frame.size.height - 2.5, 45.f, 2.5f);
            } completion:completion];
        }else{
            self.seleteIndicatorView.frame = CGRectMake(centerPoint.x - 45/2.f, self.frame.size.height - 2.5, 45.f, 2.5f);
            if (completion) {
                completion(YES);
            }
        }
      
    }else{
        if (isAmination) {
            [self animations:^{
                [[self scrollView] setContentOffset:CGPointMake(originX, 0) animated:NO];
            } completion:completion];
        }else{
            [[self scrollView] setContentOffset:CGPointMake(originX, 0) animated:NO];
            if (completion) {
                completion(YES);
            }
        }
      
    }
}

- (void)animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion
{
    [UIView animateWithDuration:0.25 animations:animations completion:completion];
}

#pragma mark - Action
- (void)segItemClick:(UIButton *)button
{
    if (button.tag == _seletedIndex) {
        return;
    }
    NSInteger fromIndex = _seletedIndex;
    _seletedIndex = button.tag;
    [self canCelAllSeletedState];
    [button setSelected:YES];
    [self moveSeleteButtonToWithAnimation:YES Completion:^(BOOL finished) {
        if([_delegate respondsToSelector:@selector(tripSegmentController:selectedIndex:fromIndex:)]){
            [_delegate tripSegmentController:self selectedIndex:_seletedIndex fromIndex:fromIndex];
        }
        else if([_delegate respondsToSelector:@selector(tripSegmentController:selectedIndex:)]){
            [_delegate tripSegmentController:self selectedIndex:_seletedIndex];
        }
    }];
}

#pragma mark - Public
- (void)setSeletedIndex:(NSInteger)index
{
    if (_seletedIndex == index) {
        return;
    }
    if (index < 0 || (index >= self.titleUIArray.count)) {
        return;
    }
    _seletedIndex = index;
    UIButton * button = [[self titleUIArray] objectAtIndex:_seletedIndex];
    [self canCelAllSeletedState];
    [button setSelected:YES];
    [self moveSeleteButtonToWithAnimation:NO Completion:NULL];
}

- (void)setContentOffset:(CGFloat)contentOffset
{
    self.scrollView.contentOffset = CGPointMake(contentOffset, 0);
}

- (void)showHotRed:(BOOL)isShow AtIndex:(NSInteger)index
{
    if (index < 0 || (index >= self.titleUIArray.count)) {
        return;
    }
    HotRedButton * button = [[self titleUIArray] objectAtIndex:_seletedIndex];
    [button.hotRed setHidden:!isShow];
   
}

@end
