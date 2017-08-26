//
//  ARGameCenter.h
//  NewframeWorkDemo
//
//  Created by 0-0 on 2017/5/5.
//  Copyright © 2017年 caixian. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GKLocalPlayer;

@interface ARGameCenter : NSObject

/**
 判断当前系统和设备是否支持game center

 @return YES/NO
 */
- (BOOL)checkGameCenterAvailability;

/**
 登录GameCenter
 不需要处理登录结果
 */
- (void)localGameCenterLogin;

/**
 登录GameCenter
 需要登录结果
 */
- (void)localGameCenterLoginComplihander:(void(^)(GKLocalPlayer *localPlayer, NSError *error))completHander;


@end
