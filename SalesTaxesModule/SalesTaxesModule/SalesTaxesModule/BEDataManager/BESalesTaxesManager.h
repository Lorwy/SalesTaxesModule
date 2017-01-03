//
//  BESalesTaxesManager.h
//  SalesTaxesModule
//
//  Created by Lorwy on 2017/1/3.
//  Copyright © 2017年 Lorwy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ProductListCallBack)(NSError * error, NSArray * response);

@interface BESalesTaxesManager : NSObject

- (void)requestProductListWithParam:(id)requestParam
                           callback:(ProductListCallBack) callback;

- (NSArray *)selectProduct;
- (double)salesTaxesValue;
- (double)totalValue;

@end
