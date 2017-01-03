//
//  BESalesTaxesManager.m
//  SalesTaxesModule
//
//  Created by Lorwy on 2017/1/3.
//  Copyright © 2017年 Lorwy. All rights reserved.
//

#import "BESalesTaxesManager.h"
#import "BEBaseProduct.h"
#import "BEBook.h"


@interface BESalesTaxesManager()

@property (nonatomic, copy) ProductListCallBack productListCallback;
@property (nonatomic, strong) NSArray *textProductArray;
@property (nonatomic, assign) double salesTaxesValue;
@property (nonatomic, assign) double totalValue;

@end

@implementation BESalesTaxesManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _textProductArray = @[];
        _salesTaxesValue = 0.00;
        _totalValue = 0.00;
    }
    return self;
}

- (void)requestProductListWithParam:(id)requestParam
                           callback:(ProductListCallBack) callback
{
    _productListCallback = [callback copy];
    _textProductArray = [BESalesTaxesManager textProduct];
    [self performSelector:@selector(p_didDonwLoadList) withObject:nil afterDelay:1];
}

- (void)p_didDonwLoadList
{
    if (_productListCallback)
    {
        _productListCallback(nil,_textProductArray);
    }
}

- (NSArray *)selectProduct
{
    NSMutableArray *array = [NSMutableArray new];
    _salesTaxesValue = 0.00;
    _totalValue = 0.00;
    for (BEBaseProduct *product in _textProductArray)
    {
        if (product.buyCount > 0)
        {
            [array addObject:product];
            _salesTaxesValue += [product salesTaxes] * product.buyCount;
            _totalValue += ([product salesTaxes] + product.price) * product.buyCount;
        }
    }
    return array;
}

- (double)salesTaxesValue
{
    return _salesTaxesValue;
}
- (double)totalValue
{
    return _totalValue;
}

+ (NSArray *)textProduct
{
    BEBook *book = [BEBook new];
    book.name = @"book";
    book.price = 12.49;
    book.basicSalesType = BEBaseProductBasicSalesTypeFree;
    
    BEBaseProduct *musicCd = [BEBaseProduct new];
    musicCd.name = @"music CD";
    musicCd.price = 14.99;
    
    BEBaseProduct *chocolateBar = [BEBaseProduct new];
    chocolateBar.name = @"chocolate bar";
    chocolateBar.price = 0.85;
    chocolateBar.basicSalesType = BEBaseProductBasicSalesTypeFree;
    
#pragma -
    BEBaseProduct *importedBoxChocolates = [BEBaseProduct new];
    importedBoxChocolates.name = @"imported box of chocolates";
    importedBoxChocolates.price = 10.00;
    importedBoxChocolates.productType = BEBaseProductTypeImport;
    importedBoxChocolates.basicSalesType = BEBaseProductBasicSalesTypeFree;
    
    BEBaseProduct *importedBottlePerfumeChoose2 = [BEBaseProduct new];
    importedBottlePerfumeChoose2.name = @"imported bottle of perfume2";
    importedBottlePerfumeChoose2.price = 47.50;
    importedBottlePerfumeChoose2.productType = BEBaseProductTypeImport;
    
#pragma -
    BEBaseProduct *importedBottlePerfumeChoose3 = [BEBaseProduct new];
    importedBottlePerfumeChoose3.name = @"imported bottle of perfume3";
    importedBottlePerfumeChoose3.price = 27.99;
    importedBottlePerfumeChoose3.productType = BEBaseProductTypeImport;
    
    BEBaseProduct *bottlePerfume = [BEBaseProduct new];
    bottlePerfume.name = @"bottle of perfume";
    bottlePerfume.price = 18.99;
    
    BEBaseProduct *packetHeadachePills = [BEBaseProduct new];
    packetHeadachePills.name = @"packet of headache pills";
    packetHeadachePills.price = 9.75;
    packetHeadachePills.basicSalesType = BEBaseProductBasicSalesTypeFree;
    
    BEBaseProduct *boxImprtedChocolates = [BEBaseProduct new];
    boxImprtedChocolates.name = @"box of imported chocolates";
    boxImprtedChocolates.price = 11.25;
    boxImprtedChocolates.basicSalesType = BEBaseProductBasicSalesTypeFree;
    boxImprtedChocolates.productType = BEBaseProductTypeImport;
    
    return @[book,musicCd,chocolateBar,
             importedBoxChocolates,importedBottlePerfumeChoose2,
             importedBottlePerfumeChoose3,bottlePerfume,packetHeadachePills,boxImprtedChocolates];
}


@end
