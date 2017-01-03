//
//  BESalesTaxesView.h
//  SalesTaxesModule
//
//  Created by Lorwy on 2017/1/3.
//  Copyright © 2017年 Lorwy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BESalesTaxesViewDelegate <NSObject>

- (void)BESalesTaxesViewIndexChange:(NSInteger)index;

@end

@interface BESalesTaxesView : UIView

@property (nonatomic, weak) id<BESalesTaxesViewDelegate> delegate;

- (void)setProductArray:(NSArray *)array;

- (void)setSelectProductArray:(NSArray *)array
                   salesTaxes:(double)salesTaxes
                        total:(double)total;

@end
