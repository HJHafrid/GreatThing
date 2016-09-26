//
//  PushViewController.m
//  01啪啪
//
//  Created by mac53 on 16/9/20.
//  Copyright © 2016年 黄家辉. All rights reserved.
//

#import "PushViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "IntroduceView.h"
#import <WebKit/WebKit.h>
#import "DetailViewController.h"


@interface PushViewController ()<UIWebViewDelegate, UIScrollViewDelegate, UIGestureRecognizerDelegate>{
    UIScrollView *_scrollView;
    NSString *contentString;
    NSString *_str;
    NSString *_imgString;
    NSString *_avaString;
    NSString *_name;
    NSString *_city;
    NSString *_rightAvaString;
    NSString *_description;
    NSString *_createPeople;
    NSArray *_referArray;
    UIImageView *_imgView;
    NSString *_id;
    
    UIButton *button;
    UIWebView *_webView;
    UIView *_rightView;
}

@end

@implementation PushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadData];
    
    
    [self createTop:self.view.bounds.size.width];
    [self createWebView];
    

    
    
}
- (void)nextAction{
//    NSLog(@"开始");
    DetailViewController *detailViewCtrl = [[DetailViewController alloc] init];
    detailViewCtrl.indexID = _id;
    [self.navigationController pushViewController:detailViewCtrl animated:YES];
    
}
- (void)createTop:(float)width{
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, 35, 40, 40);
    [button setImage:[UIImage imageNamed:@"titleicon_back_icon@2x"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    _rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width - 70 - 40, 40)];
    _rightView.frame = CGRectMake(width - _rightView.frame.size.width - 20, 35, width - 110, 40);
    _rightView.backgroundColor = [UIColor blackColor];
    _rightView.layer.cornerRadius = 20;
    _rightView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nextAction)];
    [_rightView addGestureRecognizer:tap];

    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 3, _rightView.frame.size.width - 80, 20)];
    label.frame = CGRectMake(_rightView.frame.size.width - label.frame.size.width - 50, 3, label.frame.size.width, 20);
    label.text = _name;
    label.textAlignment = NSTextAlignmentRight;
    label.textColor = [UIColor whiteColor];
    [_rightView addSubview:label];
    
    UIImageView *cityImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_rightView.frame.size.width - 40, 0, 40, 40)];
//    [cityImageView sd_setImageWithURL:[NSURL URLWithString:_rightAvaString]];

    cityImageView.backgroundColor = [UIColor whiteColor];
    [cityImageView sd_setImageWithURL:[NSURL URLWithString:_rightAvaString]];
//    NSLog(@"%@", _rightAvaString);
    cityImageView.layer.masksToBounds = YES;
    cityImageView.layer.cornerRadius = 20;
    [_rightView addSubview:cityImageView];
    
    UILabel *cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 24, 100, 10)];
    cityLabel.frame =CGRectMake(_rightView.frame.size.width - 140, 24, 100, 10);
    cityLabel.text = _city;
    cityLabel.textColor = [UIColor whiteColor];
    cityLabel.textAlignment = NSTextAlignmentRight;
    cityLabel.font = [UIFont fontWithName:@"Arial" size:10];
    [_rightView addSubview:cityLabel];
    
    
    
}


- (void)createWebView{
    
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    _scrollView.contentSize = CGSizeMake(kWidth, kHeight * 2);
    _scrollView.contentInset = UIEdgeInsetsMake(0, 0, -49, 0);
    
    
    [self.view addSubview:_scrollView];
//    _webView.scrollView.backgroundColor = [UIColor colorWithRed:192 / 255.0 green:192 / 255.0 blue:192 / 255.0 alpha:0.5];
    
    
    for (int i = 0; i < 2; i++) {
        if (i == 0) {
            _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
            [_scrollView addSubview:_webView];
        } else {
            _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, kHeight, kWidth, kHeight)];
            _imgView.backgroundColor = [UIColor orangeColor];
            [_scrollView addSubview:_imgView];
        }
    }
    
    _imgView.backgroundColor = [UIColor purpleColor];
    _webView.scalesPageToFit = YES;
    [_webView loadHTMLString:_str baseURL:nil];
    
