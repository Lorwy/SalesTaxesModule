//
//  BEProductListViewCell.m
//  SalesTaxesModule
//
//  Created by Lorwy on 2017/1/3.
//  Copyright © 2017年 Lorwy. All rights reserved.
//

#import "BEProductListViewCell.h"
#import <Masonry.h>
#import "BEToolBarForKeyborad.h"
#import "BEBaseProduct.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface BEProductListViewCell()
{
    UIToolbar *_toolBarForKeyboard;
}

@end


@implementation BEProductListViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    CGFloat _horizontalPadding = 10.0f;
    CGFloat _verticalPadding = 15.0f;
    
    _productImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _productImageView.contentMode = UIViewContentModeScaleAspectFit;
    _productImageView.layer.masksToBounds = YES;
    _productImageView.layer.opaque = NO;
    _productImageView.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:_productImageView];
    
    [_productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(_horizontalPadding);
        make.top.equalTo(self.contentView.mas_top).offset(_verticalPadding);
        make.width.equalTo(@(75));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-_verticalPadding);
    }];
    
    _priceLabel = [UILabel new];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    _priceLabel.textColor = [UIColor lightGrayColor];
    _priceLabel.text = @"￥123";
    [self.contentView addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    
    _nameLabel = [UILabel new];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel.textColor = [UIColor grayColor];
    _nameLabel.text = @"进口巧克力";
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_productImageView.mas_right).offset(5);
        make.right.equalTo(_priceLabel.mas_left).offset(-5);
        make.top.equalTo(_productImageView.mas_top);
    }];
    
    _quantityField = [[BEQuantityField alloc] initWithFrame:CGRectZero];
    _quantityField.textField.delegate = self;
    _quantityField.textField.keyboardType = UIKeyboardTypeNumberPad;
    [self.contentView addSubview:_quantityField];
    [_quantityField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.mas_left);
        make.width.equalTo(@(kBEQuantityFieldSize.width));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-_verticalPadding);
        make.height.equalTo(@(kBEQuantityFieldSize.height));
    }];
    _quantityField.textField.text = @"0";
}

- (void)setModel:(BEBaseProduct *)model
{
    _model = model;
    _nameLabel.text = model.name;
    _priceLabel.text = [NSString stringWithFormat:@"$%.2f",model.price];
    _quantityField.textField.text = [NSString stringWithFormat:@"%ld",(long)model.buyCount];
    [_productImageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
}

#pragma mark - UITextField Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //Number only
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0)
    {
        return NO;
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _model.buyCount = textField.text.integerValue;
    if(self.delegate && [self.delegate respondsToSelector:@selector(BEProductListViewCell : BEProductListViewCellTextFieldDidEndEditing:)])
    {
        [self.delegate BEProductListViewCell:self BEProductListViewCellTextFieldDidEndEditing:textField];
    }
}



@end
