//
//  BaseTableView.m
//  01啪啪
//
//  Created by mac53 on 16/9/18.
//  Copyright © 2016年 黄家辉. All rights reserved.
//

#import "BaseTableView.h"
#import "DetaiModel.h"
#import "BaseTableViewCell.h"
#import "AFHTTPRequestOperationManager.h"
#import "BottomViewController.h"
#import "DetailViewController.h"
#import "DesignerModel.h"

@implementation BaseTableView

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.delegate = self;
        self.dataSource = self;
        
        [self registerNib:[UINib nibWithNibName:@"BaseTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BaseTableViewCell"];
        
    }
    return self;
}



- (void)setString:(NSString *)string{
    
//    NSLog(@"%@", string);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:string parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *mdata = result[@"data"];
        NSArray *array = mdata[@"products"];
        NSMutableArray *mArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in array) {
            NSDictionary *deepDic = dic[@"designer"];
            DetaiModel *model = [[DetaiModel alloc] init];
            model.name = deepDic[@"name"];
            model.avatar_url = deepDic[@"avatar_url"];
            model.label = deepDic[@"label"];
            model.avatarID = deepDic[@"id"];
            NSArray *array = dic[@"cover_images"];
            model.cover_images = array.firstObject;
            model.imageName = dic[@"name"];
            model.indexID = dic[@"id"];
            model.like_user_num = [dic[@"like_user_num"] integerValue];
            model.unlike_user_num = [dic[@"unlike_user_num"] integerValue];
            
            
//            NSLog(@"%@", model.indexID);
            [mArray addObject:model];
            
        }
        muArray = [mArray mutableCopy];
        [self reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return muArray.count;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BaseTableViewCell" forIndexPath:indexPath];
//    cell.nameLabel.text = self.array[indexPath.row];
    cell.model = muArray[indexPath.row];
//    NSLog(@"muArray = %li", muArray.count);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *viewCtrl = [self traverseResponderChainForUIViewController];
    
    BottomViewController *vc = [[BottomViewController alloc] init];
    DesignerModel *model = muArray[indexPath.row];
//    NSLog(@"%@", model.indexID);
    vc.indexID = model.indexID;

    [viewCtrl.navigationController pushViewController:vc animated:YES];
}



//通过响应者链获取当前的viewcontroller
- (UIViewController *) traverseResponderChainForUIViewController {

    UIResponder *nextResponder = self.nextResponder;
    while (1) {
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        } else {
            nextResponder = nextResponder.nextResponder;
            
        }
    }
    
}


@end
