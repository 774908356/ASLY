//
//  ASDeviceTableViewCell.h
//  ASLY
//
//  Created by 张志超 on 2020/11/8.
//  Copyright © 2020 AS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^IconIVTappedBlock)(void);

@interface ASDeviceTableViewCell : UITableViewCell

@property(nonatomic, strong) UILabel   * titleLbl ;

@property(nonatomic, strong) UILabel   * connecStatusLbl ;

@property(nonatomic, strong) UIButton   * iconIV  ;

@property(nonatomic,copy) IconIVTappedBlock tappedBlock;


@property(nonatomic,assign) BOOL isHiddenRightView ;


@end

NS_ASSUME_NONNULL_END
