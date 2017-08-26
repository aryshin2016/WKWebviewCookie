//
//  YSStorager.h
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YSStorager : NSObject

// 是否存在校验支付凭证
+ (BOOL)isExistVerifyPruchase;
+ (void)removeVerifyPruchaseWithOrderID: (NSString *)orderID;
+ (void)addVerifyPruchase:(NSDictionary *)params withOrderID: (NSString *)orderID;
+ (NSDictionary *)verifyPruchase;

@end

NS_ASSUME_NONNULL_END
