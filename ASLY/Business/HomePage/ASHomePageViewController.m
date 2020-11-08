//
//  ASHomePageViewController.m
//  ASLY
//
//  Created by 张志超 on 2020/11/2.
//  Copyright © 2020 AS. All rights reserved.
//

#import "ASHomePageViewController.h"
#import "ASDeviceTableViewCell.h"
#import "ASDeviceDataManager.h"

 NSString * deviceCellStr = @"ASDeviceTableViewCell_homePage" ;

@interface ASHomePageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView   * connecTableView ;

@property(nonatomic, strong) NSArray   * myListArr ;

@property(nonatomic, strong) NSArray   * otherListArr  ;


@end

@implementation ASHomePageViewController

-(UITableView *)connecTableView{
    if (!_connecTableView) {
        _connecTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped] ;
        _connecTableView.delegate = self ;
        _connecTableView.dataSource = self ;
        _connecTableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
        _connecTableView.backgroundColor = [UIColor whiteColor] ;
    }
    
    return _connecTableView ;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _myListArr = [[ASDeviceDataManager shareManager] getMyDeviceArr] ;
    _otherListArr = [[ASDeviceDataManager shareManager] getOtherDeviceArr] ;
    
    [self.view addSubview:self.connecTableView] ;
    
    [self.connecTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view) ;
    }] ;
    
    // Do any additional setup after loading the view.
}


#pragma mark - TableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2 ;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return _myListArr.count;
    }
    return _otherListArr.count ;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60 + 20 ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50 ;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth , 60)] ;
    UIImageView * leftIV = [UIImageView new] ;
    leftIV.image = [[UIImage imageNamed:@"bluetooth"] jk_imageScaledToSize:CGSizeMake(40, 40)] ;
    [headerView addSubview:leftIV] ;
    [leftIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20) ;
        make.width.height.mas_equalTo(40) ;
        make.top.offset(5) ;
        make.bottom.offset(-5) ;
    }] ;
    
    UILabel * titleLbl = [[UILabel alloc] initWithFrame:CGRectZero] ;
    titleLbl.textColor = [UIColor blackColor] ;
    titleLbl.font = kTEXT_FONT_BOLD_(14) ;
    titleLbl.text = section == 0 ? @"我的设备" : @"其他设备" ;
    [headerView addSubview:titleLbl] ;
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftIV.mas_right).offset(15) ;
        make.centerY.equalTo(leftIV) ;
    }] ;
    
    return headerView ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ASDeviceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:deviceCellStr] ;
    
    if (!cell) {
        cell = [[ASDeviceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:deviceCellStr] ;
    }
    ASDeviceModel * model = nil ;
    if (indexPath.section == 0) {
        model = self.myListArr[indexPath.row] ;
    }else{
        model = self.otherListArr[indexPath.row] ;
    }
    
    cell.isHiddenRightView = !model.isMyDevice ;
    cell.titleLbl.text = model.deviceName ;
    cell.connecStatusLbl.text = model.connectionSuccess ? @"已连接" : @"未连接" ;
    
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
