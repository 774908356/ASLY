//
//  ASFirstJoinVC.m
//  ASLY
//
//  Created by 张志超 on 2020/11/3.
//  Copyright © 2020 AS. All rights reserved.
//

#import "ASFirstJoinVC.h"
#import "ASBaseTableBarVC.h"
#import "ASBaseCellView.h"
#import "ASInputConnectPasswordView.h"

@interface ASFirstJoinVC ()

@property(nonatomic, strong) UIImageView   * backgroundIV  ;

@property(nonatomic, strong) UIImageView   * iconIV  ;

@property(nonatomic, strong) NSArray   * listArr  ;


@end

@implementation ASFirstJoinVC

-(UIImageView *)backgroundIV{
    if (!_backgroundIV) {
        _backgroundIV = [UIImageView jk_imageViewWithImageNamed:@"intro_background"] ;
    }
    return _backgroundIV ;
}


-(UIImageView *)iconIV{
    if (!_iconIV) {
        _iconIV = [UIImageView jk_imageViewWithImageNamed:@"bluetooth"] ;
        _iconIV.backgroundColor = [UIColor whiteColor] ;
        _iconIV.layer.masksToBounds = YES ;
        _iconIV.layer.cornerRadius = 94/2. ;
    }
    return _iconIV ;
}

-(NSArray *)listArr{
    if (!_listArr) {
        _listArr = [[ASDeviceDataManager shareManager] getOtherDeviceArr] ;
       // _listArr = @[@"Jessie",@"Marco12",@"Wuzexi"] ;

    }
    return _listArr ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.backgroundIV] ;
    [self.backgroundIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view) ;
        make.height.equalTo(self.view.mas_width).multipliedBy(0.5307) ;
    }] ;
    
    [self.view addSubview:self.iconIV] ;
    
    [self.iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(94) ;
        make.centerX.equalTo(self.backgroundIV) ;
        make.centerY.equalTo(self.backgroundIV.mas_bottom) ;
    }] ;
    
    UILabel * hintLbl = [[UILabel alloc] initWithFrame:CGRectZero] ;
    hintLbl.textColor = [UIColor blackColor] ;
    hintLbl.text = @"请选择连接设备" ;
    hintLbl.font = kTEXT_FONT_BOLD_(17) ;
    
    [self.view addSubview:hintLbl] ;
    
    [hintLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.iconIV) ;
        make.top.equalTo(self.iconIV.mas_bottom).offset(20) ;
    }] ;
    

    
    
    UIButton * jumpBtn = [UIButton buttonWithType:UIButtonTypeCustom] ;
    [jumpBtn addTarget:self action:@selector(jumpBtnTapped) forControlEvents:UIControlEventTouchUpInside] ;
    jumpBtn.jk_touchAreaInsets = UIEdgeInsetsMake(20, 20, 20, 20) ;
    jumpBtn.titleLabel.font = kTEXT_FONT_(14) ;
    [jumpBtn setTitle:@"跳过" forState:UIControlStateNormal] ;
    [jumpBtn setTitleColor:kColorHex(0x8a8a8a) forState:UIControlStateNormal] ;
    [self.view addSubview:jumpBtn] ;
    [jumpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-40) ;
        make.bottom.offset(-20) ;
    }] ;
    
    [self.view layoutIfNeeded] ;
    
    CGFloat cellHeight = (self.view.jk_height - hintLbl.jk_bottom - 40 - (self.listArr.count - 1) * 15 - 20 - (self.view.jk_height - jumpBtn.jk_origin.y)) / self.listArr.count ;
    if (cellHeight > 60) {
        cellHeight = 60 ;
    }
    
    ASBaseCellView * firstView = nil ;
    for (int i = 0 ; i < self.listArr.count; i++) {
        ASBaseCellView * cellView = [[ASBaseCellView alloc] initWithFrame:CGRectZero] ;
        [self.view addSubview:cellView] ;
        [cellView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(20) ;
            make.right.offset(-20) ;
            make.height.mas_equalTo(cellHeight) ;
            if (firstView) {
                make.top.equalTo(firstView.mas_bottom).offset(15) ;
            }else{
                make.top.equalTo(hintLbl.mas_bottom).offset(40) ;
            }
        }] ;
        
        firstView = cellView ;
        
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom] ;
        btn.tag = 1104 + i ;
        [cellView addSubview:btn] ;
        [btn addTarget:self action:@selector(cellBtnTapped:) forControlEvents:UIControlEventTouchUpInside] ;
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cellView) ;
        }] ;
        
        ASDeviceModel * model = self.listArr[i] ;
        UILabel * titleLbl = [UILabel new] ;
        titleLbl.text = model.deviceName ;
        titleLbl.textColor = kNormalTextColor ;
        [btn addSubview:titleLbl] ;
        [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(btn) ;
            make.left.offset(15) ;
        }] ;
    }
    
    
    
    // Do any additional setup after loading the view.
}


-(void)jumpBtnTapped{
    
    [UIApplication sharedApplication].delegate.window.rootViewController = [ASBaseTableBarVC new]  ;
    
}


-(void)cellBtnTapped:(UIButton *)btn{
    ASDeviceModel * model = self.listArr[btn.tag - 1104] ;
    
    ASInputConnectPasswordView * passwordView = [ASInputConnectPasswordView new] ;
    passwordView.rightPasswordStr = model.devicePassword ;
    [passwordView show] ;
    WEAKSELF
    passwordView.inputSuccess = ^{
        model.isMyDevice = YES ;
        model.connectionSuccess = YES ;
        [weakSelf jumpBtnTapped] ;
    } ;

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
