//
//  BECartView.m
//  SalesTaxesModule
//
//  Created by Lorwy on 2017/1/3.
//  Copyright © 2017年 Lorwy. All rights reserved.
//

#import "BECartView.h"
#import <Masonry.h>
#import "BECartViewCell.h"
#import "BEBaseProduct.h"

static const CGFloat kBottomViewHeight = 50;

@interface BECartView()<UITableViewDataSource>

@property (nonatomic, strong) UITableView *tabelView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UILabel *salesTaxesLabel;
@property (nonatomic, strong) UILabel *totalLabel;
@property (nonatomic, strong) NSArray *selectProductArray;

@end

@implementation BECartView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _selectProductArray = @[];
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    _bottomView = [UIView new];
    _bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(-60);
        make.height.equalTo(@(kBottomViewHeight));
    }];
    
    UIView *topLine = [UIView new];
    topLine.backgroundColor = [UIColor lightGrayColor];
    [_bottomView addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.bottomView);
        make.height.equalTo(@(1));
    }];
    
    _salesTaxesLabel = [UILabel new];
    _salesTaxesLabel.textAlignment = NSTextAlignmentLeft;
    _salesTaxesLabel.textColor = [UIColor grayColor];
    _salesTaxesLabel.text = @"Sales Taxes: $0.00";
    [_bottomView addSubview:_salesTaxesLabel];
    [_salesTaxesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomView.mas_centerY);
        make.left.equalTo(self.bottomView.mas_left).offset(10);
    }];
    
    _totalLabel = [UILabel new];
    _totalLabel.textAlignment = NSTextAlignmentLeft;
    _totalLabel.textColor = [UIColor grayColor];
    _totalLabel.text = @"Total: $0.00";
    [_bottomView addSubview:_totalLabel];
    [_totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomView.mas_centerY);
        make.left.equalTo(self.salesTaxesLabel.mas_right).offset(20);
        make.right.lessThanOrEqualTo(self.mas_right).offset(-10);
    }];
    
    _tabelView = [UITableView new];
    [self addSubview:_tabelView];
    _tabelView.dataSource = self;
    _tabelView.rowHeight = 44;
    [_tabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
}

- (void)setSelectProductArray:(NSArray *)array
                   salesTaxes:(double)salesTaxes
                   total:(double)total
{
    _selectProductArray = array;
    _salesTaxesLabel.text = [NSString stringWithFormat:@"Sales Taxes: $%.2f",salesTaxes];
    _totalLabel.text = [NSString stringWithFormat:@"Total: $%.2f",total];
    [self.tabelView reloadData];
}

#pragma mark -
#pragma mark =========  Table view data source  =========
#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _selectProductArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"BECartViewCell";
    BECartViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[BECartViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    // Configure the cell...
    BEBaseProduct *model = _selectProductArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ x%ld    $%.2f",model.name,(long)model.buyCount,model.price + [model salesTaxes]];
    return cell;
}


#pragma mark -
#pragma mark =========  Table view delegate  =========
#pragma mark -
// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Jump to detail view !");
}

@end
