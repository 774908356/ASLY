//
//  ASModifyDeviceNameVC.m
//  ASLY
//
//  Created by 张志超 on 2020/11/8.
//  Copyright © 2020 AS. All rights reserved.
//

#import "ASModifyDeviceNameVC.h"
#import "ASBaseCellView.h"
#import <MBProgressHUD/MBProgressHUD.h>
@interface ASModifyDeviceNameVC ()<UITextFieldDelegate>

@property(nonatomic, strong) UIButton    * doneBtn ;


@property(nonatomic,copy) NSString * inputString ;


@end

@implementation ASModifyDeviceNameVC

-(UIButton *)doneBtn{
    if (!_doneBtn) {
        WEAKSELF
        _doneBtn = [UIButton buttonWithType:UIButtonTypeCustom] ;
        [_doneBtn jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            if (weakSelf.isModifyName) {
                weakSelf.deviceModel.deviceName = weakSelf.inputString ;
                [[UIApplication sharedApplication].delegate.window jk_makeToast:@"修改成功" duration:2. position:JKToastPositionCenter] ;
            }else{
                UITextField * tx_1 = [[weakSelf.view viewWithTag:202011] viewWithTag:20201111] ;
                UITextField * tx_2 = [[weakSelf.view viewWithTag:202012] viewWithTag:20201112] ;
                UITextField * tx_3 = [[weakSelf.view viewWithTag:202013] viewWithTag:20201113] ;
                
                if (![tx_1.text isEqualToString:weakSelf.deviceModel.devicePassword]) {
                    [[UIApplication sharedApplication].delegate.window jk_makeToast:@"原密码输入错误" duration:2. position:JKToastPositionCenter] ;
                    return;
                }
                if (![tx_2.text isEqualToString:tx_3.text]) {
                    [[UIApplication sharedApplication].delegate.window jk_makeToast:@"密码不匹配" duration:2. position:JKToastPositionCenter] ;
                    return;
                }
                [[UIApplication sharedApplication].delegate.window jk_makeToast:@"修改成功，请记住此密码" duration:2. position:JKToastPositionCenter] ;
                weakSelf.deviceModel.devicePassword = weakSelf.inputString ;
            }
            [weakSelf.navigationController popViewControllerAnimated:YES] ;
           
        }] ;
        _doneBtn.frame = CGRectMake(0, 0, 60, 20) ;
        [_doneBtn setTitle:@"完成" forState:UIControlStateNormal] ;
        _doneBtn.layer.masksToBounds = YES ;
        _doneBtn.layer.cornerRadius = 5. ;
        [self changedDoneBtnStatus:NO] ;
    }
    return _doneBtn;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated] ;
    self.navigationController.navigationBar.hidden = NO ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.isModifyName ? @"名称修改" : @"密码修改" ;
    UIBarButtonItem * cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelItemBtnTapped)] ;
    self.navigationItem.leftBarButtonItem = cancelBtn ;
    
    UIBarButtonItem * doneBarBtn = [[UIBarButtonItem alloc] initWithCustomView:self.doneBtn] ;
    self.navigationItem.rightBarButtonItem = doneBarBtn ;
    if (self.isModifyName) {
        UILabel * topHintLbl = [UILabel new] ;
        topHintLbl.textColor = [UIColor blackColor] ;
        topHintLbl.font = kTEXT_FONT_BOLD_(14) ;
        topHintLbl.text = @"名称" ;
        [self.view addSubview:topHintLbl] ;
        [topHintLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(40) ;
            make.top.offset(KAllTopNavBarHeight + 20) ;
        }] ;
        
        ASBaseCellView * backView = [[ASBaseCellView alloc] initWithFrame:CGRectZero] ;
        [self.view addSubview:backView] ;
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15) ;
            make.right.offset(-15) ;
            make.top.equalTo(topHintLbl.mas_bottom).offset(20) ;
            make.height.mas_equalTo(60) ;
        }] ;
       
        
        UITextField * textFeild = [[UITextField alloc] initWithFrame:CGRectZero] ;
        [textFeild becomeFirstResponder] ;
        textFeild.placeholder = self.deviceModel.deviceName ;
        [textFeild addTarget:self action:@selector(textFeildValueChanged:) forControlEvents:UIControlEventEditingChanged] ;
        textFeild.delegate = self ;
        textFeild.clearButtonMode = UITextFieldViewModeWhileEditing ;
        [backView addSubview:textFeild] ;
        [textFeild mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10) ;
            make.right.offset(-10) ;
            make.top.bottom.equalTo(backView) ;
        }] ;
        UILabel * bottomHintLbl = [UILabel new] ;
        bottomHintLbl.textColor = kNormalTextColor ;
        bottomHintLbl.font = kTEXT_FONT_(12) ;
        bottomHintLbl.text = @"名称必须控制在10个字符内，可使用字母及数字" ;
        [self.view addSubview:bottomHintLbl] ;
        [bottomHintLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(backView.mas_bottom).offset(5) ;
            make.left.equalTo(backView).offset(10) ;
        }] ;
    }else{
        NSArray * titleArr = @[@"名称",@"旧密码",@"新密码",@"新密码"] ;
        NSArray * detailArr = @[self.deviceModel.deviceName,@"请填写旧密码",@"请输入新密码",@"请再次输入新密码"] ;
        ASBaseCellView * nextView = nil ;
        for (int i = 0; i < titleArr.count ; i++) {
            ASBaseCellView * backView = [[ASBaseCellView alloc] initWithFrame:CGRectZero] ;
            backView.tag = 202011 + i - 1 ;
            [self.view addSubview:backView] ;
            [backView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(15) ;
                make.right.offset(-15) ;
                if (nextView) {
                    make.top.equalTo(nextView.mas_bottom).offset(20) ;
                }else{
                    make.top.offset(20 + KAllTopNavBarHeight) ;
                }
                make.height.mas_equalTo(60) ;
            }] ;
            nextView = backView ;
            
            UILabel * titleLbl = [UILabel new] ;
            titleLbl.text = titleArr[i] ;
            titleLbl.textColor = i == 0 ? kColorHex(0xbfbfbf) : [UIColor blackColor] ;
            [backView addSubview:titleLbl] ;
            [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(15) ;
                make.centerY.equalTo(backView) ;
                make.width.mas_equalTo(80) ;
            }] ;
            
            if (i == 0) {
                UILabel * nameLbl = [UILabel new] ;
                nameLbl.textColor = [UIColor blackColor] ;
                nameLbl.text = detailArr[i] ;
                [backView addSubview:nameLbl] ;
                [nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(titleLbl.mas_right);
                    make.centerY.equalTo(titleLbl) ;
                }] ;
            }else{
                UITextField * txField = [[UITextField alloc] initWithFrame:CGRectZero] ;
                if (i == 1) {
                    [txField becomeFirstResponder] ;
                }
                txField.tag = 20201111 + i - 1 ;
                [txField addTarget:self action:@selector(textFeildValueChanged:) forControlEvents:UIControlEventEditingChanged] ;
                txField.delegate = self ;
                txField.placeholder = detailArr[i] ;
                txField.clearButtonMode = UITextFieldViewModeAlways ;
                txField.secureTextEntry = YES ;
                txField.keyboardType = UIKeyboardTypeNumberPad ;
                [backView  addSubview:txField] ;
                [txField mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.bottom.equalTo(backView) ;
                    make.left.equalTo(titleLbl.mas_right) ;
                    make.right.offset(-15) ;
                }] ;
            }
            
        }
        
        UILabel * bottomHintLbl = [UILabel new] ;
        bottomHintLbl.textColor = kNormalTextColor ;
        bottomHintLbl.font = kTEXT_FONT_(12) ;
        bottomHintLbl.text = @"密码必须是6位数字" ;
        [self.view addSubview:bottomHintLbl] ;
        [bottomHintLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(nextView.mas_bottom).offset(15) ;
            make.left.equalTo(nextView).offset(15) ;
        }] ;
        
    }
    
}


