//
//  YSNetwork.h
//

#import <Foundation/Foundation.h>
#import "YSHttpAPI.h"

typedef void (^YSRequestSuccessBlock)(id _Nullable responseObject);
typedef void (^YSRequestFailureBlock)( NSError * _Nonnull error);

@interface YSNetwork : NSObject

/**
 @brief post网络请求
 
 @param api 为接口，params为body，YSRequestSuccessBlock为请求成功回调，YSRequestFailureBlock为请求失败回调
 */
+ (void)post:(YSHttpAPI * _Nonnull)api params:(NSDictionary * _Nullable)params success:(YSRequestSuccessBlock _Nullable)success failure:(YSRequestFailureBlock _Nullable)failure;

@end
