//
//  DetailViewController.m
//  01啪啪
//
//  Created by mac57 on 16/9/14.
//  Copyright © 2016年 黄家辉. All rights reserved.
//

#import "DetailViewController.h"
#import "DesignerModel.h"
#import "AFNetworking.h"
#import "DetailTableViewCell.h"
#import "BottomViewController.h"
#import "AFHTTPRequestOperationManager.h"

@interface DetailViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    UIScrollView *scrView;
    UIScrollView *scrView1;
    UIButton *backButton;
    NSMutableArray *_dataArray;
    NSDictionary *_dic;
    UITableView *tableView1;
    UIImageView *imageView;
    UICollectionView *collView;
    NSMutableArray *mutableArray;
    NSMutableArray *mutableArrayID;
}
@end

@implementation DetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [tableView1 reloadData];
    [collView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    self.tabBarController.tabBar.hidden = YES;
    [self createScrollerView];
    [self createTableView];

    [self creataScrView1];
    [self createMidView];
    [self createBackButton];
    [self loadData];
    [self loadData2];
    [self createCollectionView];
}
- (void)createScrollerView
{
    scrView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    scrView.contentSize = CGSizeMake(kWidth, kHeight * 2);
    scrView.backgroundColor = [UIColor blackColor];
    scrView.pagingEnabled = YES;
    [self.view addSubview:scrView];
}
- (void)createTableView
{
    tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    tableView1.tag = 1;
    tableView1.delegate = self;
    tableView1.dataSource = self;
    tableView1.rowHeight = kHeight - 100;
    UINib *nib = [UINib nibWithNibName:@"DetailTableViewCell" bundle:[NSBundle mainBundle]];
    [tableView1 registerNib:nib forCellReuseIdentifier:@"DetailTableViewCell"];
    [scrView addSubview:tableView1];
}
- (void)creataScrView1
{
    scrView1 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 300)];
    scrView1.contentSize = CGSizeMake(kWidth * 5, 300);
    scrView1.backgroundColor = [UIColor blackColor];
    scrView1.pagingEnabled = YES;
    scrView1.contentMode = UIViewContentModeScaleAspectFill;
    [tableView1 addSubview:scrView1];
}
- (void)createBackButton
{
    backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(20, 15, 50, 50);
    [backButton setImage:[UIImage imageNamed:@"titleicon_back_icon@2x.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:backButton atIndex:100];
}
- (void)createMidView
{
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:0.5f];
        NSDictionary *dic = [_dataArray firstObject];

        NSArray *array = dic[@"introduce_images"];
        if (array.count) {
            for (int i = 0; i < array.count; i++) {
                imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth * i, 0, kWidth, 300)];
                [imageView sd_setImageWithURL:[NSURL URLWithString:array[i]]];
                imageView.tag = i;
                imageView.userInteractionEnabled = YES;
                [scrView1 addSubview:imageView];
            }
        }
        
        
        //人物头像介绍
        UIImageView *faceView = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth / 2 - 37.5, 300 - 37.5, 75, 75)];
        faceView.layer.masksToBounds = YES;
        faceView.layer.cornerRadius = 37.5;
        [faceView sd_setImageWithURL:[NSURL URLWithString:dic[@"avatar_url"]]];
        [tableView1 addSubview:faceView];
        
        UILabel *nameLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 300 + 37.5 + 15, kWidth, 20)];
        nameLable.text = dic[@"name"];
        nameLable.textAlignment = NSTextAlignmentCenter;
        [tableView1 addSubview:nameLable];
        
        UILabel *nameDetailLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 300 + 37.5 + 15 + 25, kWidth, 20)];
        nameDetailLable.text = dic[@"label"];
        nameDetailLable.textAlignment = NSTextAlignmentCenter;
        [tableView1 addSubview:nameDetailLable];
        
        UILabel *introuduceLable = [[UILabel alloc] initWithFrame:CGRectMake(50, 300 + 37.5 + 15 + 25 + 20, kWidth - 100, 50)];
        introuduceLable.text = dic[@"concept"];
        introuduceLable.textAlignment = NSTextAlignmentCenter;
        introuduceLable.numberOfLines = 2;
        [tableView1 addSubview:introuduceLable];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(kWidth / 2 - 37.5, 300 + 37.5 + 15 + 25 + 25 + 45, 80, 20)];
        button.backgroundColor = [UIColor blackColor];
        [button setTitle:@"+关注" forState:UIControlStateNormal];
        [tableView1 addSubview:button];
        
        UILabel *wordLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 300 + 37.5 + 15 + 25 + 25 + 50 + 40, kWidth, 30)];
        wordLable.font = [UIFont boldSystemFontOfSize:18.0f];
        NSString *words = dic[@"description"];
        wordLable.textAlignment = NSTextAlignmentLeft;
        wordLable.numberOfLines = 0;
        CGSize size = [words sizeWithFont:wordLable.font constrainedToSize:CGSizeMake(wordLable.frame.size.width, MAXFLOAT)];
        [wordLable setFrame:CGRectMake(10, 300 + 37.5 + 15 + 25 + 25 + 50 + 25, kWidth - 20, size.height)];
        wordLable.text = words;
        [tableView1 addSubview:wordLable];
    });
}

