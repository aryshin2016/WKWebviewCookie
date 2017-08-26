//
//  YSBaseConvertModel.h
//

#import <Foundation/Foundation.h>

@interface YSBaseConvertModel : NSObject

@property (nonatomic, assign) NSInteger errorCode;                      //!< 错误码
@property (nonatomic, copy, nullable) NSString *errorInfo;              //!< 错误信息
@property (nonatomic, copy, nullable) NSDictionary *data;               //!< 数据

@end
