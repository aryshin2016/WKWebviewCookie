//
//  SQManager.m
//  SQPackingTool
//
//  Created by if you on 2017/5/5.
//  Copyright © 2017年 if you. All rights reserved.
//

#import "SQManager.h"

@interface SQManager ()
@property (copy) SQInitCallback initCallBack;

@end

@implementation SQManager

+ (void)initWithCallBack:(SQInitCallback)callback {
    
    [self shared].initCallBack = callback;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [YSNetworkReachability startMonitoring];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidFinishLaunching) name: UIApplicationDidFinishLaunchingNotification object:nil];
    }
    return self;
}

-(void)applicationDidFinishLaunching{
    //配置TD统计参数
    if ([YSKeyManager shared].talkingDataAppCpaAppID && [YSKeyManager shared].talkingDataAppCpaChannelID) {
        
        [TalkingDataAppCpa init:[YSKeyManager shared].talkingDataAppCpaAppID
                  withChannelId:[YSKeyManager shared].talkingDataAppCpaChannelID];
    }
    [self prepare];
}

-(void)prepare{
    //初始化参数
    NSDictionary *params = @{@"game_package_id": @([YSKeyManager shared].gamePackageID),
                             @"appKey":[YSKeyManager shared].appKey,
                             @"gameUrlString":[YSKeyManager shared].gameUrlString,
                             @"random_id":      [YSDeviceInfo randomID],
                             @"idfa":           [YSDeviceInfo idfa],
                             @"brand":          [YSDeviceInfo brand],
                             @"model":          [YSDeviceInfo model],
                             @"net_type":       [YSDeviceInfo currentNetwork],
                             @"game_version":   [YSDeviceInfo gameVersion],
                             @"sdk_version":    [YSDeviceInfo sdkVersion],
                             @"os_version":     [YSDeviceInfo osVersion],
                             @"是否越狱": [YSDeviceInfo isJailbreakDevice]
                             };
    
    SQLog(@"%@",params);
    //发起初始化请求
    [YSNetwork post:[YSHttpAPI initSDK] params:params success:^(id _Nullable responseObject){
        
        YSGameInitConvertModel *gameInitModel = [YSGameInitConvertModel mj_objectWithKeyValues:responseObject];
        
        if (gameInitModel.errorCode == 1) {  } else{
            NSString *errorMsg = [NSString stringWithFormat:@"%d:%@",(int)gameInitModel.errorCode,gameInitModel.errorInfo];
            SQLog(@"初始化失败:%@",errorMsg);
        }
        self.initCallBack(gameInitModel.errorCode, gameInitModel.errorInfo);
        //初始化成功说明网络没问题，移除监听网络变化的通知
        [[NSNotificationCenter defaultCenter] removeObserver:self name:YSNetworkingReachabilityDidChangeNotification object:nil];
    }failure:^(NSError * _Nonnull error){
        
        //[[[UIAlertView alloc] initWithTitle:@"初始化失败" message:@"1、设备当前网络不畅通\n2、游戏无网络访问权限\n3、可尝试重新进入游戏" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil] show];
        SQLog(@"初始化SDK失败%@", error);
        //由于网络原因初始化失败，添加网络变化的通知，当网络发生变化则重新请求
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(prepare) name:YSNetworkingReachabilityDidChangeNotification object:nil];
        self.initCallBack(0, nil);
    }];
}

#pragma mark -初始化

+ (SQManager *)shared {
    
    if ([YSKeyManager shared].appKey.length > 0 && [YSKeyManager shared].gamePackageID > 0) { } else {
        
        @throw [NSException exceptionWithName:@"必须传appKey和gamePackageID" reason:@"" userInfo:nil];
    }
    
    static SQManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[SQManager alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark -移除观察者
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidFinishLaunchingNotification object:nil];
    [YSNetworkReachability stopMonitoring];
    SQLog(@"dealloc");
}

@end

@implementation SQManager (TalkingDataAppCpa)

+ (void)onReceiveDeepLink: (NSURL *)url {
    
    [TalkingDataAppCpa onReceiveDeepLink:url];
}

@end
