//
//  LargeCollectionViewCell.h
//  01啪啪
//
//  Created by mac53 on 16/9/18.
//  Copyright © 2016年 黄家辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableView.h"

@interface LargeCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) BaseTableView *tbView;

@property (nonatomic, assign) NSInteger currentIndex;

- (void)reloadData;

@end
