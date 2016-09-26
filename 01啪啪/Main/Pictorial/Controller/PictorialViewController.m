//
//  PictorialViewController.m
//  01啪啪
//
//  Created by 黄家辉 on 16/9/23.
//  Copyright © 2016年 黄家辉. All rights reserved.
//

#import "PictorialViewController.h"
#import "CycleCollectionViewCell.h"
#import "HJCarouselViewLayout.h"
#import "AFNetworking.h"
#import "CollectionViewController.h"


@interface PictorialViewController ()
{
    CGSize itemSize;
}
@end

@implementation PictorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HJCarouselViewLayout *layout = [[HJCarouselViewLayout alloc] initWithAnim:HJCarouselAnimCarousel];
    layout.itemSize = CGSizeMake(360, 500);
    CollectionViewController *vc = [[CollectionViewController alloc] initWithCollectionViewLayout:layout];
    [self.navigationController pushViewController:vc animated:YES];
    
    self.navigationController.navigationBarHidden = YES;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
