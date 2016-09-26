//
//  LargeCollectionView.m
//  01啪啪
//
//  Created by mac53 on 16/9/18.
//  Copyright © 2016年 黄家辉. All rights reserved.
//

#import "LargeCollectionView.h"
#import "LargeCollectionViewCell.h"
#import "AFHTTPRequestOperationManager.h"

@implementation LargeCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(nonnull UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        
        self.itemWidth = kWidth;
        [self registerNib:[UINib nibWithNibName:@"LargeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"LargeCellID"];
        
        _dataArray = [[NSArray alloc] initWithObjects:@"daily", @"category/3", @"category/1", @"category/2", @"category/65", @"category/4", @"category/54", nil];
        
        
        
    }
    return self;
}
- (NSString *)stringAddString:(NSString *)str{
    
    NSString *string1 = [NSString stringWithFormat:@"http://design.zuimeia.com/api/v1/products/"];
    NSString *string2 = [NSString stringWithFormat:@"/?app_version=2.2.4&device_id=d41d8cd98f00b204e9800998ecf8427e0b49ab36&device_name=iPhone&package_name=com.zuimeia.ZUIRanking&platform=iphone&resolution=%%7B640%%2C%201136%7D&system_version=9.3.5&timestamp=1474128000000&token=4fb-7f019b0f2857247b5198&user_id=54224"];
    str = [string1 stringByAppendingString:str];
    str = [str stringByAppendingString:string2];
    
    return str;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return self.array.count;
    return self.array.count;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LargeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LargeCellID" forIndexPath:indexPath];

    cell.currentIndex = self.currentIndex;
//    NSLog(@"currentIndex = %li", self.currentIndex);
    [cell reloadData];
    
    if (cell.currentIndex > 0) {
        NSString *string = [self stringAddString:_dataArray[cell.currentIndex - 1]];
        cell.tbView.string = string;
    }
    
    
    
    return cell;
}




#pragma - mark flow Layout delegate


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.itemWidth, self.height);
}


/*
 http://design.zuimeia.com/api/v1/products/daily/?app_version=2.2.4&device_id=d41d8cd98f00b204e9800998ecf8427e0b49ab36&device_name=iPhone&package_name=com.zuimeia.ZUIRanking&platform=iphone&resolution=%7B640%2C%201136%7D&system_version=9.3.5&timestamp=1474128000000&token=4fb-7f019b0f2857247b5198&user_id=54224
 
 http://design.zuimeia.com/api/v1/products/category/3/?app_version=2.2.4&device_id=d41d8cd98f00b204e9800998ecf8427e0b49ab36&device_name=iPhone&package_name=com.zuimeia.ZUIRanking&page=1&page_size=20&platform=iphone&resolution=%7B640%2C%201136%7D&system_version=9.3.5&token=4fb-7f019b0f2857247b5198&user_id=54224
 
 3/1/2/65/54
 
 */




@end
