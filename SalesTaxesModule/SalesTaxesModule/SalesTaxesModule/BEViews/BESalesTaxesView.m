//
//  BESalesTaxesView.m
//  SalesTaxesModule
//
//  Created by Lorwy on 2017/1/3.
//  Copyright © 2017年 Lorwy. All rights reserved.
//

#import "BESalesTaxesView.h"
#import <HMSegmentedControl.h>
#import <Masonry.h>
#import "BECartView.h"
#import "BEProductListView.h"
#import "BECartView.h"
#import "BEDefine.h"

static const CGFloat kSegmentHeight = 60;

@interface BESalesTaxesView()<UIScrollViewDelegate>

@property (nonatomic, strong)HMSegmentedControl *segmentView;
@property (nonatomic, strong)UIScrollView *mainScrollView;
@property (nonatomic, strong) BEProductListView *listView;
@property (nonatomic, strong) BECartView *cartView;

@end

@implementation BESalesTaxesView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    [self prepareMainScrollView];
    [self prepareSegmentView];
}

- (void)prepareMainScrollView
{
    _mainScrollView = [UIScrollView new];
    [self addSubview:_mainScrollView];
    _mainScrollView.scrollEnabled = NO;
    _mainScrollView.showsVerticalScrollIndicator = NO;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    _mainScrollView.delegate = self;
    [_mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-kSegmentHeight);
        make.left.top.right.equalTo(self);
    }];
    
    UIView *containerView = [UIView new];
    containerView.backgroundColor = _mainScrollView.backgroundColor;
    [_mainScrollView addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.mainScrollView);
        make.height.equalTo(self.mainScrollView);
    }];
    
    _listView = [BEProductListView new];
    [containerView addSubview:_listView];
    [_listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(containerView);
        make.width.equalTo(self.mainScrollView);
    }];
    
    _cartView = [BECartView new];
    [containerView addSubview:_cartView];
    _cartView.backgroundColor = [UIColor whiteColor];
    [_cartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.listView.mas_right);
        make.top.bottom.equalTo(containerView);
        make.width.equalTo(self.mainScrollView);
    }];
    
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.cartView.mas_right);
    }];
}

- (void)prepareSegmentView
{
    _segmentView = [HMSegmentedControl new];
    [self addSubview:_segmentView];
    [_segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.equalTo(@(kSegmentHeight));
    }];
    _segmentView.sectionTitles = @[@"Choose",@" Cart"];
    _segmentView.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    _segmentView.backgroundColor = [UIColor whiteColor];
    _segmentView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    _segmentView.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    _segmentView.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor grayColor], NSFontAttributeName : [UIFont systemFontOfSize:16]};
    _segmentView.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor orangeColor],NSFontAttributeName : [UIFont systemFontOfSize:16]};
    
    _segmentView.selectionIndicatorHeight = 3;
    _segmentView.selectionIndicatorColor = [UIColor orangeColor];
    _segmentView.borderType = HMSegmentedControlBorderTypeTop;
    _segmentView.borderColor = [UIColor lightGrayColor];
    _segmentView.borderWidth = 0.5;
    _segmentView.verticalDividerEnabled = YES;
    _segmentView.verticalDividerColor = [UIColor lightGrayColor];
    _segmentView.verticalDividerWidth = 0.5;
    _segmentView.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    
    @weakObj(self);
    
    [_segmentView setIndexChangeBlock:^(NSInteger index) {
        @strongObj(self);
        if (self.delegate && [self.delegate respondsToSelector:@selector(BESalesTaxesViewIndexChange:)])
        {
            [self.delegate BESalesTaxesViewIndexChange:index];
        }
        CGFloat viewWidth = CGRectGetWidth(self.mainScrollView.frame);
        CGFloat viewHeight = CGRectGetHeight(self.mainScrollView.frame);
        [selfWeak.mainScrollView scrollRectToVisible:CGRectMake(viewWidth * index, 0, viewWidth, viewHeight - kSegmentHeight) animated:YES];
    }];
}

- (void)setProductArray:(NSArray *)array
{
    [_listView setProductArray:array];
}

- (void)setSelectProductArray:(NSArray *)array
                   salesTaxes:(double)salesTaxes
                        total:(double)total
{
    [_cartView setSelectProductArray:array salesTaxes:salesTaxes total:total];
}

@end
