//
//  ASInputConnectPasswordView.h
//  ASLY
//
//  Created by 张志超 on 2020/11/4.
//  Copyright © 2020 AS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWTFCodeBView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ASInputConnectPasswordView : UIView


@property(nonatomic, strong) HWTFCodeBView   * inputView ;


-(void)show ;

-(void)hidden ;

@end

NS_ASSUME_NONNULL_END
