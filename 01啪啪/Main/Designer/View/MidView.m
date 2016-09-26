//
//  MidView.m
//  01啪啪
//
//  Created by mac57 on 16/9/22.
//  Copyright © 2016年 黄家辉. All rights reserved.
//

#import "MidView.h"
@interface MidView ()
@end
@implementation MidView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    [self createUI];
}
- (void)createUI
{
    //人物头像介绍
    self.faceView = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth / 2 - 37.5, 100 - 37.5, 75, 75)];
    self.faceView.layer.masksToBounds = YES;
    self.faceView.layer.cornerRadius = 37.5;
//    [faceView sd_setImageWithURL:[NSURL URLWithString:dic[@"avatar_url"]]];
    [self addSubview:self.faceView];
    
    self.nameLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 100 + 37.5 + 15, kWidth, 20)];
//    nameLable.text = dic[@"name"];
    self.nameLable.textAlignment = NSTextAlignmentCenter;
//    self.nameLable.textColor = [UIColor whiteColor];
    [self addSubview:self.nameLable];
    
    self.nameDetailLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 100 + 37.5 + 15 + 25, kWidth, 20)];
    _nameDetailLable.text = @"label";
    self.nameDetailLable.textAlignment = NSTextAlignmentCenter;
//    self.nameDetailLable.textColor = [UIColor whiteColor];
    [self addSubview:self.nameDetailLable];
    
    self.introuduceLable = [[UILabel alloc] initWithFrame:CGRectMake(50, 100 + 37.5 + 15 + 25 + 20, kWidth - 100, 50)];
//    introuduceLable.text = dic[@"concept"];
    self.introuduceLable.textAlignment = NSTextAlignmentCenter;
    self.introuduceLable.numberOfLines = 2;
//    self.introuduceLable.textColor = [UIColor whiteColor];
    [self addSubview:self.introuduceLable];
    
    self.button = [[UIButton alloc] initWithFrame:CGRectMake(kWidth / 2 - 37.5, 100 + 37.5 + 15 + 25 + 25 + 45, 80, 20)];
    self.button.backgroundColor = [UIColor blackColor];
    [self.button setTitle:@"+关注" forState:UIControlStateNormal];
    [self addSubview:self.button];
    
    self.wordLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 100 + 37.5 + 15 + 25 + 25 + 50 + 40, kWidth, 30)];
    self.wordLable.font = [UIFont boldSystemFontOfSize:18.0f];
    self.words = [[NSString alloc] init];
    self.wordLable.text = self.words;
    self.wordLable.textAlignment = NSTextAlignmentLeft;
    self.wordLable.numberOfLines = 0;
    CGSize size = [self.words sizeWithFont:self.wordLable.font constrainedToSize:CGSizeMake(self.wordLable.frame.size.width, MAXFLOAT)];
    [self.wordLable setFrame:CGRectMake(10, 100 + 37.5 + 15 + 25 + 25 + 50 + 25, kWidth - 20, size.height)];
    [self addSubview:self.wordLable];
}

@end
