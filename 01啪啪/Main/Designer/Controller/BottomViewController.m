//
//  BottomViewController.m
//  01啪啪
//
//  Created by 黄家辉 on 16/9/21.
//  Copyright © 2016年 黄家辉. All rights reserved.
//

#import "BottomViewController.h"
#import "AFNetworking.h"
#import "DesignerModel.h"
#import "MidView.h"
@interface BottomViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    UIImageView *imageView;
    UIScrollView *scrView1;
    UIView *view1;
    UIScrollView *glbScr;
    NSDictionary *glbDic;
    NSString * words;
    MidView *midView;
    NSMutableArray *arr3;
    UICollectionView *collView;
    NSMutableArray *mutableArray;
    NSMutableArray *mutableArrayID;
}

@end

@implementation BottomViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self downLoadData];
    self.view.backgroundColor = [UIColor blueColor];
    [self createScrollerView];
    view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 400)];
    view1.backgroundColor = [UIColor blackColor];
    [glbScr addSubview:view1];
    [self createTwoButton];
    [self createBackButton];
}
- (void)createScrollerView
{
    glbScr = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    NSLog(@"123123:::%lu", (unsigned long)mutableArray.count);
    glbScr.contentSize = CGSizeMake(kWidth, kHeight * 5);
    glbScr.backgroundColor = [UIColor whiteColor];
    glbScr.pagingEnabled = NO;
    glbScr.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:glbScr];
}
- (void)createBackButton
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(20, 20, 50, 50);
    [backButton setImage:[UIImage imageNamed:@"titleicon_back_icon@2x.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:backButton atIndex:100];
}
- (void)creataScrView1
{
    scrView1 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 360)];
    scrView1.contentSize = CGSizeMake(kWidth * 5, 360);
    scrView1.backgroundColor = [UIColor blackColor];
    scrView1.pagingEnabled = YES;
    scrView1.contentMode = UIViewContentModeScaleAspectFill;
    [glbScr addSubview:scrView1];
}
- (void)createTwoButton
{
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(kWidth / 2 - 45, 360, 40, 40)];
    [button1 setImage:[UIImage imageNamed:@"button_dislike@3x.png"] forState:UIControlStateNormal];
    [view1 addSubview:button1];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(kWidth / 2 + 25, 360, 40, 40)];
    [button2 setImage:[UIImage imageNamed:@"button_like@3x.png"] forState:UIControlStateNormal];
    [view1 addSubview:button2];
}
- (void)createMidView
{
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{

        [NSThread sleepForTimeInterval:0.1f];
        NSArray *array1 = glbDic[@"cover_images"];
        NSArray *array2 = glbDic[@"images"];
        scrView1 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 360)];
        scrView1.contentSize = CGSizeMake(kWidth * array1.count, 360);
        scrView1.backgroundColor = [UIColor blackColor];
        scrView1.pagingEnabled = YES;
        scrView1.contentMode = UIViewContentModeScaleAspectFill;
        [glbScr addSubview:scrView1];
        for (int i = 0; i < array1.count; i++) {
            imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth * i, 0, kWidth, 360)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:array1[i]]];
            imageView.tag = i;
            imageView.userInteractionEnabled = YES;
            [scrView1 addSubview:imageView];
        }
        UILabel *wordLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 420, kWidth, 30)];
        wordLable.font = [UIFont boldSystemFontOfSize:18.0f];
        words = glbDic[@"digest"];
        wordLable.textAlignment = NSTextAlignmentLeft;
        wordLable.numberOfLines = 0;
        CGSize size = [words sizeWithFont:wordLable.font constrainedToSize:CGSizeMake(wordLable.frame.size.width, MAXFLOAT)];
        [wordLable setFrame:CGRectMake(10, 420, kWidth - 20, size.height)];
        wordLable.text = words;
        [glbScr addSubview:wordLable];
        //创建next
        UILabel *webLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 420 + size.height + 20, kWidth, 40)];
        webLable.font = [UIFont boldSystemFontOfSize:18.0f];
        NSString *webWords = glbDic[@"desc"];
        webLable.textAlignment = NSTextAlignmentLeft;
        webLable.numberOfLines = 0;
        CGSize webSize = [words sizeWithFont:wordLable.font constrainedToSize:CGSizeMake(wordLable.frame.size.width, MAXFLOAT)];
        [webLable setFrame:CGRectMake(10, 420 + size.height + 20, kWidth - 20, webSize.height)];
        webLable.text = webWords;
        [glbScr addSubview:webLable];
        //创建图片
        NSInteger nub = array2.count;
        for (int i = 0; i < array2.count; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 420 + size.height + 20 + webSize.height + kWidth * i, kWidth - 20, kWidth)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:array2[i]]];
            [glbScr addSubview:imageView];
        }
        //导入框架
        NSDictionary *dic1 = glbDic[@"designer"];

        NSArray *arr2 = glbDic[@"refer_products"];
