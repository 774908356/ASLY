//
//  ASInputConnectPasswordView.m
//  ASLY
//
//  Created by 张志超 on 2020/11/4.
//  Copyright © 2020 AS. All rights reserved.
//

#import "ASInputConnectPasswordView.h"

@interface ASInputConnectPasswordView()

@property(nonatomic, strong) UIView   * backView ;

@property(nonatomic, strong) UILabel   * hintLbl  ;


@end


@implementation ASInputConnectPasswordView

-(UILabel *)hintLbl{
    if (!_hintLbl) {
        _hintLbl = [UILabel new] ;
        _hintLbl.font= kTEXT_FONT_(12) ;
        _hintLbl.textColor = [UIColor redColor] ;
    }
    return _hintLbl;
}

-(HWTFCodeBView *)inputView{
    if (!_inputView) {
        WEAKSELF
        _inputView = [[HWTFCodeBView alloc] initWithCount:6 margin:10] ;
        _inputView.textChanged = ^(NSString * _Nonnull inputText) {
            if (!inputText || !inputText.length) {
                weakSelf.hintLbl.text = @"" ;
            }else if (![weakSelf isNumText:inputText]){
                weakSelf.hintLbl.text = @"请输入数字" ;
            }else{
                weakSelf.hintLbl.text = @"" ;
            }
        } ;
    }
    return _inputView;
}

-(UIView *)backView{
    if (!_backView) {
        _backView = [UIView new] ;
        _backView.backgroundColor = [UIColor whiteColor] ;
        _backView.layer.masksToBounds = YES ;
        _backView.layer.cornerRadius = 10;
        
        UIButton * closeBtn = [UIButton buttonWithType:UIButtonTypeCustom] ;
        closeBtn.jk_touchAreaInsets = UIEdgeInsetsMake(10, 10, 10, 10) ;
        [closeBtn addTarget:self action:@selector(closeBtnTapped) forControlEvents:UIControlEventTouchUpInside] ;
        [closeBtn setImage:[[UIImage imageNamed:@"inputPassword_close_btn"] jk_imageScaledToSize:CGSizeMake(20, 20)] forState:UIControlStateNormal] ;
        [_backView addSubview:closeBtn] ;
        [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(20) ;
            make.top.offset(20) ;
            make.right.offset(-20) ;
        }] ;
        
        UILabel * titleLbl = [[UILabel alloc] initWithFrame:CGRectZero] ;
        titleLbl.text = @"请输入连接密码" ;
        titleLbl.textColor = [UIColor blackColor] ;
        titleLbl.font = kTEXT_FONT_(15) ;
        [_backView addSubview:titleLbl] ;
        [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_backView) ;
            make.top.offset(40) ;
        }] ;
        
        [self layoutIfNeeded] ;
        [_backView addSubview:self.inputView] ;
        [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(20) ;
            make.right.offset(-20) ;
            make.top.equalTo(titleLbl.mas_bottom).offset(30) ;
            make.size.mas_equalTo(CGSizeMake(self.jk_width - 20, 210/6.)) ;
        } ] ;
        
        [_backView addSubview:self.hintLbl] ;
        [self.hintLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.inputView.mas_bottom).offset(10) ;
            make.right.offset(-20) ;
        }] ;
        
    }
    return _backView;
}


-(void)show{
    
    self.backgroundColor = [UIColor colorWithWhite:0. alpha:0.6] ;
    
    UIWindow * keyWindow = [UIApplication sharedApplication].delegate.window ;
    self.frame = CGRectMake(0, 0, keyWindow.jk_width, keyWindow.jk_height) ;

    [keyWindow addSubview:self] ;
    
    [self addSubview:self.backView] ;
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self) ;
        make.size.mas_equalTo(CGSizeMake(300, 200)) ;
    }] ;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowAction:) name:UIKeyboardWillShowNotification object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideAction:) name:UIKeyboardWillHideNotification object:nil];
    
}

#pragma mark - 键盘处理

/**
 *  键盘即将隐藏
 */
- (void)keyboardWillHideAction:(NSNotification *)note
{
    
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        [self.backView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self) ;
        }] ;
    }];
}

/**
 *  键盘即将弹出
 */
- (void)keyboardWillShowAction:(NSNotification *)note
{
    
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        // 取出键盘高度
        [self.backView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self).offset(-100) ;
        }] ;
    }];
}


-(void)hidden{
    [self removeFromSuperview] ;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self] ;
}

-(void)closeBtnTapped{
    [self hidden] ;
}


-(BOOL)isNumText:(NSString *)str{

    NSString * regex        = @"^[0-9]*$";

    NSPredicate * pred      = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];

    BOOL isMatch            = [pred evaluateWithObject:str];

    if (isMatch) {

        return YES;

    }else{

        return NO;

    }

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
