//
//  ImageView_Scale.h
//  ScaleImageView
//
//  Created by baidu on 13-3-26.
//  Copyright (c) 2013年 Qu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMInfoImageView : UIImageView<UIWebViewDelegate>
{
    UIActivityIndicatorView * actV;
    UIImageView * logo;
}
- (void)startLoading;
- (void)stopLoading;
@end

@class BMImageScaleView;
@protocol ImageScaleViewDelegate <NSObject>
- (void)imageViewScale:(BMImageScaleView *)imageScale clickCurImage:(UIImageView *)imageview;
@end

@interface BMImageScaleView : UIScrollView<UIScrollViewDelegate,UIGestureRecognizerDelegate>

@property(nonatomic,weak)id<ImageScaleViewDelegate> Adelegate;
@property(nonatomic,strong)BMInfoImageView * imageView;
@property(nonatomic,strong)id asset;
@property(nonatomic,assign)BOOL tapEnabled;

@end
