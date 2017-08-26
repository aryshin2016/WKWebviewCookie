//
//  YSDeviceInfo.h
//

#import <Foundation/Foundation.h>

@interface YSDeviceInfo : NSObject

+ (NSString *)model;            // 手机型号
+ (NSString *)brand;            // 手机品牌
+ (NSString *)osVersion;        // 手机系统版本
+ (NSString *)idfa;             // 获取idfa
+ (NSString *)randomID;         // 随机ID
+ (NSString *)gameVersion;      // 游戏版本号
+ (NSString *)sdkVersion;       // SDK版本号
+ (NSString *)currentNetwork;   // 获取网络类型
+ (NSString *)isJailbreakDevice;// 是否是越狱设备
+ (NSString *)isFirstInstall;   //是否第一次安装

+ (NSString *)wifiName;
+ (NSString *)gameName;
+ (NSString *)gameBundleIdentifier;

@end
