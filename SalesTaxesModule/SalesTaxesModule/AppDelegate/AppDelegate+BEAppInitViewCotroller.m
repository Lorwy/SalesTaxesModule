//
//  AppDelegate+BEAppInitViewCotroller.m
//  SalesTaxesModule
//
//  Created by Lorwy on 2016/12/30.
//  Copyright © 2016年 Lorwy. All rights reserved.
//

#import "AppDelegate+BEAppInitViewCotroller.h"
#import "BESalesTaxesViewController.h"

@implementation AppDelegate (BEAppInitViewCotroller)

- (void)entryViewController
{
    [self p_setupViewController];
}

-(void)p_setupViewController
{
    BESalesTaxesViewController *salesTaxesVC = [BESalesTaxesViewController new];
    UINavigationController *nSalesTaxesVC = [[UINavigationController alloc] initWithRootViewController:salesTaxesVC];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = nSalesTaxesVC;
    [self.window makeKeyAndVisible];
}

@end
