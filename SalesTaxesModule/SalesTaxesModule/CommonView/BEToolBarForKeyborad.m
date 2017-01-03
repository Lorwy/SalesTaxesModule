//
//  BEToolBarForKeyborad.m
//  SalesTaxesModule
//
//  Created by Lorwy on 2017/1/3.
//  Copyright © 2017年 Lorwy. All rights reserved.
//

#import "BEToolBarForKeyborad.h"

@interface BEToolBarForKeyborad()

@property (nonatomic, strong) UILabel *noticeLabel;

@end

@implementation BEToolBarForKeyborad

- (void)setNoticeString:(NSString *)noticeString
{
    _noticeLabel.text = noticeString;
}


- (id)initWithDoneBtnTitle:(NSString *)closeBtnTitle
                    target:(id)target
                    action:(SEL)action
{
    self = [super initWithFrame:CGRectMake(0,0,
                                           self.frame.size.width,
                                           44)];
    if (self)
    {
        [self setBarStyle:UIBarStyleDefault];
        UIBarButtonItem *barButtonDone =  [[UIBarButtonItem alloc] initWithTitle:closeBtnTitle
                                                                           style:UIBarButtonItemStyleDone
                                                                          target:target
                                                                          action:action];
        _noticeLabel = [UILabel new];
        _noticeLabel.frame = CGRectMake(0, 0, 240, self.frame.size.height);
        _noticeLabel.text = @"";
        _noticeLabel.font = [UIFont systemFontOfSize:14];
        
        UIBarButtonItem *noticeItem = [[UIBarButtonItem alloc] initWithCustomView:_noticeLabel];
        
        
        
        UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                   target:self action:nil];
        
        UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                    target:self action:nil];
        fixedSpace.width = 10;
        self.items = @[noticeItem, flexSpace, barButtonDone, fixedSpace];
    }
    
    return self;
}

@end
