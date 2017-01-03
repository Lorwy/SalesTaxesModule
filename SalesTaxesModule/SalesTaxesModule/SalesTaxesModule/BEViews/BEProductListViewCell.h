//
//  BEProductListViewCell.h
//  SalesTaxesModule
//
//  Created by Lorwy on 2017/1/3.
//  Copyright © 2017年 Lorwy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEQuantityField.h"

@class BEProductListViewCell;

@protocol BEProductListViewCellDelegate <NSObject>

- (void)BEProductListViewCell:(BEProductListViewCell *)cell BEProductListViewCellTextFieldDidEndEditing:(UITextField *)textField;

@end

@class BEBaseProduct;

@interface BEProductListViewCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *productImageView;
@property (nonatomic, strong) BEQuantityField *quantityField;

@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) BEBaseProduct *model;
@property (nonatomic, weak) id<BEProductListViewCellDelegate> delegate;

@end
