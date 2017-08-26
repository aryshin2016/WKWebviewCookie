//
//  YSNetworkReachability.h
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

FOUNDATION_EXPORT NSString * const YSNetworkingReachabilityDidChangeNotification;

typedef NS_ENUM(NSInteger, YSNetworkReachabilityStatus) {

    YSNetworkReachabilityUnknown = -1,
    YSNetworkReachabilityNotReachable  = 0,
    YSNetworkReachabilityReachableViaWWAN = 1,
    YSNetworkReachabilityReachableViaWiFi = 2,
    YSNetworkReachabilityReachableVia2G = 3,
    YSNetworkReachabilityReachableVia3G = 4,
    YSNetworkReachabilityReachableVia4G = 5
};


@interface YSNetworkReachability : NSObject

@property (assign) YSNetworkReachabilityStatus networkReachabilityStatus;

+ (void)startMonitoring;
+ (void)stopMonitoring;

+ (YSNetworkReachability *)share;
- (NSString *)reachabilityStatusString;

@end
