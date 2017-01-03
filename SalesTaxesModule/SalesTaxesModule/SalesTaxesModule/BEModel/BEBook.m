//
//  BEBook.m
//  SalesTaxesModule
//
//  Created by Lorwy on 2017/1/3.
//  Copyright © 2017年 Lorwy. All rights reserved.
//

#import "BEBook.h"

@implementation BEBook


/**
 书是免征收营业税的

 */
- (BEBaseProductBasicSalesType)basicSalesType
{
    return BEBaseProductBasicSalesTypeFree;
}

@end
