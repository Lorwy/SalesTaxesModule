//
//  AppDelegate+BEAppInitViewCotroller.h
//  SalesTaxesModule
//
//  Created by Lorwy on 2016/12/30.
//  Copyright © 2016年 Lorwy. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (BEAppInitViewCotroller)


/**
 初始化App入口(以类目方式对每个模块进行分类，防止AppDelegate过于臃肿)
 */
- (void)entryViewController;

@end
