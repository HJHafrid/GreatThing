//
//  HavingThingViewController.m
//  01啪啪
//
//  Created by mac57 on 16/9/12.
//  Copyright © 2016年 黄家辉. All rights reserved.
//

#import "HavingThingViewController.h"
#import "CollectionViewCell.h"
#import "CollectionView.h"

@interface HavingThingViewController (){

}

@end

@implementation HavingThingViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationController.navigationBarHidden = YES;
    
    CollectionView *collectionView = [[CollectionView alloc] initWithFrame:CGRectMake(0, 20, kWidth, kHeight - 49) collectionViewLayout:[[UICollectionViewLayout alloc] init]];
    
    
    [self.view addSubview:collectionView];
    
//    NSDictionary *dic = @{@"key" : nil};
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    
}



@end
