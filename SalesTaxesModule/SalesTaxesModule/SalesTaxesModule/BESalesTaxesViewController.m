//
//  BESalesTaxesViewController.m
//  SalesTaxesModule
//
//  Created by Lorwy on 2016/12/30.
//  Copyright © 2016年 Lorwy. All rights reserved.
//

#import "BESalesTaxesViewController.h"
#import "BESalesTaxesView.h"
#import <Masonry.h>
#import "BESalesTaxesManager.h"
#import "BEDefine.h"


@interface BESalesTaxesViewController ()<BESalesTaxesViewDelegate>

@property (nonatomic, strong)BESalesTaxesView *sealesTaxesView;
@property (nonatomic, strong) BESalesTaxesManager *dataManager;

@end

@implementation BESalesTaxesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _dataManager = [BESalesTaxesManager new];
    [self setupUI];
    @weakObj(self);
    [_dataManager requestProductListWithParam:@{} callback:^(NSError * _Nonnull error, NSArray * _Nonnull response) {
        @strongObj(self);
        [self renderListView:response];
        
    }];
    // Do any additional setup after loading the view.
}

- (void)setupUI
{
    _sealesTaxesView = [BESalesTaxesView new];
    [self.view addSubview:_sealesTaxesView];
    _sealesTaxesView.delegate = self;
    [_sealesTaxesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)renderListView:(NSArray *)array
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [_sealesTaxesView setProductArray:array];
    });
}

#pragma mark - BESalesTaxesViewDelegate
- (void)BESalesTaxesViewIndexChange:(NSInteger)index
{
    if (index == 1)
    {
        [_sealesTaxesView setSelectProductArray:[_dataManager selectProduct]
                                     salesTaxes:[_dataManager salesTaxesValue]
                                          total:[_dataManager totalValue]];
    }
}

@end
