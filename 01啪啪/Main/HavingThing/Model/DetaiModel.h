//
//  DetaiModel.h
//  01啪啪
//
//  Created by mac53 on 16/9/18.
//  Copyright © 2016年 黄家辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetaiModel : NSObject

@property (nonatomic, copy) NSString *avatar_url;
@property (nonatomic, copy) NSString *cover_images;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *label;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *indexID;
@property (nonatomic, copy) NSString *avatarID;
@property (nonatomic, assign) NSInteger like_user_num;
@property (nonatomic, assign) NSInteger unlike_user_num;


@end
