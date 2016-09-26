//
//  IntroduceView.m
//  01啪啪
//
//  Created by mac53 on 16/9/21.
//  Copyright © 2016年 黄家辉. All rights reserved.
//

#import "IntroduceView.h"

@implementation IntroduceView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
//    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(20, 70, 374, 520)];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake( 10, 10, 354, 35)];
//    label.text = _model.title;
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont fontWithName:@"Arial" size:25];
    [self addSubview:_label];
    
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 354, 20)];
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    _contentLabel.font = [UIFont fontWithName:@"Arial" size:13];
    _contentLabel.alpha = 0.6;
    
//    detailLabel.text = _model.sub_title;
    [self addSubview:_contentLabel];
    
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 110, 334, 334)];
//    [imgView sd_setImageWithURL:[NSURL URLWithString:_imgString]];
    [self addSubview:_imgView];
    
    
}



@end
