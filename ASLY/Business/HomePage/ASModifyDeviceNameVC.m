//
//  ASModifyDeviceNameVC.m
//  ASLY
//
//  Created by 张志超 on 2020/11/8.
//  Copyright © 2020 AS. All rights reserved.
//

#import "ASModifyDeviceNameVC.h"

@interface ASModifyDeviceNameVC ()

@property(nonatomic, strong) UIButton    * doneBtn ;


@end

@implementation ASModifyDeviceNameVC

-(UIButton *)doneBtn{
    if (!_doneBtn) {
        _doneBtn = [UIButton buttonWithType:UIButtonTypeCustom] ;
        [_doneBtn setTitle:@"完成" forState:UIControlStateNormal] ;
        
    }
    return _doneBtn;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated] ;
    self.navigationController.navigationBar.hidden = NO ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"名称修改" ;
    UIBarButtonItem * cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelItemBtnTapped)] ;
    self.navigationItem.leftBarButtonItem = cancelBtn ;
    
    
}


-(void)cancelItemBtnTapped{
    [self.navigationController popViewControllerAnimated:YES] ;
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
