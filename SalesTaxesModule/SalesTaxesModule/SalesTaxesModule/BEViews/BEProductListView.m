//
//  BEProductListView.m
//  SalesTaxesModule
//
//  Created by Lorwy on 2017/1/3.
//  Copyright © 2017年 Lorwy. All rights reserved.
//

#import "BEProductListView.h"
#import <Masonry.h>
#import "BEProductListViewCell.h"
#import "BEBaseProduct.h"

@interface BEProductListView()<UITableViewDataSource, UITableViewDelegate,BEProductListViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *productArray;

@end

@implementation BEProductListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _productArray = [NSArray new];
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    [self addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 60, 0));
    }];
    _tableView.rowHeight = 95;
    _tableView.dataSource = self;
}

- (void)setProductArray:(NSArray *)array
{
    _productArray = array;
    [_tableView reloadData];
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
    return _productArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"cellIdentifier";
    BEProductListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[BEProductListViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    // Configure the cell...
    cell.model = _productArray[indexPath.row];
    cell.delegate = self;
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

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self endEditing:YES];
}

#pragma mark - BEProductListViewCellDelegate
- (void)BEProductListViewCell:(BEProductListViewCell *)cell BEProductListViewCellTextFieldDidEndEditing:(UITextField *)textField
{
    NSIndexPath *indexpath = [_tableView indexPathForCell:cell];
    BEBaseProduct *model = _productArray[indexpath.row];
    model.buyCount = textField.text.integerValue;
}

@end
