//
//  AppDelegate.m
//  ASLY
//
//  Created by 张志超 on 2020/11/2.
//  Copyright © 2020 AS. All rights reserved.
//

#import "AppDelegate.h"
#import "ASBaseTableBarVC.h"
#import "ASFirstJoinVC.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UIViewController * rootVC = nil;
    if (NO) {
       rootVC = [ASBaseTableBarVC new] ;
    }else{
        rootVC = [ASFirstJoinVC new] ;
    }
     self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.window.rootViewController = rootVC;
        [self.window makeKeyAndVisible];
        
    
    return YES;
}





@end
