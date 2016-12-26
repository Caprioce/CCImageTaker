//
//  PicSelectCell.m
//  CCImageTaker
//
//  Created by Smart Events on 16/12/26.
//  Copyright © 2016年 Smart Events. All rights reserved.
//

#import "PicSelectCell.h"

@implementation PicSelectCell

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.iconView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH -50)/4, (SCREEN_WIDTH -50)/4)];
        [self.contentView addSubview:self.iconView];
        
        self.selectBtn =[[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH -50)/4-30, 0, 30, 30)];
        [self.selectBtn addTarget:self action:@selector(clickSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.selectBtn setBackgroundImage:[UIImage imageNamed:@"zc.jpg"] forState:UIControlStateNormal];
        self.selectBtn.selected=NO;
        [self.contentView addSubview:self.selectBtn];
    }
    return self;
}

- (void) clickSelectBtn:(UIButton *)sender
{
    sender.selected =!sender.selected;
    //选中
    if (self.selected) {
        [self.selectBtn setBackgroundImage:nil forState:UIControlStateNormal];
        self.selectedBtnBlock(sender.tag - 100);
    }else{
        [self.selectBtn setBackgroundImage:[UIImage imageNamed:@"zc.jpg"] forState:UIControlStateNormal];
        self.normalBtnBlock(sender.tag - 100);
    }
}

-(void)setBtntag:(NSInteger)btntag
{
    _btntag = btntag;
    self.selectBtn.tag = btntag;
}

@end
