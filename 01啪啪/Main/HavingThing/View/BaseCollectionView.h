//
//  BaseCollectionView.h
//  01啪啪
//
//  Created by mac53 on 16/9/18.
//  Copyright © 2016年 黄家辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCollectionView : UICollectionView<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>


@property (nonatomic, strong) NSArray *array;

@property (nonatomic, assign) CGFloat itemWidth;

//@property (nonatomic, strong)
@property (nonatomic, assign) NSInteger currentIndex;

@end
