//
//  ASBaseTableBarVC.m
//  ASLY
//
//  Created by 张志超 on 2020/11/2.
//  Copyright © 2020 AS. All rights reserved.
//

#import "ASBaseTableBarVC.h"
#import "ASHomePageViewController.h"
#import "ASMineViewController.h"

@interface ASBaseTableBarVC ()

@end

@implementation ASBaseTableBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTabViewControllers] ;
    // Do any additional setup after loading the view.
}

#pragma mark- initTabViewControllers
- (void)initTabViewControllers {
    NSArray * tabArray = @[@{@"navTitle": @"", @"tabtitle": @"首页", @"vc": [[ASHomePageViewController alloc] init], @"tabImage": @"homePage"},
                           @{@"navTitle": @"", @"tabtitle": @"我的", @"vc": [[ASMineViewController alloc] init], @"tabImage": @"Mine"}];
    
    NSMutableArray * vcArray = [NSMutableArray array];
    for (int i = 0; i < tabArray.count; i++) {
        NSDictionary * dict = tabArray[i];
        UINavigationController * navVC = [self configTabVC:dict[@"vc"]
                                                 tabBarItemTitle:dict[@"tabtitle"]
                                             navigationItemTitle:dict[@"navTitle"]
                                                      imageNamed:dict[@"tabImage"]];
        
        [vcArray addObject:navVC];
    }
    [self setViewControllers:vcArray];
}

- (UINavigationController *)configTabVC:(UIViewController *)tabVC
                              tabBarItemTitle:(NSString *)tabBarItemTitle
                          navigationItemTitle:(NSString *)navigationItemTitle
                                   imageNamed:(NSString *)imageNamed {
    if (navigationItemTitle) {
        tabVC.navigationItem.title = navigationItemTitle;
    }
    tabVC.tabBarItem.title = tabBarItemTitle;
    tabVC.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -1);
    
    CGFloat fontSize = 10;
    
    NSString * imageString = [NSString stringWithFormat:@"tabBar_%@", imageNamed];
    NSString * imageSelectString = [imageString stringByAppendingString:@"_selected"];
    
    tabVC.tabBarItem.image = [[UIImage imageNamed:imageString] jk_imageScaledToFitSize:CGSizeMake(21, 21)];
    tabVC.tabBarItem.selectedImage = [[UIImage imageNamed:imageSelectString] jk_imageScaledToFitSize:CGSizeMake(21, 21)];
    
    
    NSDictionary * selectedAttrs = @{NSFontAttributeName : [UIFont systemFontOfSize:fontSize], NSForegroundColorAttributeName : kMainColor};
    [tabVC.tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    
    
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:tabVC];
    return nav;
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
