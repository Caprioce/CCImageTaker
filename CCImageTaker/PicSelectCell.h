//
//  PicSelectCell.h
//  CCImageTaker
//
//  Created by Smart Events on 16/12/26.
//  Copyright © 2016年 Smart Events. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickSelectedBtnBlock)(NSInteger btnTag);
typedef void(^clickNormalBtnBlock)(NSInteger btnTag);

@interface PicSelectCell : UICollectionViewCell

//照片
@property (nonatomic ,strong)UIImageView * iconView;

//选择
@property (nonatomic ,strong)UIButton * selectBtn;

@property (nonatomic ,assign)NSInteger btntag;

@property (nonatomic , copy)clickSelectedBtnBlock selectedBtnBlock;

@property (nonatomic , copy)clickNormalBtnBlock normalBtnBlock;
@end
