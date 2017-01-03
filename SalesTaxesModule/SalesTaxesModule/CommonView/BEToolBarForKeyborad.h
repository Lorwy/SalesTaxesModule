//
//  BEToolBarForKeyborad.h
//  SalesTaxesModule
//
//  Created by Lorwy on 2017/1/3.
//  Copyright © 2017年 Lorwy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BEToolBarForKeyborad : UIToolbar

@property (nonatomic, strong) NSString *noticeString;

//you need pass title, target, action for done button
- (id)initWithDoneBtnTitle:(NSString *)closeBtnTitle
                    target:(id)target
                    action:(SEL)action;

@end
