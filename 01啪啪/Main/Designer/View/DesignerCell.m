//
//  DesignerCell.m
//  01啪啪
//
//  Created by mac57 on 16/9/12.
//  Copyright © 2016年 黄家辉. All rights reserved.
//

#import "DesignerCell.h"

@interface DesignerCell(){
    
    __weak IBOutlet UIButton *attentionButton;
    __weak IBOutlet UIView *backgroundView;
}
@property (weak, nonatomic) IBOutlet UILabel *introduceLable;
@property (weak, nonatomic) IBOutlet UILabel *founderLable;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UIImageView *midView;
@property (weak, nonatomic) IBOutlet UIImageView *downView;
@property (weak, nonatomic) IBOutlet UIImageView *upView;
@end

@implementation DesignerCell


- (void)awakeFromNib {
    [super awakeFromNib];
}
-(void)setModel:(DesignerModel *)model
{
    _model = model;
    [_upView sd_setImageWithURL:[NSURL URLWithString:_model.upImage]];
    [_midView sd_setImageWithURL:[NSURL URLWithString:_model.midImage]];
    _midView.layer.masksToBounds = YES;
    _midView.layer.cornerRadius = 50;
    _nameLable.text = _model.nameLable;
    _founderLable.text = _model.founderLable;
    _introduceLable.text = _model.introduceLable;
    _nameLable.textColor = [UIColor whiteColor];
    _nameLable.font = [UIFont fontWithName:@"Arial" size:20];
    _founderLable.textColor = [UIColor whiteColor];
    _introduceLable.textColor = [UIColor grayColor];
    

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
