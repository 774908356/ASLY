//
//  ASOtherMineViewController.m
//  ASLY
//
//  Created by 张志超 on 2020/11/14.
//  Copyright © 2020 AS. All rights reserved.
//

#import "ASOtherMineViewController.h"
#import "ASBaseCellView.h"
#import "ASUserModel.h"

@interface ASOtherMineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView   * tableView ;

@property(nonatomic, strong) NSMutableArray   * dataSourceMuArr ;



@end

@implementation ASOtherMineViewController {
    ASBaseCellView * backView ;
}

- (NSMutableArray *)dataSourceMuArr{
    if (!_dataSourceMuArr) {
        _dataSourceMuArr = [NSMutableArray new] ;
    }
    return _dataSourceMuArr;
}

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


- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * titleStr = nil ;
    switch (self.type) {
        case ASOtherMineEnum_Info:
            titleStr = @"用户信息" ;
            break;
        case ASOtherMineEnum_OpenKey:
            titleStr = @"解锁记录" ;
            break;
        case ASOtherMineEnum_AboutUs:
            titleStr = @"关于我们" ;
            break;
        default:
            break;
    }
    
    self.title = titleStr ;
    
    [self configData] ;
    
    
     backView = [[ASBaseCellView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:backView] ;
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15) ;
        make.right.offset(-15) ;
        make.top.offset(20 + KAllTopNavBarHeight) ;
        make.height.mas_equalTo(240) ;
    }] ;
    
    [backView addSubview:self.tableView] ;
