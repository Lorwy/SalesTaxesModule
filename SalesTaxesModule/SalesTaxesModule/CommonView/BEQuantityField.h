//
//  BEQuantityField.h
//  SalesTaxesModule
//
//  Created by Lorwy on 2017/1/3.
//  Copyright © 2017年 Lorwy. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kBEQuantityFieldSize   CGSizeMake(58, 25)

@interface BEQuantityField : UITextField

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic) BOOL allowEdit;    //default is Yes

@end
