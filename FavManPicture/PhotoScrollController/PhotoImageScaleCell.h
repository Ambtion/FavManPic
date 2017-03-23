//
//  PhotoImageScaleCell.h
//  FavManPicture
//
//  Created by quke on 2017/3/23.
//  Copyright © 2017年 linjunhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMImageScaleView.h"

@class PhotoImageScaleCell;

@protocol PhotoImageScaleCellDelegate <NSObject>

- (void)photoImageScaleCellDidClick:(PhotoImageScaleCell *)cell;

@end

@interface PhotoImageScaleCell : UICollectionViewCell

@property(nonatomic,strong)BMImageScaleView * scaleImageView;

@property(nonatomic,weak)id<PhotoImageScaleCellDelegate> delegate;

@end
