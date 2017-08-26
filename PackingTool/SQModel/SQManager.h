//
//  SQManager.h
//  SQPackingTool
//
//  Created by if you on 2017/5/5.
//  Copyright © 2017年 if you. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ SQInitCallback) (NSInteger errorCode, NSString *info);
@interface SQManager : NSObject

+ (SQManager *)shared;

/**
 @brief 初始化SDK。(最先调用，必须调用，建议在程序入口调用)
 
 @param callback 配置回调。
 */
+ (void)initWithCallBack: (SQInitCallback)callback;

@end

@interface SQManager (TalkingDataAppCpa)

/**
 * @brief 处理传入的链接。
 *
 * @param url 链接。
 */
+ (void)onReceiveDeepLink: (NSURL *)url;

@end
