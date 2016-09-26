//
//  SetViewController.m
//  01啪啪
//
//  Created by mac57 on 16/9/13.
//  Copyright © 2016年 黄家辉. All rights reserved.
//

#import "SetViewController.h"

@interface SetViewController ()

@end

@implementation SetViewController

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.navigationController.navigationBarHidden = NO;
//    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
//    
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self readCacheSize];
    
}
- (NSUInteger )getCacheData
{
    NSUInteger size = [[SDImageCache sharedImageCache] getSize];
    
    
    return size;
}
- (void)readCacheSize
{
    NSUInteger size = [self getCacheData];
    
    double mbSize = size / 1024.0 / 1024.0;
    _sizeLable.text = [NSString stringWithFormat:@"%.2fM", mbSize];
    _sizeLable.textColor = [UIColor redColor];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        [self clearCache];
        [self readCacheSize];
    }
}
- (void)clearCache
{
    [[SDImageCache sharedImageCache] clearDisk];
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
