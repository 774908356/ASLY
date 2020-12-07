//
//  ASFirstSetPasswordVC.m
//  ASLY
//
//  Created by 张志超 on 2020/12/6.
//  Copyright © 2020 AS. All rights reserved.
//

#import "ASFirstSetPasswordVC.h"
#import "ASBaseTableBarVC.h"
#import "ASFirstJoinVC.h"

@interface ASFirstSetPasswordVC ()

@property(nonatomic,copy) NSString *  isSetedPassword ;

@property(nonatomic, strong) UIView   * passwordView ;


/** 用户输入密码 */
@property(nonatomic,copy) NSString *inputPassWordString;

/** 第一次输入的密码 */
@property(nonatomic,copy) NSString *firstInputString ;



@property(nonatomic, strong) UIButton    * reBuildPassBtn ;


@end

@implementation ASFirstSetPasswordVC


-(UIButton *)reBuildPassBtn{
    if (!_reBuildPassBtn) {
        WEAKSELF
        _reBuildPassBtn = [UIButton buttonWithType:UIButtonTypeCustom] ;
        [_reBuildPassBtn setTitle:@"重新创建密码" forState:UIControlStateNormal] ;
        [_reBuildPassBtn setTitleColor:kMainColor forState:UIControlStateNormal] ;
        [_reBuildPassBtn jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            weakSelf.inputPassWordString = @"" ;
            weakSelf.firstInputString = @"" ;
        }] ;
    }
    return _reBuildPassBtn;
}

- (UIView *)passwordView{
    if (!_passwordView) {
        _passwordView = [UIView new] ;
    }
    return _passwordView;
}

-(void)setInputPassWordString:(NSString *)inputPassWordString{
    _inputPassWordString = inputPassWordString ;
    
    NSInteger inputLength = _inputPassWordString.length ;
    
    for (int i = 0; i < 6; i++) {
        UIView * view = [self.passwordView viewWithTag:1206 + i] ;
        if (i < inputLength) {
            view.backgroundColor = kMainColor ;
        }else{
            view.backgroundColor = [UIColor whiteColor] ;
        }
    }
    
    UIButton * btn = [self.view viewWithTag:10010] ;
    
    btn.hidden = !_inputPassWordString.length ;
    
}


