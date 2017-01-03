//
//  BECartView.h
//  SalesTaxesModule
//
//  Created by Lorwy on 2017/1/3.
//  Copyright © 2017年 Lorwy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BECartView : UIView

- (void)setSelectProductArray:(NSArray *)array
                   salesTaxes:(double)salesTaxes
                        total:(double)total;

@end
