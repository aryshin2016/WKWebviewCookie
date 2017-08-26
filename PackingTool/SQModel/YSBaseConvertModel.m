//
//  YSBaseConvertModel.m
//

#import "YSBaseConvertModel.h"

@implementation YSBaseConvertModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{
             @"data":       @"data",
             @"errorCode":  @"errno",
             @"errorInfo":  @"msg"
             };
}

@end
