//
//  ASDeviceDataManager.h
//  ASLY
//
//  Created by 张志超 on 2020/11/8.
//  Copyright © 2020 AS. All rights reserved.
//数据源管理类

#import <Foundation/Foundation.h>
#import "ASDeviceModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ASDeviceDataManager : NSObject

@property(nonatomic, strong) NSMutableArray<ASDeviceModel *>   * allDeviceMuArr ;


/// 初始化数据源，得到用户的所有设备列表
-(void)configDataScource;

+(instancetype)shareManager ;


-(NSArray<ASDeviceModel *> *)getMyDeviceArr ;

-(NSArray<ASDeviceModel *> *)getOtherDeviceArr ;



-(void)mineSelectedDevice:(ASDeviceModel *)model ;

-(NSString *)getSelectedDelviceName ;

@end

NS_ASSUME_NONNULL_END
