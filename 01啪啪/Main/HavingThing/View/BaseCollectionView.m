//
//  BaseCollectionView.m
//  01啪啪
//
//  Created by mac53 on 16/9/18.
//  Copyright © 2016年 黄家辉. All rights reserved.
//

#import "BaseCollectionView.h"

@implementation BaseCollectionView

- (instancetype)init
{
    return [self initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(nonnull UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor clearColor];
        //        self.pagingEnabled = YES;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        
        
    }
    return self;
}




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.array.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

#pragma - mark flow Layout delegate
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, (self.bounds.size.width - self.itemWidth) / 2, 0, (self.bounds.size.width - self.itemWidth) / 2);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(_itemWidth, self.height);
    
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    CGFloat offsetX = targetContentOffset->x;
    //结构体指针访问成员变量用->
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    CGFloat space = layout.minimumLineSpacing;
    CGFloat pageWith = _itemWidth + space;
    NSInteger pageNum = (offsetX + pageWith / 2) / pageWith;
    
    pageNum = velocity.x == 0 ? pageNum : (velocity.x > 0 ? pageNum + 1 : pageNum - 1);
    pageNum = MIN(MAX(pageNum, 0), self.array.count - 1);
    
    
    targetContentOffset->x = pageWith * pageNum;
    
    self.currentIndex = pageNum;
    pageNumber = pageNum;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_currentIndex != indexPath.row) {
        [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        self.currentIndex = indexPath.row;
    }
}


#pragma mark - observe
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
//    NSLog(@"-----%@-----", self);
    
    NSInteger index = [change[@"new"] integerValue];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    if (self.currentIndex != index) {
        [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        self.currentIndex = index;
//        NSLog(@"dasfewf = %li", _currentIndex);
    }
}

@end
