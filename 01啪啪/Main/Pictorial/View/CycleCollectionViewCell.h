//
//  CycleCollectionViewCell.h
//  01啪啪
//
//  Created by mac53 on 16/9/20.
//  Copyright © 2016年 黄家辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CycleModel.h"

typedef void(^CycleCollectionViewCellBlock)(void);

@interface CycleCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *lockBtn;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *subTitleLab;
@property (nonatomic, strong) UILabel *detLab;
@property (nonatomic, strong) UIButton *listBtnOne;
@property (nonatomic, strong) UIButton *listBtnTwo;
@property (nonatomic, strong) UIButton *listBtnThree;
@property (nonatomic, strong) UIButton *listBtnFour;

@property (weak, nonatomic) IBOutlet UIImageView *avatorImageView;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *listLabel;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;



@property (nonatomic, strong) CycleModel *cycleModel;

@property (nonatomic, copy) CycleCollectionViewCellBlock lockBlock;

@end
