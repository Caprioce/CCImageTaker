//
//  PicSelectViewController.m
//  CCImageTaker
//
//  Created by Smart Events on 16/12/26.
//  Copyright © 2016年 Smart Events. All rights reserved.
//

#import "PicSelectViewController.h"
#import "PicSelectCell.h"
#import <Photos/Photos.h>

#define itemWidth (SCREEN_WIDTH -50)/4
@interface PicSelectViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    UICollectionView * MycollectionView;
    NSMutableArray * assetArray;
    CGSize photoSize;
}

@property (nonatomic ,strong )NSMutableArray * selectArray;
@end

@implementation PicSelectViewController

-(NSMutableArray *)selectArray
{
    if (!_selectArray) {
        _selectArray =[NSMutableArray new];
        for (int i =0; i<assetArray.count; i++) {
            [_selectArray addObject:@"0"];
        }
    }
    return _selectArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    assetArray =[NSMutableArray new];
    photoSize =CGSizeMake(itemWidth, itemWidth);
    
    UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc]init];
    //设置cell的最小间距(默认貌似为10).
    flowLayout.minimumInteritemSpacing =0;
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    MycollectionView =[[UICollectionView alloc]initWithFrame:CGRectMake( 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:flowLayout];
    [MycollectionView registerClass:[PicSelectCell class] forCellWithReuseIdentifier:@"shiping"];
    MycollectionView.delegate =self;
    MycollectionView.dataSource =self;
    MycollectionView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:MycollectionView];
    
    [self getData];
}

-(void)getData
{
    // 获取所有资源的集合，并按资源的创建时间排序
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    // 这时 assetsFetchResults 中包含的，应该就是各个资源（PHAsset）
    for (NSInteger i = 0; i < assetsFetchResults.count; i++) {
        // 获取一个资源（PHAsset）
        PHAsset *asset = assetsFetchResults[i];
        PHImageManager * manager =[PHImageManager defaultManager];
        [manager requestImageForAsset:asset targetSize:photoSize contentMode:PHImageContentModeDefault options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            [assetArray addObject:result];
            dispatch_async(dispatch_get_main_queue(), ^{
                [MycollectionView reloadData];
            });
        }];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return assetArray.count;
}

//设置每个item上的控件
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier =[NSString stringWithFormat:@"shiping"];
    PicSelectCell *cell = (PicSelectCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.iconView.image =[assetArray objectAtIndex:indexPath.item];
    cell.btntag =indexPath.row+100;
    cell.selectedBtnBlock =^(NSInteger btnTag){
        NSLog(@"%ld",(long)btnTag);
    };
    cell.normalBtnBlock =^(NSInteger btnTag){
        NSLog(@"%ld",(long)btnTag);
    };
    
    cell.backgroundColor =[UIColor orangeColor];
    return cell;
}

//设置每个item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(itemWidth,itemWidth);
}

//设置每行的位置
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    // x =离顶部距离, y =离左侧距离  ,  m =？  , n =理由测距离
    return UIEdgeInsetsMake(10, 10, 10, 10);//分别为上、左、下、右
}

//设置每行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

//点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
