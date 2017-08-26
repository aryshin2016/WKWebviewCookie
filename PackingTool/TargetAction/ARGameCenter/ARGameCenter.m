//
//  ARGameCenter.m
//  NewframeWorkDemo
//
//  Created by 0-0 on 2017/5/5.
//  Copyright © 2017年 caixian. All rights reserved.
//

#import "ARGameCenter.h"
#import <UIKit/UIKit.h>
@import GameKit;

@implementation ARGameCenter

- (BOOL)checkGameCenterAvailability {

    // First, check if the the GameKit Framework exists on the device. Return NO if it does not.
    BOOL localPlayerClassAvailable = (NSClassFromString(@"GKLocalPlayer")) != nil;
    NSString *reqSysVer = @"4.1";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    BOOL osVersionSupported = ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending);
    return (localPlayerClassAvailable && osVersionSupported);
}

-(void)localGameCenterLogin {
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    localPlayer.authenticateHandler = ^(UIViewController * viewController, NSError * error) {
        if (error) {
            NSLog(@"GameCenter失败错误<<<<<<<<<<<%@",error);
        }else {
            //
            if (![GKLocalPlayer localPlayer].authenticated) {
                NSLog(@"1--alias--.%@",[GKLocalPlayer localPlayer].alias);
                NSLog(@"2--authenticated--.%d",[GKLocalPlayer localPlayer].authenticated);
                NSLog(@"3--isFriend--.%d",[GKLocalPlayer localPlayer].isFriend);
                NSLog(@"4--playerID--.%@",[GKLocalPlayer localPlayer].playerID);
                NSLog(@"5--underage--.%d",[GKLocalPlayer localPlayer].underage);
                // 没有授权
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:viewController animated:YES completion:^{
                    
                }];
            }else{// 已经授权
                NSLog(@"a--alias--.%@",[GKLocalPlayer localPlayer].alias);
                NSLog(@"b--authenticated--.%d",[GKLocalPlayer localPlayer].authenticated);
                NSLog(@"c--isFriend--.%d",[GKLocalPlayer localPlayer].isFriend);
                NSLog(@"d--playerID--.%@",[GKLocalPlayer localPlayer].playerID);
                NSLog(@"e--underage--.%d",[GKLocalPlayer localPlayer].underage);
  
            }
            
        }
    };
}

- (void)localGameCenterLoginComplihander:(void(^)(GKLocalPlayer *localPlayer, NSError *error))completHander {
   __weak GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    localPlayer.authenticateHandler = ^(UIViewController * viewController, NSError * error) {
        if (error) {
            NSLog(@"GameCenter失败错误<<<<<<<<<<<%@",error);
        }else {
            //
            if (![GKLocalPlayer localPlayer].authenticated) {
                NSLog(@"1--alias--.%@",[GKLocalPlayer localPlayer].alias);
                NSLog(@"2--authenticated--.%d",[GKLocalPlayer localPlayer].authenticated);
                NSLog(@"3--isFriend--.%d",[GKLocalPlayer localPlayer].isFriend);
                NSLog(@"4--playerID--.%@",[GKLocalPlayer localPlayer].playerID);
                NSLog(@"5--underage--.%d",[GKLocalPlayer localPlayer].underage);
                // 没有授权
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:viewController animated:YES completion:^{
                    
                }];
            }else{// 已经授权
                NSLog(@"a--alias--.%@",[GKLocalPlayer localPlayer].alias);
                NSLog(@"b--authenticated--.%d",[GKLocalPlayer localPlayer].authenticated);
                NSLog(@"c--isFriend--.%d",[GKLocalPlayer localPlayer].isFriend);
                NSLog(@"d--playerID--.%@",[GKLocalPlayer localPlayer].playerID);
                NSLog(@"e--underage--.%d",[GKLocalPlayer localPlayer].underage);
                
            }
            
        }
        // 处理登录结果的block
        completHander(localPlayer, error);
    };
}


@end
