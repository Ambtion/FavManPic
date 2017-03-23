//
//  PhotoImageScaleCell.m
//  FavManPicture
//
//  Created by quke on 2017/3/23.
//  Copyright © 2017年 linjunhou. All rights reserved.
//

#import "PhotoImageScaleCell.h"

@interface PhotoImageScaleCell()<ImageScaleViewDelegate>

@end

@implementation PhotoImageScaleCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    self.scaleImageView = [[BMImageScaleView alloc] initWithFrame:self.bounds];
    self.scaleImageView.Adelegate = self;
    [self addSubview:self.scaleImageView];

}


#pragma mark - Action
- (void)imageViewScale:(BMImageScaleView *)imageScale clickCurImage:(UIImageView *)imageview
{
    if ([_delegate respondsToSelector:@selector(photoImageScaleCellDidClick:)]) {
        [_delegate photoImageScaleCellDidClick:self];
    }
}

@end
