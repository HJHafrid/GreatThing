//
//  CollectionViewController.m
//  HJCarouselDemo
//
//  Created by haijiao on 15/8/20.
//  Copyright (c) 2015年 olinone. All rights reserved.
//

#import "CollectionViewController.h"
#import "CycleCollectionViewCell.h"
#import "HJCarouselViewLayout.h"
#import "AFNetworking.h"
#import "PushViewController.h"
@interface CollectionViewController ()
{
    NSArray *daArray;
    NSArray *GLBarray;
}

@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    [self.collectionView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    self.collectionView.backgroundColor = [UIColor blackColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CycleCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
}
- (void)loadData {
    GLBarray = [[NSArray alloc] init];
    NSString *urlStr = @"http://design.zuimeia.com/api/v1/articles/daily/simple/?app_version=2.2.4&device_id=d41d8cd98f00b204e9800998ecf8427e0b49ab36&device_name=iPhone&package_name=com.zuimeia.ZUIRanking&page=1&page_size=20&platform=iphone&resolution=%7B640%2C%201136%7D&system_version=9.3.5&token=4fb-7f019b0f2857247b5198&user_id=54224";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *muDic2 = responseObject[@"data"];
        NSArray *array = muDic2[@"articles"];
        NSMutableArray *dataArray = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dic in array) {
            CycleModel *model = [[CycleModel alloc] init];
            NSDictionary *dic2 = dic[@"author"];
            model.avatar_url = dic2[@"avatar_url"];
            model.username = dic2[@"username"];
            model.sign = dic2[@"sign"];
            model.title = dic[@"title"];
            model.image_url = dic[@"image_url"];
            model.sub_title = dic[@"sub_title"];
            model.idNunber = (NSString *)dic[@"id"];
            [dataArray addObject:model];
            GLBarray = [dataArray mutableCopy];
            [self.collectionView reloadData];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"fail");
    }];

}


- (NSIndexPath *)curIndexPath {
    NSArray *indexPaths = [self.collectionView indexPathsForVisibleItems];
    NSIndexPath *curIndexPath = nil;
    NSInteger curzIndex = 0;
    for (NSIndexPath *path in indexPaths.objectEnumerator) {
        UICollectionViewLayoutAttributes *attributes = [self.collectionView layoutAttributesForItemAtIndexPath:path];
        if (!curIndexPath) {
            curIndexPath = path;
            curzIndex = attributes.zIndex;
            continue;
        }
        if (attributes.zIndex > curzIndex) {
            curIndexPath = path;
            curzIndex = attributes.zIndex;
        }
    }
    return curIndexPath;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *curIndexPath = [self curIndexPath];
    if (indexPath.row == curIndexPath.row) {
        return YES;
    }
    
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
    return NO;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"click %ld", indexPath.row);
    PushViewController *pushVC = [[PushViewController alloc] init];
    if (GLBarray) {
        
        pushVC.model = GLBarray[indexPath.row];
    }
    
    [self.navigationController pushViewController:pushVC animated:YES];
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return GLBarray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CycleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.cycleModel = GLBarray[indexPath.row];
    

    return cell;
}


@end
