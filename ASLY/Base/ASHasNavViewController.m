//
//  ASHasNavViewController.m
//  ASLY
//
//  Created by 张志超 on 2020/11/13.
//  Copyright © 2020 AS. All rights reserved.
//

#import "ASHasNavViewController.h"

@interface ASHasNavViewController ()

@end

@implementation ASHasNavViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated] ;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.navigationController.navigationBar.hidden = NO ;

    });
}


- (void)viewDidLoad {
    [super viewDidLoad];
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
