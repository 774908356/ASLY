//
//  ASDeviceTableViewCell.m
//  ASLY
//
//  Created by 张志超 on 2020/11/8.
//  Copyright © 2020 AS. All rights reserved.
//

#import "ASDeviceTableViewCell.h"
#import "ASBaseCellView.h"

@implementation ASDeviceTableViewCell

-(UILabel *)titleLbl{
    if (!_titleLbl) {
        _titleLbl = [UILabel new] ;
        _titleLbl.textColor = kNormalTextColor ;
        
    }
    return _titleLbl;
}

-(UILabel *)connecStatusLbl{
    
    if (!_connecStatusLbl) {
        _connecStatusLbl = [UILabel new] ;
        _connecStatusLbl.hidden = YES ;
        _connecStatusLbl.textColor = [UIColor blackColor] ;
        
    }
    return _connecStatusLbl ;
}

-(UIButton *)iconIV{
    if (!_iconIV) {
        _iconIV = [UIButton buttonWithType:UIButtonTypeCustom] ;
        _iconIV.jk_touchAreaInsets = UIEdgeInsetsMake(10, 10, 10, 10) ;
        [_iconIV addTarget:self action:@selector(iconIVTapped) forControlEvents:UIControlEventTouchUpInside] ;
        [_iconIV setImage:[UIImageNamed(@"homepage_hint_iv") jk_imageScaledToSize:CGSizeMake(20, 20)] forState:UIControlStateNormal] ;
        _iconIV.hidden = YES ;
    }
    return _iconIV;
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier] ) {
        self.selectionStyle = UITableViewCellSelectionStyleNone ;
        [self configUI] ;
    }
    
    return self;
}

-(void)setIsHiddenRightView:(BOOL)isHiddenRightView{
    _isHiddenRightView = isHiddenRightView ;
    
    self.connecStatusLbl.hidden = _isHiddenRightView ;
    self.iconIV.hidden = _isHiddenRightView ;
}

-(void)configUI{
    ASBaseCellView * backView = [[ASBaseCellView alloc] initWithFrame:CGRectZero] ;
    [self.contentView addSubview:backView] ;
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.offset(-10) ;
        make.top.left.offset(10) ;
    }] ;
    
    [backView addSubview:self.titleLbl] ;
    [backView addSubview:self.connecStatusLbl] ;
    [backView addSubview:self.iconIV] ;
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15) ;
        make.centerY.equalTo(backView) ;
    }] ;
    
    [self.iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15) ;
        make.centerY.equalTo(backView) ;
        make.width.height.mas_equalTo(20) ;
    }] ;
    
    [self.connecStatusLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.iconIV.mas_left).offset(-20) ;
        make.centerY.equalTo(self.iconIV) ;
    }] ;
    
}

-(void)iconIVTapped{
    self.tappedBlock() ;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
