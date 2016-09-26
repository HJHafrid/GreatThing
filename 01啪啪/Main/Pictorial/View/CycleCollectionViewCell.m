//
//  CycleCollectionViewCell.m
//  01啪啪
//
//  Created by mac53 on 16/9/20.
//  Copyright © 2016年 黄家辉. All rights reserved.
//

#define ScrollITEM_WIDTH (IPHONE_6||IPHONE_6_PLUS) ? 274*kScreenHeightRatio-20 : 274*kScreenHeightRatio
#define ScrollITEM_HEIGHT 436*kScreenHeightRatio
#import "CycleCollectionViewCell.h"

@implementation CycleCollectionViewCell

#pragma mark -
#pragma mark lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        self.contentView.backgroundColor = [UIColor yellowColor];
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
    }
    return self;
}

- (void)setCycleModel:(CycleModel *)cycleModel{
    _cycleModel = cycleModel;
    
    _avatorImageView.layer.masksToBounds = YES;
    _avatorImageView.layer.cornerRadius = 20;
    [_avatorImageView sd_setImageWithURL:[NSURL URLWithString:_cycleModel.avatar_url]];
    [_coverImageView sd_setImageWithURL:[NSURL URLWithString:_cycleModel.image_url]];
    
    
    _detailLabel.text = _cycleModel.sign;
            NSLog(@"!!!!!%@", _detailLabel.text);
    _descriptionLabel.text = _cycleModel.title;
    _listLabel.text = _cycleModel.sub_title;
    
    
    
}


-(void)layoutSubviews{
    
}
@end
