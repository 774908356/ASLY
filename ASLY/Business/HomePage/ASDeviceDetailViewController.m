//
//  ASDeviceDetailViewController.m
//  ASLY
//
//  Created by 张志超 on 2020/11/8.
//  Copyright © 2020 AS. All rights reserved.
//

#import "ASDeviceDetailViewController.h"
#import "ASBaseCellView.h"
#import "ASModifyDeviceNameVC.h"

@interface ASDeviceDetailViewController ()

@end

@implementation ASDeviceDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated] ;
    self.navigationController.navigationBar.hidden = NO ;
    self.title = self.deviceModel.deviceName ;
    UILabel * tagLbl = [[self.view viewWithTag:1109] viewWithTag:20201109] ;
   if (tagLbl && self.deviceModel.connectionSuccess) tagLbl.text = self.deviceModel.deviceName ;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated] ;
    self.navigationController.navigationBar.hidden = YES ;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    WEAKSELF
    NSArray * titleArr = @[@"名称",@"密码",@"感应距离",@"MAC地址",@""] ;
    NSArray * detailArr = @[self.deviceModel.deviceName,@"点击修改",[NSString stringWithFormat:@"%ld米",(long)self.deviceModel.sensingDistance],self.deviceModel.macAddress] ;
    if (!self.deviceModel.connectionSuccess) {
        titleArr = @[@"MAC地址",@""] ;
        detailArr = @[self.deviceModel.macAddress] ;
    }
    
    ASBaseCellView * firstView = nil ;
    for (int i = 0; i < titleArr.count; i++) {
        ASBaseCellView * backView = [[ASBaseCellView alloc] initWithFrame:CGRectZero] ;
        backView.tag = 1109 + i ;
        [self.view addSubview:backView] ;
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15) ;
            make.right.offset(-15) ;
            if (i == (titleArr.count - 1) && self.deviceModel.connectionSuccess) {
                make.height.mas_equalTo(100) ;
            }else{
                make.height.mas_equalTo(60) ;
            }
            if (firstView) {
                make.top.equalTo(firstView.mas_bottom).offset(20) ;
            }else{
                make.top.offset(20 + KAllTopNavBarHeight) ;
            }
        }] ;
        
        if (i <= 2 && self.deviceModel.connectionSuccess) {
            UIButton * nextBtn = [UIButton buttonWithType:UIButtonTypeCustom] ;
            [backView addSubview:nextBtn] ;
            [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(backView) ;
            }] ;
            [nextBtn jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
                if (i == 0 || i == 1) {
                    ASModifyDeviceNameVC * vc = [ASModifyDeviceNameVC new] ;
                    vc.isModifyName = i == 0 ? YES : NO ;
                    vc.deviceModel = self.deviceModel ;
                    [self.navigationController pushViewController:vc animated:YES] ;
                }else if (i == 2){
                    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom]  ;
                    [backBtn jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
                        [backBtn removeFromSuperview] ;
                    }] ;
                    [self.view addSubview:backBtn] ;
                    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.edges.equalTo(self.view) ;
                    }] ;
                    
                    UIView * changedView = [UIView new] ;
                    changedView.backgroundColor = kColorHex(0x8a8a8a) ;
                    changedView.layer.masksToBounds = YES ;
                    changedView.layer.cornerRadius = 5. ;
                    [backBtn addSubview:changedView] ;
                    [changedView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.offset(nextBtn.superview.jk_origin.y + nextBtn.superview.jk_height - 5) ;
                        make.right.offset(-15) ;
                        make.width.mas_equalTo(120);
                        make.height.mas_equalTo(183) ;
                    }];
                    
                    UIView * firstView = nil ;
                    for (int i = 0 ; i < 4; i++) {
                        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom] ;
                        btn.tag = 2020 + i ;
                        [btn jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
                            self.deviceModel.sensingDistance = btn.tag - 2020 + 1 ;
                            UILabel * lbl = [nextBtn.superview viewWithTag:20201111] ;
                            lbl.text = [NSString stringWithFormat:@"%ld米",(long)self.deviceModel.sensingDistance] ;
                            [backBtn removeFromSuperview] ;
                        }] ;
                        [btn setTitle:[NSString stringWithFormat:@"%d米",i + 1] forState:UIControlStateNormal] ;
                        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal] ;
                        btn.titleLabel.font = kTEXT_FONT_(13) ;
                        [changedView addSubview:btn] ;
                        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.left.right.equalTo(changedView) ;
                            make.height.mas_equalTo(40) ;
                            if (firstView) {
                                make.top.equalTo(firstView.mas_bottom).offset(1) ;
                            }else{
                                make.top.equalTo(changedView) ;
                            }
                        }] ;
                        firstView = btn ;
                        if (i < 3) {
                            UIView * lineView = [UIView new] ;
                            lineView.backgroundColor = [UIColor whiteColor] ;
                            [changedView addSubview:lineView] ;
                            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                                make.left.right.equalTo(changedView) ;
                                make.height.mas_equalTo(1) ;
                                make.top.equalTo(firstView.mas_bottom) ;
                            }] ;
                        }
                        
                    }
                    
                }
            }] ;
            
        }
        
        
        firstView = backView ;
        
        if (i < (titleArr.count - 1)) {
            UILabel * nameLbl = [UILabel new] ;
            nameLbl.text = titleArr[i] ;
            nameLbl.textColor = [UIColor blackColor] ;
            [backView addSubview:nameLbl] ;
            [nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(15) ;
                make.centerY.equalTo(backView) ;
            }] ;
            
            UILabel * detailLbl = [UILabel new] ;
            detailLbl.text = detailArr[i] ;
            detailLbl.tag = 20201109 + i ;
            detailLbl.textColor = kColorHex(0x8a8a8a) ;
            [backView addSubview:detailLbl] ;
            
            UIImageView * nextSignView = nil ;
            if (i <= 2 && self.deviceModel.connectionSuccess) {
                UIImageView * nextIV = [UIImageView new] ;
                if (i <= 1) {
                    nextIV.image = [UIImageNamed(@"as_next_iv") jk_imageScaledToSize:CGSizeMake(20, 15)] ;
                }else{
                    nextIV.image = [UIImageNamed(@"as_xiasanjiao_iv") jk_imageScaledToSize:CGSizeMake(20, 15)] ;
                }
                [backView  addSubview:nextIV] ;
                [nextIV mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.offset(-15) ;
                    make.centerY.equalTo(backView) ;
                    make.width.mas_equalTo(20) ;
                    make.height.mas_equalTo(15) ;
                }] ;
                nextSignView = nextIV ;
            }
            
            [detailLbl mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(backView) ;
                if (nextSignView) {
                    make.right.equalTo(nextSignView.mas_left).offset(-20) ;
                }else{
                    make.right.offset(-5) ;
                }
            }] ;
           
            
            
            
        }else{
            NSArray * btnArr = @[@"断开连接",@"忽略此设备"] ;
            if (!_deviceModel.connectionSuccess) {
                btnArr = @[@"忽略此设备"] ;
            }
            
            UIButton * firBtn = nil ;
            NSString * alerTitleStr = nil ;
            NSString * msgStr = nil ;
            for (int i = 0; i < btnArr.count; i ++) {
                if (i == 0 && self.deviceModel.connectionSuccess) {
                    alerTitleStr = @"您确认断开连接此设备吗？" ;
                    msgStr = @"" ;
                }else{
                    alerTitleStr = @"您确认忽略此设备吗？" ;
                    msgStr = @"删除之后再次连接需要重新输入密码" ;
                }
                UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom] ;
                [btn jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
                    UIAlertController * alert = [UIAlertController alertControllerWithTitle:alerTitleStr message:msgStr preferredStyle:UIAlertControllerStyleAlert] ;
                    UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        [alert dismissViewControllerAnimated:YES completion:^{
                            
                        }] ;
                    }] ;
                    [alert addAction:action1] ;
                    
                    UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                        weakSelf.deviceModel.isMyDevice = NO ;
                        weakSelf.deviceModel.connectionSuccess = NO ;
                        [weakSelf.navigationController popViewControllerAnimated:YES] ;
                    }] ;
                    
                    [alert addAction:action2] ;
                    
                    [self presentViewController:alert animated:YES completion:^{
                    
                    }] ;
                }] ;
                [btn setTitle:btnArr[i] forState:UIControlStateNormal] ;
                [btn setTitleColor:kMainColor forState:UIControlStateNormal] ;
                [backView addSubview:btn] ;
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.offset(15) ;
                    make.height.mas_equalTo(20) ;
                    if (firBtn) {
                        make.top.equalTo(firBtn.mas_bottom).offset(20) ;
                    }else{
                        make.top.offset(20) ;
                    }
                    if (btnArr.count == 1) {
                        make.centerY.equalTo(backView) ;
                    }
                }] ;
                firBtn = btn ;
            }
            
        }
        
    }
    
    // Do any additional setup after loading the view.
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
