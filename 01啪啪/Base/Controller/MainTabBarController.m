//
//  MainTabBarController.m
//  01啪啪
//
//  Created by 黄家辉 on 16/8/22.
//  Copyright © 2016年 黄家辉. All rights reserved.
//

#import "MainTabBarController.h"
@interface MainTabBarController ()
{
    NSArray *nameArray2;
    UIButton *BgButton;
}
@end

@implementation MainTabBarController
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createSubViewController];
        [self customTabBar];
    }
    return self;
}
- (void)createSubViewController
{
    NSArray *storyBoardName = @[@"Pictorial",
                                @"HavingThing",
                                @"Designer",
                                @"Me"];
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    for (NSString *sbName in storyBoardName) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:sbName bundle:[NSBundle mainBundle]];
        UINavigationController *navi = [storyBoard instantiateInitialViewController];
        [mArray addObject:navi];
    }
    self.viewControllers = [mArray copy];
    //    self.navigationController.navigationBar.translucent = YES;
    
}
- (void)customTabBar
{
    for (UIView *subView in self.tabBar.subviews) {
        //判断获取到的子视图，是否是标签栏上面的按钮
        //UITabBarButton
        //NSLog(@"%@", subView);
        Class buttonClass = NSClassFromString(@"UITabBarButton");
        if ([subView isKindOfClass:buttonClass]) {
            //视图是UITabBarButton
            [subView removeFromSuperview];
        }
    }
    CGFloat buttomWidth = kWidth / 4;
    
    NSString *s1 = @"bottombar_magazine_unselected@3x.png";
    NSString *s2 = @"bottombar_discover_unselected@3x.png";
    NSString *s3 = @"bottombar_designer_unselected@3x.png";
    NSString *s4 = @"bottombar_mine_unselected@3x.png";
    NSArray *nameArray1 = [NSArray arrayWithObjects:s1, s2, s3, s4, nil];
    
    NSString *c1 = @"bottombar_magazine_selected@3x.png";
    NSString *c2 = @"bottombar_discover_selected@3x.png";
    NSString *c3 = @"bottombar_designer_selected@3x.png";
    NSString *c4 = @"bottombar_mine_selected@3x.png";
    nameArray2 = [NSArray arrayWithObjects:c1, c2, c3, c4, nil];
    
    for (int i = 0; i < 4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(buttomWidth * i, 0, buttomWidth, 49);
        
        [button setImage:[UIImage imageNamed:nameArray1[i]] forState:UIControlStateNormal];
        
        [self.tabBar addSubview:button];
        
        button.tag = i;
        [button addTarget:self action:@selector(tabBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    BgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    BgButton.frame = CGRectMake(0, 0, buttomWidth, 49);
    [BgButton setImage:[UIImage imageNamed:nameArray2[0]] forState:UIControlStateNormal];
    [self.tabBar addSubview:BgButton];
}
- (void)tabBarButtonAction:(UIButton *)button{
    self.selectedIndex = button.tag;
    [BgButton setImage:[UIImage imageNamed:nameArray2[self.selectedIndex]] forState:UIControlStateNormal];
    BgButton.center = button.center;
}


@end
