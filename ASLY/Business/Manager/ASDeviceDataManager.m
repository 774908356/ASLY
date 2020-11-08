//
//  ASDeviceDataManager.m
//  ASLY
//
//  Created by 张志超 on 2020/11/8.
//  Copyright © 2020 AS. All rights reserved.
//

#import "ASDeviceDataManager.h"

@implementation ASDeviceDataManager

+(instancetype)shareManager{
    
    static ASDeviceDataManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ASDeviceDataManager alloc] init];
        manager.allDeviceMuArr = [NSMutableArray array] ;
        [manager configDataScource] ;
    });
    return manager;
}

-(void)configDataScource{
    NSArray * deviceNameArr = @[@"Shirley's Phone",@"Lin's iPhone11",@"DESKTOP-J3PDMS",@"Jessie",@"Marco12",@"Wuzexi"] ;
    
    for (int i = 0; i < deviceNameArr.count; i++) {
        ASDeviceModel * model = [ASDeviceModel new] ;
        model.deviceName = deviceNameArr[i] ;
        if (i <= 1) {
            model.isMyDevice = YES ;
            if (i == 0) {
                model.connectionSuccess = YES ;
            }
        }
        model.devicePassword = @"123456" ;
        model.sensingDistance = arc4random() % 5 + 1 ;
        model.macAddress = @"ab:bc:64:d1:cc:c1" ;
        model.deviceId = [NSString stringWithFormat:@"%d",i] ;
        [self.allDeviceMuArr addObject:model] ;
    }
    
}

-(NSArray<ASDeviceModel *> *)getMyDeviceArr{
    NSMutableArray * muArr = [NSMutableArray array] ;
    for (ASDeviceModel * model in self.allDeviceMuArr) {
        if (model.isMyDevice) {
            [muArr addObject:model] ;
        }
    }
    
    
    
    return  muArr ;
    
}

-(NSArray<ASDeviceModel *> *)getOtherDeviceArr{
    NSMutableArray * muArr = [NSMutableArray array] ;
    for (ASDeviceModel * model in self.allDeviceMuArr) {
        if (!model.isMyDevice) {
            [muArr addObject:model] ;
        }
    }
    
    return  muArr ;
}






@end
