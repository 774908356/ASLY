//
//  ASUserModel.h
//  ASLY
//
//  Created by 张志超 on 2020/11/14.
//  Copyright © 2020 AS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ASUserModel : NSObject

/** 用户ID */
@property(nonatomic,copy) NSString *userId;

/** 用户名 */
@property(nonatomic,copy) NSString *userName;

/** 解锁时间 */
@property(nonatomic,copy) NSString *unLockTime;






@end

NS_ASSUME_NONNULL_END
