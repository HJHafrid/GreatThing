//
//  BaseTableView.h
//  01啪啪
//
//  Created by mac53 on 16/9/18.
//  Copyright © 2016年 黄家辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetaiModel.h"

@interface BaseTableView : UITableView<UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray *muArray;
}

@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, copy) NSString *string;

@end
