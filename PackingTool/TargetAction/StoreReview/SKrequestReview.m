//
//  SKrequestReview.m
//  GDStoreReview
//
//  Created by ZZL on 2017/4/6.
//  Copyright © 2017年 MOMO. All rights reserved.
//

#import "SKrequestReview.h"
@import StoreKit;
#define sysVersions [[[UIDevice currentDevice] systemVersion] doubleValue]

@implementation SKrequestReview

//评星方法
- (void)Ratings {
    //该功能需系统10.3之后才有效
    if (sysVersions >= 10.3) {
        [SKStoreReviewController requestReview];
    }else{
        NSLog(@"系统版本小于10.3 方法无效");
    }
}

//链接跳转方法 注:因为模拟器没有app商店,所以跳转效果需要真机运行测试
- (void)deepLinkingToAppStore:(NSString *)urlStr{
    NSString *scheme = @"itms-apps";
    if (TARGET_OS_SIMULATOR) {
        NSLog(@"是模拟器运行的");
        scheme = @"https";
    }
    //拼接app地址
    NSString *url = [NSMutableString stringWithFormat:@"%@://%@&action=write-review",scheme,urlStr];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *appUrl = [NSURL URLWithString:url];
    NSLog(@"转URL之前的string=%@\n拼接后url地址:%@",urlStr,url);
    
    //判断地址是否有效
    if ([[UIApplication sharedApplication] canOpenURL:appUrl]) {
        //ios10之后方法有所改变,做出判断
        if (sysVersions >= 10.0) {
            [[UIApplication sharedApplication]openURL:appUrl options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES} completionHandler:^(BOOL success) {
                if (!success) {
                }
            }];
        }else{
            //兼容ios10之前的方法
            [[UIApplication sharedApplication]openURL:appUrl];
        }
    }else{
        NSLog(@"地址无效不跳转");
    }
}

@end
