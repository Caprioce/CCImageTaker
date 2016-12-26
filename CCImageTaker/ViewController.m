//
//  ViewController.m
//  CCImageTaker
//
//  Created by Smart Events on 16/12/23.
//  Copyright © 2016年 Smart Events. All rights reserved.
//

#import "ViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView * mytable;
    NSMutableArray * assetArray;
    NSMutableArray * nameArray;
    NSMutableArray * fsArray;
    UIImageView *imgView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    
    assetArray =[NSMutableArray new];
    nameArray =[NSMutableArray new];
    fsArray =[NSMutableArray new];
    [self makeUI];
    [self iOSAfter_iOS8];
}

- (void)makeUI
{
        mytable =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        mytable.backgroundColor =[UIColor whiteColor];
        mytable.delegate =self;
        mytable.dataSource =self;
        [self.view addSubview:mytable];
}

- (void) iOSAfter_iOS8 {
    //筛选规则
//    PHFetchOptions * option =[[PHFetchOptions alloc]init];
//    //排序方式
//    option.sortDescriptors =@[[NSSortDescriptor sortDescriptorWithKey:@"modificationDate" ascending:NO]];
//    //列出所有相册智能相册
//    PHFetchResult * smartAlbums =[PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
//    
//    for (int i=0; i<smartAlbums.count; i++) {
//        //获取一个相册
//        PHCollection * collection =smartAlbums[i];
//        if ([collection isKindOfClass:[PHAssetCollection class]]) {
//            //每一个相册（assetcollection）
//            PHAssetCollection * assetcollection =(PHAssetCollection *)collection;
//            //从每一个相册中获取到中真正的资源
//            //相册里多有资源（fetResult）
//            PHFetchResult * fetResult =[PHAsset fetchAssetsInAssetCollection:assetcollection options:nil];
//            
//            if (fetResult.count>0) {
//                [assetArray addObject:fetResult];
//                [nameArray addObject:assetcollection.localizedTitle];
//                //获取封面图片,就是第一张图片
//                PHAsset *asset = (PHAsset *)fetResult.firstObject;
//                PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
//                //默认的是异步加载,这里选择了同步 因为只获取一张照片，不会对界面产生很大的影响
//                options.synchronous = YES;
//                PHImageManager * manager =[PHImageManager defaultManager];
//                [manager requestImageForAsset:asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
//                    [fsArray addObject:result];
//                }];
//            }
//        }
//    }
//    [mytable reloadData];
    
    // 获取所有资源的集合，并按资源的创建时间排序
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    // 这时 assetsFetchResults 中包含的，应该就是各个资源（PHAsset）
    for (NSInteger i = 0; i < assetsFetchResults.count; i++) {
        // 获取一个资源（PHAsset）
        PHAsset *asset = assetsFetchResults[i];
        PHImageManager * manager =[PHImageManager defaultManager];
        [manager requestImageForAsset:asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeDefault options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            [assetArray addObject:result];
            dispatch_async(dispatch_get_main_queue(), ^{
                [mytable reloadData];
            });
            
        }];
    }
//    [mytable reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return assetArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID =@"penhuolong";
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        imgView =[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
        [cell addSubview:imgView];
    }
    imgView.image =[assetArray objectAtIndex:indexPath.row];
//    cell.imageView.image =[fsArray objectAtIndex:indexPath.row];
//    cell.textLabel.text =[nameArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
