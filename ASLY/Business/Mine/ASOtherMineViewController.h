//
//  ASOtherMineViewController.h
//  ASLY
//
//  Created by 张志超 on 2020/11/14.
//  Copyright © 2020 AS. All rights reserved.
//

#import "ASHasNavViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ASOtherMineEnum) {
    ///用户信息
    ASOtherMineEnum_Info = 101,
    ///开锁记录
    ASOtherMineEnum_OpenKey = 102,
    ///关于我们
    ASOtherMineEnum_AboutUs = 103,
};

@interface ASOtherMineViewController : ASHasNavViewController

@property(nonatomic,assign) ASOtherMineEnum type;



@end

NS_ASSUME_NONNULL_END
