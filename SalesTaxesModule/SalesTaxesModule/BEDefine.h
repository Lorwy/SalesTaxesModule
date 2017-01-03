//
//  BEDefine.h
//  SalesTaxesModule
//
//  Created by Lorwy on 2017/1/3.
//  Copyright © 2017年 Lorwy. All rights reserved.
//

#ifndef BEDefine_h
#define BEDefine_h

#define weakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o
#define strongObj(o) autoreleasepool{} __strong typeof(o) o = o##Weak

#endif /* BEDefine_h */