- (void)createCollectionView
{    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:0.2f];
        
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, kHeight, kWidth, 50)];
        lable.text = @"作品";
        lable.textColor = [UIColor whiteColor];
        lable.textAlignment = NSTextAlignmentCenter;
        [scrView addSubview:lable];
        
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    collView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kHeight + 50, kWidth, kHeight) collectionViewLayout:layout];
    collView.delegate = self;
    collView.dataSource = self;
    collView.backgroundColor = [UIColor blackColor];
    [scrView addSubview:collView];
    collView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [collView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    });
    
    
}
- (void)loadData
{
    _dataArray = [[NSMutableArray alloc] init];
    NSString *string1 = @"http://design.zuimeia.com/api/v1/designer/";
    NSString *string2 = @"/?app_version=2.2.4&device_id=d41d8cd98f00b204e9800998ecf8427e0b49ab36&device_name=iPhone&package_name=com.zuimeia.ZUIRanking&platform=iphone&resolution=%7B640%2C%201136%7D&system_version=9.3.5&token=4fb-7f019b0f2857247b5198&user_id=54224";
    NSString *allstr = [NSString stringWithFormat:@"%@%@%@", string1,  self.indexID, string2];
    
    

    NSURL *url = [NSURL URLWithString:allstr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *mdata = result[@"data"];
        NSArray *array = @[mdata];

        _dataArray = [array mutableCopy];
        _dic = mdata;
        
        [tableView1 reloadData];
    }];
    
    [task resume];

    
}
- (void)loadData2
{
    NSString *string1 = @"http://design.zuimeia.com/api/v1/products/designer/";
    NSString *string2 = @"/?app_version=2.2.6&device_id=d41d8cd98f00b204e9800998ecf8427e0b49ab36&device_name=iPhone&package_name=com.zuimeia.ZUIRanking&page=1&page_size=20&platform=iphone&resolution=%7B640%2C%201136%7D&system_version=9.3.5&token=4fb-7f019b0f2857247b5198&user_id=54224";
    NSString *allstr = [NSString stringWithFormat:@"%@%@%@", string1,  self.indexID, string2];

    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task2 = [session dataTaskWithURL:[NSURL URLWithString:allstr] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *mdata = result[@"data"];
        NSArray *array = mdata[@"products"];
        if([array count] == 0)
        {
            NSMutableArray *mArray = [[NSMutableArray alloc] init];
            NSArray *array = [NSArray arrayWithObjects:@"http://dstatic.zuimeia.com/common/image/2016/9/2/a14a2faf-4abc-435d-9633-1d308d2f2116_971x971.jpeg", @"http://dstatic.zuimeia.com/common/image/2016/9/2/a14a2faf-4abc-435d-9633-1d308d2f2116_971x971.jpeg", @"http://dstatic.zuimeia.com/common/image/2016/9/2/a14a2faf-4abc-435d-9633-1d308d2f2116_971x971.jpeg", nil];
            for (int i = 0; i < 3; i++) {
                [mArray addObject:array[i]];
            }
            mutableArray = [mArray mutableCopy];
            mutableArrayID = [mArray mutableCopy];
        }
        else if ([array count] != 0) {
            NSMutableArray *mArray = [[NSMutableArray alloc] init];
            NSMutableArray *mArrayID = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in array) {
                NSArray *array = dic[@"cover_images"];
                NSArray *arrayID = dic[@"id"];
                [mArray addObject:array.firstObject];
                [mArrayID addObject:arrayID];
            }
            mutableArray = [mArray mutableCopy];
            mutableArrayID = [mArrayID mutableCopy];
        }
        [collView reloadData];
    }];
    
    
    
    
    [task2 resume];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)buttonAction
{
    [self.navigationController popViewControllerAnimated:YES];
    self.tabBarController.tabBar.hidden = NO;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        BottomViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"BottomViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    NSLog(@"%li", mutableArray.count);
    return mutableArray.count;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blackColor];
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:mutableArray[indexPath.row]]];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundView = imageView;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"%@", mutableArrayID[indexPath.row]);
    BottomViewController *vc = [[BottomViewController alloc] init];

    vc.indexID = mutableArrayID[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size = CGSizeMake((kWidth-30)/2.0, (kWidth-30)/2.0);
    return size;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    UIEdgeInsets inset = UIEdgeInsetsMake(10, 10, 10, 10);
    return inset;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
//设置header高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size = CGSizeMake(0, 0);
    return size;
}

//设置footer高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    CGSize size = CGSizeMake(0, 30);
    return size;
}

@end
