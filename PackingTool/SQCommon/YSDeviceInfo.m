//
//  YSDeviceInfo.m
//

#import "YSDeviceInfo.h"
#import "YSUUID.h"
#import <AdSupport/ASIdentifierManager.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <SystemConfiguration/SCNetworkReachability.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <sys/socket.h>
#import "YSNetworkReachability.h"
#import "UKJailbreak.h"


@implementation YSDeviceInfo

+ (NSString *)model {
    
    return [YSUUID deviceType];
}

+ (NSString *)brand {
    
    return @"苹果";
}

+ (NSString *)osVersion {
    
    return [UIDevice currentDevice].systemVersion;
}

+ (NSString *)idfa {
    
    NSString *idfastr = [[ASIdentifierManager sharedManager] advertisingIdentifier].UUIDString;
    return idfastr;
}

+ (NSString *)gameVersion {
    
    return  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)sdkVersion {
    
    return @"1.0.0";
}

+ (NSString *)randomID {

    return [YSUUID UUIDString];
}

+ (NSString *)currentNetwork {

    const char *currentNetType = "无网络";
    
    NSString *netTypeStr = [NSString stringWithUTF8String:currentNetType];
    
    
    //创建零地址，0.0.0.0的地址表示查询本机的网络连接状态
    struct sockaddr_storage zeroAddress;
    
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.ss_len = sizeof(zeroAddress);
    zeroAddress.ss_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    //获得连接的标志
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    //如果不能获取连接标志，则不能连接网络，直接返回
    if (!didRetrieveFlags)
    {
        return netTypeStr;
    }
    
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    if (isReachable && !needsConnection) { }else{
        return netTypeStr;
    }
        
    
    
    
    if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0)
    {
        // if target host is reachable and no connection is required
        // then we'll assume (for now) that your on Wi-Fi
        netTypeStr = @"WIFI";
    }
    
    if (
        ((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||
        (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0
        )
    {
        // ... and the connection is on-demand (or on-traffic) if the
        // calling application is using the CFSocketStream or higher APIs
        if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0)
        {
            // ... and no [user] intervention is needed
            netTypeStr = @"WIFI";
        }
    }
    
    if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN)
    {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        {
            CTTelephonyNetworkInfo * info = [[CTTelephonyNetworkInfo alloc] init];
            NSString *currentRadioAccessTechnology = info.currentRadioAccessTechnology;
            
            if (currentRadioAccessTechnology)
            {
                if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyLTE])
                {
                    netTypeStr =  @"4G";
                }
                else if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyEdge] || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyGPRS])
                {
                    netTypeStr =  @"2G";
                }
                else
                {
                    netTypeStr =  @"3G";
                }
            }
        }
        else
        {
            if((flags & kSCNetworkReachabilityFlagsReachable) == kSCNetworkReachabilityFlagsReachable)
            {
                if ((flags & kSCNetworkReachabilityFlagsTransientConnection) == kSCNetworkReachabilityFlagsTransientConnection)
                {
                    if((flags & kSCNetworkReachabilityFlagsConnectionRequired) == kSCNetworkReachabilityFlagsConnectionRequired)
                    {
                        netTypeStr = @"2G";
                    }
                    else
                    {
                        netTypeStr = @"3G";
                    }
                }
            }
        }
    }
    
    
    if ([netTypeStr isEqualToString:@""]) {
        netTypeStr = @"WWAN";
    }
    
    return netTypeStr;
}

+ (NSString *)isJailbreakDevice {
    
    return [UKJailbreak isJailbreakDevice] ? @"是":@"否";
}

+ (NSString *)isFirstInstall {
    
    return @"";
}

+ (NSString *)gameName {
    
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}

+ (NSString *)gameBundleIdentifier {
    
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}

+ (NSString *)wifiName {
    
    id info = nil;
    NSString *name = @"";
    NSArray *supportedInterfaces = (__bridge_transfer id)CNCopySupportedInterfaces();
    
    if (supportedInterfaces == nil) {
        
        return name;
    }
    
    for (NSString *ifnam in supportedInterfaces) {
        
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        
        if (info[@"SSID"]) {
            
            name = info[@"SSID"];
        }
    }
    
    return name;
}

@end
