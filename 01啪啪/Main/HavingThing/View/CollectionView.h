//
//  CollectionView.h
//  01啪啪
//
//  Created by mac53 on 16/9/18.
//  Copyright © 2016年 黄家辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCollectionView.h"

@interface CollectionView : UICollectionView{
    BaseCollectionView *_largeCollectionView;
    BaseCollectionView *_smallCollectionView;
}

@property (nonatomic, strong) NSArray *dataArray;



@end
