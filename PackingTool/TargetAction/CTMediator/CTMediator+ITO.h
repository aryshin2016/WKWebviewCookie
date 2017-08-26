//
//  CTMediator+ITO.h
//  itoDemo
//
//  Created by itogame on 2017/7/3.
//  Copyright © 2017年 itogame. All rights reserved.
//

#import "CTMediator.h"

@interface CTMediator (ITO)

+ (void)ITO_ReceiptValidation:(NSString*)receiptString;

// 本地组件调用入口
+ (void)performTarget:(NSString *)targetName action:(NSString *)actionName params:(id)params;

@end