-(void)setFirstInputString:(NSString *)firstInputString{
    _firstInputString = firstInputString ;
    
    UILabel * lbl = [self.view viewWithTag:512] ;

    if (_firstInputString.length >= 6) {
        lbl.text = @"请输入密码" ;
    }else{
        lbl.text = @"创建密码" ;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isSetedPassword = [[NSUserDefaults standardUserDefaults] objectForKey:kFirstSetPasswordSuccess];
    
    
    
    UIImageView * iconIv = [UIImageView jk_imageViewWithImageNamed:@"傲硕蓝牙"] ;
    
    [self.view addSubview:iconIv] ;
    
    [iconIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(64) ;
        make.centerX.equalTo(self.view) ;
        make.top.offset(128) ;
    }] ;
    
    UILabel * hintLbl = [UILabel new] ;
    hintLbl.tag = 512 ;
    hintLbl.text = self.isSetedPassword.length ? @"请输入密码" : @"创建密码" ;
    [self.view addSubview:hintLbl] ;
    [hintLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconIv.mas_bottom).offset(40) ;
        make.centerX.equalTo(iconIv) ;
    }] ;
    
    CGFloat passItemWidth = 10 ;
    CGFloat passedgeWidth = 20 ;
    
    [self.view addSubview:self.passwordView] ;
    [self.passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hintLbl.mas_bottom).offset(30) ;
        make.height.mas_equalTo(10) ;
        make.centerX.equalTo(hintLbl) ;
        make.width.mas_equalTo(5 * passedgeWidth + 6 * passItemWidth) ;
    }] ;
    
    UIView * firstItemView = nil ;
    for (int i = 0 ; i < 6; i++) {
        UIView * itemView = [UIView new] ;
        itemView.tag = 1206 + i ;
        itemView.layer.masksToBounds = YES ;
        itemView.layer.cornerRadius = passItemWidth/2. ;
        itemView.layer.borderColor = kMainColor.CGColor ;
        itemView.layer.borderWidth = 1. ;
        [self.passwordView addSubview:itemView] ;
        [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(passItemWidth) ;
            if (firstItemView) {
                make.left.equalTo(firstItemView.mas_right).offset(passedgeWidth) ;
            }else{
                make.left.equalTo(self.passwordView) ;
            }
        }] ;
        firstItemView = itemView ;
    }
    
    CGFloat itemBtnWidth = kScreenWidth / 3. ;
    for (int i = 0 ; i < 11 ; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom] ;
        btn.tag = 10000 + i ;
        [btn addTarget:self action:@selector(numBtnTapped:) forControlEvents:UIControlEventTouchUpInside] ;
        if (i <= 9)[btn setTitle:[NSString stringWithFormat:@"%d", i == 9 ? 0 : i + 1] forState:UIControlStateNormal] ;
        if (i == 10) {
            [btn setImage:[UIImageNamed(@"AS_repeal_btn") jk_imageScaledToSize:CGSizeMake(25, 25)] forState:UIControlStateNormal] ;
            btn.hidden = YES ;
        }
        [btn setTitleColor:kMainColor forState:UIControlStateNormal]  ;
        [self.view addSubview:btn] ;
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(itemBtnWidth) ;
            make.height.mas_equalTo(40) ;
            make.top.equalTo(self.passwordView.mas_bottom).offset(70 * (i / 3) + 30) ;
            if (i == 9) {
                make.left.offset(itemBtnWidth) ;
            }else if (i == 10){
                make.left.offset(itemBtnWidth * 2) ;
                
            }else{
                make.left.offset(itemBtnWidth * (i %3)) ;
            }
        }] ;
    }
    
    
    if (self.isSetedPassword.length) {
        self.firstInputString = self.isSetedPassword ;
        return ;
    }
    [self.view addSubview:self.reBuildPassBtn] ;
    [self.reBuildPassBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-64) ;
        make.centerX.equalTo(self.view) ;
    }] ;
    
    // Do any additional setup after loading the view.
}

-(void)numBtnTapped:(UIButton *)btn{
    
    if (btn.tag == 10010) {
      self.inputPassWordString = [self.inputPassWordString substringToIndex:self.inputPassWordString.length - 1] ;
        
        return;
    }
    
    if (self.inputPassWordString.length >= 6) return;
    
    NSString * oldInpuStr = self.inputPassWordString ;
    
    if (oldInpuStr && oldInpuStr.length) {
        self.inputPassWordString = [NSString stringWithFormat:@"%@%@",oldInpuStr,btn.titleLabel.text] ;
        
    }else{
        self.inputPassWordString = [NSString stringWithFormat:@"%@",btn.titleLabel.text] ;
    }
    
    if (self.inputPassWordString.length >= 6) {
        if (!self.firstInputString || !self.firstInputString.length) {
            self.firstInputString = self.inputPassWordString ;
            self.inputPassWordString = @"" ;
           
        }else{
            if ([self.firstInputString isEqualToString:self.inputPassWordString]) {
                //两次密码一致，下一步
                
                UIViewController * rootVC = nil;
                
              NSString * joinedStr =  [[NSUserDefaults standardUserDefaults] objectForKey:kFirstJoinSuccess] ;
                if (joinedStr && joinedStr.length) {
                   rootVC = [ASBaseTableBarVC new] ;
                }else{
                    rootVC = [ASFirstJoinVC new] ;
                }
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",self.firstInputString] forKey:kFirstSetPasswordSuccess] ;
                [UIApplication sharedApplication].delegate.window.rootViewController = rootVC;
                
                
            }else{
                [[UIApplication sharedApplication].delegate.window jk_makeToast:self.isSetedPassword.length ? @"密码输入错误" : @"两次输入密码不一致" duration:2. position:JKToastPositionCenter] ;
                //self.inputPassWordString = @"" ;
            }
        }
    }
    
    
    
    
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
