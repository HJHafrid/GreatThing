//
//  BaseTableViewCell.m
//  01啪啪
//
//  Created by mac53 on 16/9/18.
//  Copyright © 2016年 黄家辉. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "AppDelegate.h"
#import "DetailViewController.h"

@implementation BaseTableViewCell




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setModel:(DetaiModel *)model{
    _model = model;
    
    [_listImageView sd_setImageWithURL:[NSURL URLWithString:model.cover_images]];
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar_url]];
    _headerImageView.layer.masksToBounds = YES;
    _headerImageView.layer.cornerRadius = 25;
    
    
    _nameLabel.text = model.name;
    _contentLabel.text = model.label;
    _imageName.text = model.imageName;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(next)];
    _headerImageView.userInteractionEnabled = YES;
    [_headerImageView addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectAction)];
    _likeImageView.userInteractionEnabled = YES;
    _unlikeImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectAction)];
    [_likeImageView addGestureRecognizer:tapGesture];
    [_unlikeImageView addGestureRecognizer:tapGesture2];
    
    
}
- (void)selectAction{
    NSLog(@"好的");
}


























- (void)next{
    NSLog(@"开始");
    UIViewController *viewCtrl = [self traverseResponderChainForUIViewController];
    
    DetailViewController *vc = [[DetailViewController alloc] init];
//    DesignerModel *model = muArray[indexPath.row];
    //    NSLog(@"%@", model.indexID);
    vc.indexID = _model.avatarID;
    
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