//        NSLog(@"%@", glbDic[@"refer_products"]);

        midView = [[MidView alloc] initWithFrame:CGRectMake(0, 420 + size.height + 20 + webSize.height + kWidth * nub, kWidth, kHeight)];
        [midView.faceView sd_setImageWithURL:[NSURL URLWithString:dic1[@"avatar_url"]]];
        midView.nameLable.text = dic1[@"name"];
        midView.nameDetailLable.text = dic1[@"lable"];
        midView.introuduceLable.text = dic1[@"concept"];
        midView.words = dic1[@"description"];
        
        
        midView.wordLable.textAlignment = NSTextAlignmentLeft;
        midView.wordLable.numberOfLines = 0;
        CGSize size1 = [midView.words sizeWithFont:midView.wordLable.font constrainedToSize:CGSizeMake(midView.wordLable.frame.size.width, MAXFLOAT)];
        midView.wordLable.text = midView.words;
        midView.wordLable.frame = CGRectMake(10, midView.bounds.origin.y + 100 + 37.5 + 15 + 25 + 25 + 45 + 30, kWidth - 20, size1.height);
        [glbScr addSubview:midView];
        //解析图片
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        collView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 420 + size.height + 20 + webSize.height + kWidth * nub + 100 + 37.5 + 15 + 25 + 25 + 45 + 30 + 170, kWidth, kHeight + (kWidth-30)/4) collectionViewLayout:layout];
        collView.delegate = self;
        collView.dataSource = self;
        collView.backgroundColor = [UIColor blackColor];
        [glbScr addSubview:collView];
        collView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [collView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
        mutableArray = [[NSMutableArray alloc] init];
        mutableArrayID = [[NSMutableArray alloc] init];
        for (NSDictionary *dic3 in arr2) {
            NSArray *arr4 = [[NSArray alloc] init];
            [mutableArrayID addObject:dic3[@"id"]];
            arr4 = dic3[@"cover_images"];
//            NSLog(@"%@", arr4);
            [mutableArray addObject:arr4.firstObject];
        }
//        NSLog(@"%@", mutableArray);
    });
}
- (void)downLoadData
{
    NSString *string1 = @"http://design.zuimeia.com/api/v1/product/";
    NSString *string2 = @"/?app_version=2.2.6&device_id=d41d8cd98f00b204e9800998ecf8427e0b49ab36&device_name=iPhone&package_name=com.zuimeia.ZUIRanking&platform=iphone&resolution=%7B640%2C%201136%7D&system_version=9.3.5&token=4fb-7f019b0f2857247b5198&user_id=54224";
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@", string1,  self.indexID, string2];
//    NSLog(@"%@", self.indexID);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *mdata = responseObject[@"data"];
        [self showData:mdata];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"fail");
    }];
}

- (void)showData:(NSDictionary *)data {
    
    glbDic = [[NSDictionary alloc] init];
    glbDic = data;
    [self createMidView];
}


- (void)buttonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return mutableArray.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blackColor];
    UIImageView *imageView1 = [[UIImageView alloc] init];
    [imageView1 sd_setImageWithURL:[NSURL URLWithString:mutableArray[indexPath.row]]];
    cell.backgroundView = imageView1;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BottomViewController *vc = [[BottomViewController alloc] init];
    vc.indexID = mutableArrayID[indexPath.row];
    self.indexID = vc.indexID;
//    NSLog(@"%@", self.indexID);
    
//    vc.indexID = self.indexID;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