-(void)cancelItemBtnTapped{
    [self.navigationController popViewControllerAnimated:YES] ;
}




-(void)changedDoneBtnStatus:(BOOL)canDone{
    UIColor  * backgroundColor = canDone ? kMainColor : kColorHex(0xbfbfbf) ;
    UIColor * textColor = canDone ? [UIColor whiteColor] : kColorHex(0x707070) ;
    self.doneBtn.backgroundColor = backgroundColor ;
    [self.doneBtn setTitleColor:textColor forState:UIControlStateNormal] ;
    self.doneBtn.userInteractionEnabled = canDone ;
    
}


-(void)textFeildValueChanged:(UITextField *)textField{
    if (textField.tag >= 20201111) {
        UITextField * tx_1 = [[self.view viewWithTag:202011] viewWithTag:20201111] ;
        UITextField * tx_2 = [[self.view viewWithTag:202012] viewWithTag:20201112] ;
        UITextField * tx_3 = [[self.view viewWithTag:202013] viewWithTag:20201113] ;
        if (tx_1.text.length == 6 && tx_2.text.length == 6 && tx_3.text.length == 6) {
            [self changedDoneBtnStatus:YES] ;
            self.inputString = tx_3.text ;
        }else{
            [self changedDoneBtnStatus:NO] ;
        }
        return ; 
    }
    [self changedDoneBtnStatus:textField.text.length] ;
    self.inputString = textField.text ;
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



#pragma mark - textfeildDelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.tag >= 20201111 &&(textField.text.length + string.length ) > 6) {
        return NO ;
    }
    
    if (textField.tag >= 20201111) {
        if (![self isNumText:textField.text]) {
            return NO;
        }
    }
    
    if ((textField.text.length + string.length ) > 10) {
        return NO ;
    }
    return YES;
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
