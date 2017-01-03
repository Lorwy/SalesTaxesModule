//
//  BEBaseProduct.m
//  SalesTaxesModule
//
//  Created by Lorwy on 2016/12/30.
//  Copyright © 2016年 Lorwy. All rights reserved.
//

#import "BEBaseProduct.h"

static const float kProductImportDutyDefuat = 0.05;  /**< 进口税，进口产品适用 */

static const float kProductBasicSalesDefuat = 0.1;  /**< 除免征营业税的书，食品，医疗用品以外的所有产品均适用 */
static const float kProductBasicSalesFree = 0;


@implementation BEBaseProduct

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

- (float)importDuty
{
    switch (_productType)
    {
        case BEBaseProductTypeDefuat:
            return 0;
            break;
            
        case BEBaseProductTypeImport:
            return kProductImportDutyDefuat;
            break;
    }
}

- (float)basicSales
{
    switch (_basicSalesType)
    {
        case BEBaseProductBasicSalesTypeDefuat:
            return kProductBasicSalesDefuat;
            break;
            
        case BEBaseProductBasicSalesTypeFree:
            return kProductBasicSalesFree;
            break;
    }
}

- (double)salesTaxes
{
    float n = [self importDuty] + [self basicSales];
    if (n == 0)
    {
        return 0.00;
    }
    double salesTaxes = _price * n * 100;
    NSInteger tempSales = roundf(salesTaxes);
    NSInteger temp = tempSales % 10;
    if (temp < 5 && temp > 0)
    {
        salesTaxes = tempSales - temp + 5;
    }
    else if (temp <= 9 && temp > 5)
    {
        salesTaxes = tempSales - temp + 10;
    }
    return salesTaxes / 100.00;
}

@end
