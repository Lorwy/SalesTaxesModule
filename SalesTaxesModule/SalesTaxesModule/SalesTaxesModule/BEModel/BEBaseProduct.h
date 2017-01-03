//
//  BEBaseProduct.h
//  SalesTaxesModule
//
//  Created by Lorwy on 2016/12/30.
//  Copyright © 2016年 Lorwy. All rights reserved.
//

#import <JSONModel/JSONModel.h>

typedef NS_ENUM(NSInteger, BEBaseProductType)
{
    BEBaseProductTypeDefuat = 0 , /**< 普通商品（非进口） */
    BEBaseProductTypeImport = 1, /**< 进口商品  */
};

typedef NS_ENUM(NSInteger, BEBaseProductBasicSalesType)
{
    BEBaseProductBasicSalesTypeDefuat = 0 , /**< 要征收营业税的 */
    BEBaseProductBasicSalesTypeFree = 1, /**< 书籍、食品、医疗产品类型不征收营业税  */
};

@interface BEBaseProduct : JSONModel

@property (nonatomic, copy) NSString *name; /**< 物品名称 */
@property (nonatomic, assign) double price; /**< 商品价格 */
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, assign) NSInteger buyCount; /**< 购买的商品数量，默认为0 */

@property (nonatomic, assign) BEBaseProductType productType; /**< 商品类型（进口或非进口） */
@property (nonatomic, readonly) float importDuty; /**< 进口税 */

@property (nonatomic, assign) BEBaseProductBasicSalesType basicSalesType;
@property (nonatomic, readonly) float basicSales; /**< 基础营业税 */

- (double)salesTaxes;

@end
