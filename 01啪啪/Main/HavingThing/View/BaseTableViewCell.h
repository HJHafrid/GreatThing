//
//  BaseTableViewCell.h
//  01啪啪
//
//  Created by mac53 on 16/9/18.
//  Copyright © 2016年 黄家辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetaiModel.h"

@interface BaseTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *listImageView;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *imageName;
@property (weak, nonatomic) IBOutlet UIImageView *unlikeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *likeImageView;

@property (nonatomic, copy) NSString *indexID;
@property (nonatomic, strong) DetaiModel *model;

@end
