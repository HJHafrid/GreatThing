//
//  LargeCollectionViewCell.m
//  01啪啪
//
//  Created by mac53 on 16/9/18.
//  Copyright © 2016年 黄家辉. All rights reserved.
//

#import "LargeCollectionViewCell.h"
//#import "FirstTableView.h"


@implementation LargeCollectionViewCell

- (void)awakeFromNib {
    self.backgroundColor = [UIColor blackColor];
//    if (pageNumber > 0) {
//        NSArray *dataArray = [[NSArray alloc] initWithObjects:@"喜欢的", @"Daily", @"首饰", @"包袋", @"鞋履", @"Men", @"配饰", @"其他", nil];
//        
//        _tbView = [[BaseTableView alloc] initWithFrame:self.bounds];
//        _tbView.array = dataArray;
//        
//        [self addSubview:_tbView];
//        _tbView.rowHeight = 480;
//        
//    }
//    NSArray *dataArray = [[NSArray alloc] initWithObjects:@"喜欢的", @"Daily", @"首饰", @"包袋", @"鞋履", @"Men", @"配饰", @"其他", nil];
//    
//    _tbView = [[BaseTableView alloc] initWithFrame:self.bounds];
//    _tbView.array = dataArray;
//    
//    [self addSubview:_tbView];
//    _tbView.rowHeight = 480;
//    
//    _tbView.currentIndex = pageNumber;
    
}


- (void)reloadData {
    if (self.currentIndex > 0) {
        
        
        NSArray *dataArray = [[NSArray alloc] initWithObjects:@"Daily", @"首饰", @"包袋", @"鞋履", @"Men", @"配饰", @"其他", nil];
        
        _tbView = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - 55)];
        _tbView.array = dataArray;
        
        [self addSubview:_tbView];
        _tbView.rowHeight = 480;
        
        
    } else if (self.currentIndex == 0) {
        UIView *view = [[UIView alloc] initWithFrame:self.bounds];
        view.backgroundColor = [UIColor blackColor];
        [self addSubview:view];
        
    }

    
    
}



@end