//    [self.view layoutIfNeeded] ;
//    self.tableView.frame = CGRectMake(15, 0, backView.jk_width - 30, backView.jk_height) ;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(backView) ;
        make.left.offset(15) ;
        make.right.offset(-15) ;
    }] ;
    
    
    // Do any additional setup after loading the view.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.type != ASOtherMineEnum_AboutUs) {
        return self.dataSourceMuArr.count;
    }
    return 1 ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.type != ASOtherMineEnum_AboutUs) {
        return 30 ;
    }
    return 240 ;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ASOtherMineCell"] ;
    UILabel * idLbl = [cell.contentView viewWithTag:1114 + indexPath.row] ;
    UILabel * nameLbl = [cell.contentView viewWithTag:1114000 + indexPath.row] ;
    UILabel * unLockLbl = [cell.contentView viewWithTag:1114000000 + indexPath.row] ;
    if (cell == nil ) {
         cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ASOtherMineCell"] ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone ;
        
        UILabel * userIdLbl = [UILabel new] ;
        idLbl = userIdLbl ;
        idLbl.tag = 1114 + indexPath.row ;
        userIdLbl.textAlignment = NSTextAlignmentCenter ;
        userIdLbl.font =kTEXT_FONT_(13) ;
        userIdLbl.textColor = [UIColor blackColor] ;
        [cell.contentView addSubview:userIdLbl]  ;

        UILabel * userNameLbl = [UILabel new] ;
        nameLbl = userNameLbl ;
        nameLbl.tag = 1114000 + indexPath.row ;
        userNameLbl.font = userIdLbl.font ;
        userNameLbl.textColor = userIdLbl.textColor ;
        userNameLbl.textAlignment = userIdLbl.textAlignment ;
        [cell.contentView addSubview:userNameLbl]  ;

        if (self.type == ASOtherMineEnum_OpenKey) {
            userIdLbl.textAlignment = NSTextAlignmentLeft ;
            userNameLbl.textAlignment = userIdLbl.textAlignment ;


            unLockLbl = [UILabel new] ;
            unLockLbl.tag = 1114000000 + indexPath.row ;
            unLockLbl.font = userIdLbl.font ;
            unLockLbl.textColor = userIdLbl.textColor ;
            [cell.contentView addSubview:unLockLbl] ;
        }


        [userIdLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView) ;
            make.left.equalTo(cell.contentView) ;
            if (unLockLbl) {
                make.width.mas_equalTo(80) ;

            }else{
                make.width.mas_equalTo((kScreenWidth - 30)/2.) ;
            }
        }] ;

        [userNameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.centerY.equalTo(userIdLbl) ;
            make.left.equalTo(userIdLbl.mas_right).offset(unLockLbl ? 10 : 0) ;
        }] ;

        if (unLockLbl) {
            [unLockLbl mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(userNameLbl) ;
                make.left.equalTo(userNameLbl.mas_right).offset(10) ;
                make.right.equalTo(cell.contentView) ;
            }] ;
        }

        
        
    }
    
    if (self.type == ASOtherMineEnum_AboutUs) {
        cell.textLabel.numberOfLines = 0 ;
        cell.textLabel.textAlignment = NSTextAlignmentLeft ;
        cell.textLabel.text = [self.dataSourceMuArr firstObject] ;
    }else{
        ASUserModel * model = self.dataSourceMuArr[indexPath.row] ;
        idLbl.text = model.userId ;
        nameLbl.text = model.userName ;
        if (unLockLbl) unLockLbl.text = model.unLockTime ;
    }
   

    
    
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.type == ASOtherMineEnum_AboutUs) {
        return 0 ;
    }
    return 50;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.type == ASOtherMineEnum_AboutUs) {
        return [UIView new];
    }

    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 30, 60)] ;
    headerView.backgroundColor = [UIColor whiteColor];
    UILabel * userIdLbl = [UILabel new] ;
    userIdLbl.text = @"用户ID" ;
    userIdLbl.textAlignment = NSTextAlignmentCenter ;
    userIdLbl.font =kTEXT_FONT_(13) ;
    userIdLbl.textColor = [UIColor blackColor] ;
    [headerView addSubview:userIdLbl]  ;

    UILabel * userNameLbl = [UILabel new] ;
    userNameLbl.text = @"用户名" ;
    userNameLbl.font = userIdLbl.font ;
    userNameLbl.textColor = userIdLbl.textColor ;
    userNameLbl.textAlignment = userIdLbl.textAlignment ;
    [headerView addSubview:userNameLbl]  ;

    UILabel * unLockLbl = nil ;
    if (self.type == ASOtherMineEnum_OpenKey) {
        userIdLbl.textAlignment = NSTextAlignmentLeft ;
        userNameLbl.textAlignment = userIdLbl.textAlignment ;


        unLockLbl = [UILabel new] ;
        unLockLbl.text = @"解锁记录" ;
        unLockLbl.font = userIdLbl.font ;
        unLockLbl.textColor = userIdLbl.textColor ;
        [headerView addSubview:unLockLbl] ;
    }


    [userIdLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView) ;
        make.left.equalTo(headerView) ;
        if (unLockLbl) {
            make.width.mas_equalTo(80) ;

        }else{
            make.width.mas_equalTo(headerView.jk_width/2.) ;
        }
    }] ;

    [userNameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerY.equalTo(userIdLbl) ;
        make.left.equalTo(userIdLbl.mas_right).offset(unLockLbl ? 10 : 0) ;
    }] ;

    if (unLockLbl) {
        [unLockLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(userNameLbl) ;
            make.left.equalTo(userNameLbl.mas_right).offset(10) ;
            make.right.equalTo(headerView) ;
        }] ;
    }

    return headerView ;
    
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.type == ASOtherMineEnum_Info) {
        return YES;
    }
    
    return NO ;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete ;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.dataSourceMuArr removeObjectAtIndex:indexPath.row] ;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1. * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData] ;

    });
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

-(void)configData{
    
    if (self.type == ASOtherMineEnum_AboutUs) {
        [self.dataSourceMuArr addObject:@"关于我们...关于我们...关于我们...关于我们...关于我们...关于我们...关于我们...关于我们...关于我们...关于我们...关于我们...关于我们...关于我们...\n关于我们...关于我们...关于我们...关于我们...关于我们...关于我们...\n关于我们...关于我们...关于我们...关于我们...关于我们...关于我们...\n关于我们...关于我们...关于我们...关于我们...关于我们...关于我们"] ;
        return;
    }
    
    NSInteger totalDataNum = arc4random() % 20 ;
    
    for (int i = 0 ; i < totalDataNum; i++) {
        ASUserModel * model = [ASUserModel new] ;
        model.userId = [NSString stringWithFormat:@"%u",100 + arc4random()% 1000] ;
        model.userName = [NSString stringWithFormat:@"用户%d号",i] ;
        model.unLockTime = [[NSDate date] jk_stringWithFormat:[NSDate jk_ymdHmsFormat]] ;
        [self.dataSourceMuArr addObject:model] ;
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