//    [self.view addSubview:_webView];
    [self.view addSubview:button];
    [self.view addSubview:_rightView];
    
    _webView.delegate = self;
    _webView.scrollView.delegate = self;
    NSLog(@"%f", _webView.scrollView.contentSize.height);
    
    
    _webView.userInteractionEnabled = YES;
    _webView.scrollView.showsVerticalScrollIndicator = YES;
    
    UIPanGestureRecognizer *apan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    apan.delegate = self;
    apan.maximumNumberOfTouches = 1;
    apan.minimumNumberOfTouches = 1;
    
    [_webView addGestureRecognizer:apan];
    for (UIView *scrollView in _webView.subviews) {
        scrollView.userInteractionEnabled = YES;
        [scrollView addGestureRecognizer:apan];
        for (UIView *browserView in scrollView.subviews) {
            browserView.userInteractionEnabled = YES;
            [browserView addGestureRecognizer:apan];
        }
    }
    
    _webView.scrollView.contentInset = UIEdgeInsetsMake(self.view.bounds.size.height + 20, 0, 0, 0);
    
    [self createWebViewHeaderView:self.view.bounds.size.width];
//    [self createWebViewBottomView];
    
    
    
    
    
}
- (void)createWebViewBottomView{

    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, _webView.scrollView.contentSize.height, _webView.scrollView.bounds.size.width, 600)];
    view.backgroundColor = [UIColor blackColor];
    [_webView.scrollView addSubview:view];
    _webView.scrollView.delegate = self;
    
    
}



- (void)createWebViewHeaderView:(float)width{
    float height = self.view.bounds.size.height;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, - height -20, width, height + 20)];
    view.backgroundColor = [UIColor whiteColor];
    
    
    UIPanGestureRecognizer *apan2 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    apan2.delegate = self;
    apan2.maximumNumberOfTouches = 1;
    apan2.minimumNumberOfTouches = 1;
    [view addGestureRecognizer:apan2];
    
//    float viewWidth = view.frame.size.width;
    CGFloat viewHeight = view.frame.size.height;
    IntroduceView *introduceView = [[IntroduceView alloc] initWithFrame:CGRectMake(20, 50, width - 40, (viewHeight - 90) * 6 / 10.0)];
    introduceView.label.text = _model.title;
    introduceView.contentLabel.text = _model.sub_title;
    [introduceView.imgView sd_setImageWithURL:[NSURL URLWithString:_imgString]];
    [view addSubview:introduceView];
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(30, 80 + introduceView.bounds.size.height + (viewHeight - 90) / 10.0, width - 60 , (viewHeight - 90) * 3 / 10.0)];
//    contentView.frame = CGRectMake(30, introduceView.size.height - 20, contentView.size.width, contentView.size.height);
//    NSLog(@"%f   %f    %f", introduceView.bounds.size.height, contentView.bounds.size.height, viewHeight);
    
    contentView.backgroundColor = [UIColor colorWithRed:192 / 255.0 green:192 / 255.0 blue:192 / 255.0 alpha:0.5];
    [view addSubview:contentView];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((contentView.bounds.size.width - 40) / 2.0, 30, 40, 40)];
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 20;
    [imageView sd_setImageWithURL:[NSURL URLWithString:_avaString]];
    [contentView addSubview:imageView];
    
    
    UILabel *contentAvaLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 70, contentView.bounds.size.width - 60, 30)];
    contentAvaLabel.text = _model.username;
    contentAvaLabel.textAlignment = NSTextAlignmentCenter;
    contentAvaLabel.font = [UIFont fontWithName:@"Arial" size:14];
    [contentView addSubview:contentAvaLabel];
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 100, contentView.bounds.size.width - 60, 20)];
    contentLabel.text = @"作者";
    contentLabel.textAlignment = NSTextAlignmentCenter;
    contentLabel.font = [UIFont fontWithName:@"Arial" size:12];
    contentLabel.alpha = 0.6;
    [contentView addSubview:contentLabel];
    
    UILabel *contentDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 120, contentView.bounds.size.width - 60, 25)];
    contentDetailLabel.text = _model.sign;
    contentDetailLabel.textAlignment = NSTextAlignmentCenter;
    contentDetailLabel.font = [UIFont fontWithName:@"Arial" size:13];
    contentDetailLabel.alpha = 0.8;
    [contentView addSubview:contentDetailLabel];
    
    
    [_webView.scrollView addSubview:view];
}


