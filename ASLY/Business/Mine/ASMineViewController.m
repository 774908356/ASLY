//
//  ASMineViewController.m
//  ASLY
//
//  Created by 张志超 on 2020/11/2.
//  Copyright © 2020 AS. All rights reserved.
//

#import "ASMineViewController.h"
#import "ASBaseCellView.h"

@interface ASMineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView   * tableView ;


@end

@implementation ASMineViewController

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain] ;
        _tableView.delegate = self ;
        _tableView.dataSource = self ;
        _tableView.backgroundColor = [UIColor whiteColor] ;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
        
    }
    return _tableView;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated] ;
    
    [self.tableView reloadData] ;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView] ;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view) ;
    }] ;
    
    // Do any additional setup after loading the view.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 150 + 20;
    }else if (indexPath.row == 1){
        return 180 +20;
    }
    
    return 60 + 20 ;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""] ;
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    ASBaseCellView * backView = [[ASBaseCellView alloc] initWithFrame:CGRectZero];
    [cell.contentView addSubview:backView] ;
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15) ;
        make.right.offset(-15) ;
        make.top.offset(10) ;
        make.bottom.offset(-10) ;
    }] ;
    if (indexPath.row == 0) {
        UIImageView * iconIV = [UIImageView jk_imageViewWithImageNamed:@"bluetooth"] ;
        [backView addSubview:iconIV] ;
        [iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(20) ;
            make.width.height.mas_equalTo(60) ;
            make.centerX.equalTo(backView) ;
        }] ;
        
        UIButton * nameBtn = [UIButton buttonWithType:UIButtonTypeCustom] ;
        nameBtn.jk_touchAreaInsets = UIEdgeInsetsMake(10, 10, 10, 50) ;
        [nameBtn jk_addActionHandler:^(NSInteger tag) {
            NSArray<ASDeviceModel *> * myListArr = [[ASDeviceDataManager shareManager] getMyDeviceArr] ;
            if (myListArr.count) {
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
                    make.top.offset([[UIApplication sharedApplication] statusBarFrame].size.height + 150 - 5) ;
                    make.centerX.equalTo(self.view) ;
                    make.width.mas_equalTo(160);
                    make.height.mas_equalTo(40 * myListArr.count + 20) ;
                }];
                
                UIView * firstView = nil ;
                for (int i = 0 ; i < myListArr.count; i++) {
                    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom] ;
                    btn.tag = 2020 + i ;
                    [btn jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
                        [nameBtn setTitle:myListArr[i].deviceName forState:UIControlStateNormal];
                        [backBtn removeFromSuperview] ;
                    }] ;
                    [btn setTitle:myListArr[i].deviceName forState:UIControlStateNormal] ;
                    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal] ;
                    btn.titleLabel.font = kTEXT_FONT_(14) ;
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
                    if (i < myListArr.count - 1) {
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
        nameBtn.titleLabel.font = kTEXT_FONT_BOLD_(20) ;
        [nameBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal] ;
        NSString * nameStr = [[[ASDeviceDataManager shareManager] getMyDeviceArr] firstObject].deviceName ;
        if (!nameStr) nameStr = @"暂无可连接设备" ;
        [nameBtn setTitle:nameStr forState:UIControlStateNormal]  ;
        [backView addSubview:nameBtn] ;
        [nameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(iconIV.mas_bottom).offset(15) ;
            make.centerX.equalTo(backView) ;
        }] ;
        
        if (![nameStr hasPrefix:@"暂无可连接设备"]) {
            UIImageView * moreIV = [UIImageView jk_imageViewWithImageNamed:@"as_xiasanjiao_iv"] ;
            [backView addSubview:moreIV] ;
            [moreIV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(nameBtn.mas_right).offset(20) ;
                make.size.mas_equalTo(CGSizeMake(10, 5)) ;
                make.centerY.equalTo(nameBtn) ;
            }] ;
        }
        
    }else if (indexPath.row == 1){
        
    
        
        
    }else{
        
    }
    
    
    
    return cell;
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
