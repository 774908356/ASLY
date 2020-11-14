//
//  ASDeviceModel.h
//  ASLY
//
//  Created by 张志超 on 2020/11/8.
//  Copyright © 2020 AS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ASDeviceModel : NSObject

/** 名称 */
@property(nonatomic,copy) NSString * deviceName ;

/** 设备唯一标示 */
@property(nonatomic,copy) NSString *deviceId;


@property(nonatomic,assign) BOOL connectionSuccess;

@property(nonatomic,assign) BOOL isMyDevice;


/** 密码 */
@property(nonatomic,copy) NSString *devicePassword;


/// 感应距离
@property(nonatomic,assign) NSInteger sensingDistance;

/** mac地址 */
@property(nonatomic,copy) NSString *macAddress;


/// 我的页面已选择
@property(nonatomic,assign) BOOL isMinePageSelected;


@end

NS_ASSUME_NONNULL_END