- (void)tapGesture:(UIPanGestureRecognizer *)sender{
    static CGPoint beginPoint;
    CGPoint endPoint;
    if (sender.state == UIGestureRecognizerStateBegan) {
        beginPoint = [sender translationInView:_webView];
    }
    if (sender.state == UIGestureRecognizerStateEnded) {
        endPoint = [sender translationInView:_webView];
        if (endPoint.y - beginPoint.y < 0) {
            [UIView animateWithDuration:0.25 animations:^{
                CGRect frame = _rightView.frame;
                button.frame = CGRectMake(20, -60, 40, 40);
                _rightView.frame = CGRectMake(self.view.frame.size.width - frame.size.width - 20, -60, frame.size.width, 40);
            }];
        } else if (endPoint.y - beginPoint.y > 0) {
            [UIView animateWithDuration:0.25 animations:^{
                CGRect frame = _rightView.frame;
                button.frame = CGRectMake(20, 35, 40, 40);
                _rightView.frame = CGRectMake(self.view.frame.size.width - frame.size.width - 20, 35, frame.size.width, 40);
            }];
        }
        
    }
    
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}


- (void)loadData{
    if (_model.idNunber) {
        NSString *stringNum = [NSString stringWithFormat:@"%@", _model.idNunber];
        contentString = [self stringWithString:stringNum];
        NSURL *url = [NSURL URLWithString:contentString];
        NSData *data = [NSData dataWithContentsOfURL:url];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

        NSDictionary *dic2 = dic[@"data"];
        
        _str = dic2[@"content"];
        _imgString = dic2[@"image_url"];
        
        NSArray *array = dic2[@"designers"];
//        NSLog(@"%@", array);
        NSDictionary *dic3 = [array firstObject];
        
//        refer_products
        
        _name = dic3[@"name"];
        _city = dic3[@"city"];
        _rightAvaString = dic3[@"avatar_url"];
        
        _description = dic3[@"description"];
        _createPeople = dic3[@"label"];
        _referArray = dic2[@"refer_products"];
        
        _id = dic3[@"id"];
        
        _avaString = _model.avatar_url;
        
        
    }
    
    
}

- (void)setModel:(CycleModel *)model {
    _model = model;
    
}


/*
 http://design.zuimeia.com/api/v1/article/75/?app_version=2.2.6&device_id=3116df9e288f0579862f72f71966f154c052aefd&device_name=iPhone&package_name=com.zuimeia.ZUIRanking&platform=iphone&resolution=%7B640%2C%201136%7D&system_version=10.0.1
 */
- (NSString *)stringWithString:(NSString *)string{
    NSString *string1 = @"http://design.zuimeia.com/api/v1/article/";
    NSString *string2 = @"/?app_version=2.2.6&device_id=3116df9e288f0579862f72f71966f154c052aefd&device_name=iPhone&package_name=com.zuimeia.ZUIRanking&platform=iphone&resolution=%7B640%2C%201136%7D&system_version=10.0.1";
    string = [string1 stringByAppendingString:string];
    string = [string stringByAppendingString:string2];
    
    return string;
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
    
    
}





- (void)popViewController{

    [self.navigationController popViewControllerAnimated:YES];
}



- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *str = @"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '300%'";
    [_webView stringByEvaluatingJavaScriptFromString:str];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"%f", scrollView.contentOffset.y);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
