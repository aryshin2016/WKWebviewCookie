//
//  SQHttpApi.h
//  SQPackingTool
//
//  Created by if you on 2017/5/5.
//  Copyright © 2017年 if you. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YSHttpAPI : NSObject

@property (nonatomic, copy, readonly) NSString *baseURL;
@property (nonatomic, copy, readonly) NSString *path;

/**
 初始化SDK Api
 
 @return YSHttpAPI实例
 */
+ (instancetype)initSDK;


@end

NS_ASSUME_NONNULL_END
