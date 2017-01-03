//
//  BEQuantityField.m
//  SalesTaxesModule
//
//  Created by Lorwy on 2017/1/3.
//  Copyright © 2017年 Lorwy. All rights reserved.
//

#import "BEQuantityField.h"

@interface BEQuantityField()

@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UITapGestureRecognizer *tap;

@end

@implementation BEQuantityField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _allowEdit = YES;
        
        self.userInteractionEnabled = YES;
        
        self.backgroundColor = [UIColor clearColor];
        self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.layer.borderWidth = 0.5f;
        
        _textField = [[UITextField alloc] init];
        _textField.font = [UIFont systemFontOfSize: 12];
        _textField.textColor = [UIColor lightGrayColor];
        _textField.placeholder = @"";
        _textField.textAlignment = NSTextAlignmentCenter;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        [self addSubview:_textField];
        
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _arrowImageView.image = [UIImage imageNamed:@"shopping_cart_icons_number"];
        [self addSubview:_arrowImageView];
        
        _tap = [UITapGestureRecognizer new];
        [_tap addTarget:self action:@selector(tapped)];
        [self addGestureRecognizer:_tap];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    float arrowSideWidth = 10;
    _arrowImageView.frame = CGRectMake(CGRectGetWidth(self.frame) - arrowSideWidth * 2,
                                       (CGRectGetHeight(self.frame) - arrowSideWidth) / 2,
                                       arrowSideWidth, arrowSideWidth);
    _textField.frame = CGRectMake(0, 0,
                                  CGRectGetMinX(_arrowImageView.frame),
                                  CGRectGetHeight(self.frame));
}

- (void)tapped
{
    if (_allowEdit)
    {
        [_textField becomeFirstResponder];
    }
}

- (void)setAllowEdit:(BOOL)allowEdit
{
    _allowEdit = allowEdit;
    
    _textField.userInteractionEnabled = _allowEdit;
    _arrowImageView.hidden = !_allowEdit;
    if (_allowEdit)
    {
        self.layer.borderWidth = 0.5f;
    }
    else
    {
        self.layer.borderWidth = 0;
    }
}

@end
