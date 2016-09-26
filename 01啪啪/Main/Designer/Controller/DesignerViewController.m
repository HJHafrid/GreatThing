//
//  DesignerViewController.m
//  01啪啪
//
//  Created by mac57 on 16/9/12.
//  Copyright © 2016年 黄家辉. All rights reserved.
//

#import "DesignerViewController.h"
#import "DetailViewController.h"
#import "DesignerCell.h"
#import "AFNetworking.h"

@interface DesignerViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
{
    NSArray *GLBarray;
    UITableView *MyTabview;
}
@end

@implementation DesignerViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MyTabview reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationController.navigationBarHidden = YES;
    [self createTableView];
    [self downLoadData];
    
}
- (void)createTableView
{
    MyTabview = [[UITableView alloc] initWithFrame:self.view.bounds];
    MyTabview.dataSource = self;
    MyTabview.delegate = self;
    MyTabview.rowHeight = 580;
    [self.view addSubview:MyTabview];
    //注册
    UINib *nib = [UINib nibWithNibName:@"DesignerCell" bundle:[NSBundle mainBundle]];
    [MyTabview registerNib:nib forCellReuseIdentifier:@"DesignerCell"];
}
//加载数据
- (void)downLoadData
{
    GLBarray = [[NSArray alloc] init];
    NSString *urlStr = @"http://design.zuimeia.com/api/v1/designers/?app_version=2.2.4&device_id=d41d8cd98f00b204e9800998ecf8427e0b49ab36&device_name=iPhone&package_name=com.zuimeia.ZUIRanking&page=1&page_size=20&platform=iphone&resolution=%7B640%2C%201136%7D&system_version=9.3.5&token=4fb-7f019b0f2857247b5198&user_id=54224";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *mdata = responseObject[@"data"];
        NSArray *array = mdata[@"designers"];
        NSMutableArray *dataArray = [NSMutableArray array];
        for (NSDictionary *dataDic in array) {
            
            DesignerModel *model = [[DesignerModel alloc] init];
            model.midImage = dataDic[@"avatar_url"];
            
            NSArray *array = dataDic[@"recommend_images"];
            model.upImage = [array firstObject];
            //            NSLog(@"%@", dataDic[@"id"]);
            model.indexID = dataDic[@"id"];
            model.nameLable = dataDic[@"name"];
            model.founderLable = dataDic[@"label"];
            model.introduceLable = dataDic[@"concept"];
            [dataArray addObject:model];
            //            NSLog(@"%@", array);
        }
        GLBarray = [dataArray mutableCopy];
        [MyTabview reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"fail");
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return GLBarray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DesignerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DesignerCell"];
    cell.model = GLBarray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    DesignerModel *model = GLBarray[indexPath.row];
    vc.indexID = model.indexID;
    [self.navigationController pushViewController:vc animated:YES];
    
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
