//
//  CollectionView.m
//  01啪啪
//
//  Created by mac53 on 16/9/18.
//  Copyright © 2016年 黄家辉. All rights reserved.
//

#import "CollectionView.h"
#import "LargeCollectionView.h"
#import "SmallCollectionView.h"
#import "LargeLayout.h"
#import "SmallLayout.h"


@implementation CollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(nonnull UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self createUI];
}

- (void)createUI{
    
    _largeCollectionView = [[LargeCollectionView alloc] initWithFrame:CGRectMake(0, 40, kWidth, kHeight - 49 - 20) collectionViewLayout:[[LargeLayout alloc] init]];
    _largeCollectionView.backgroundColor = [UIColor blackColor];
    
    
    
    _smallCollectionView = [[SmallCollectionView alloc] initWithFrame:CGRectMake(57, 0, 300, 40) collectionViewLayout:[[SmallLayout alloc] init]];
    _smallCollectionView.backgroundColor = [UIColor blackColor];
    
    [self addSubview:_largeCollectionView];
    [self addSubview:_smallCollectionView];
    
    
    
    [_largeCollectionView addObserver:_smallCollectionView forKeyPath:kCurrentIndex options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    
    [_smallCollectionView addObserver:_largeCollectionView forKeyPath:kCurrentIndex options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    
    
    
    NSArray *dataArray = [[NSArray alloc] initWithObjects:@"喜欢的", @"Daily", @"首饰", @"包袋", @"鞋履", @"Men", @"配饰", @"其他", nil];
    [_smallCollectionView setArray:dataArray];
    [_largeCollectionView setArray:dataArray];
//    NSLog(@"%@", _smallCollectionView.array);
    
}




@end
