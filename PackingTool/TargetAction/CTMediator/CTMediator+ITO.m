//
//  CTMediator+ITO.m
//  itoDemo
//
//  Created by itogame on 2017/7/3.
//  Copyright © 2017年 itogame. All rights reserved.
//

#import "CTMediator+ITO.h"

@implementation CTMediator (ITO)

+ (void)ITO_ReceiptValidation:(NSString*)receiptString {
    NSString *targetName = @"YSReceiptValidation";
    NSString *actionName = @"ysReceiptValidation:";
    id params = receiptString;
    [self performTarget:targetName action:actionName params:params];
}

// 本地组件调用入口
+ (void)performTarget:(NSString *)targetName action:(NSString *)actionName params:(id)params {
    
}

@end
