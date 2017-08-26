//
//  YSNetworkReachability.m
//

#import "YSNetworkReachability.h"
@import CoreTelephony;

NSString * const YSNetworkingReachabilityDidChangeNotification = @"YSNetworkingReachabilityDidChangeNotification";

@interface YSNetworkReachability ()

@property (strong) AFNetworkReachabilityManager *reachabilityManager;
@property (strong) CTTelephonyNetworkInfo *telephonyNetworkInfo;

@end

@implementation YSNetworkReachability

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        self.telephonyNetworkInfo = [[CTTelephonyNetworkInfo alloc] init];
        self.reachabilityManager = [AFNetworkReachabilityManager sharedManager];
        self.networkReachabilityStatus = YSNetworkReachabilityUnknown;
        
        __weak __typeof(self) weakSelf = self;
        [weakSelf.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            YSNetworkReachabilityStatus _status = (YSNetworkReachabilityStatus)status;
            if (status == AFNetworkReachabilityStatusReachableViaWWAN) {
                
                _status = [weakSelf currentRadioAccessTechnology];
            }else {
                
               _status = (YSNetworkReachabilityStatus)status;
            }
            
            if (self.networkReachabilityStatus != _status) { } else{
                
                return;
            }
            
            self.networkReachabilityStatus = _status;
            [[NSNotificationCenter defaultCenter] postNotificationName:YSNetworkingReachabilityDidChangeNotification object:@(_status)];
            SQLog(@"networkReachability=%@", [weakSelf reachabilityStatusString]);
        }];
    }
    
    return self;
}

+ (YSNetworkReachability *)share {
    
    static YSNetworkReachability *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        if (!sharedInstance) {
            
            sharedInstance = [[YSNetworkReachability alloc] init];
        }
    });
    
    return sharedInstance;
}

+ (void)stopMonitoring {
    
    [[self share].reachabilityManager stopMonitoring];
}

+ (void)startMonitoring {
    
    [[self share].reachabilityManager startMonitoring];
}

- (NSString *)reachabilityStatusString {
    
    switch (self.networkReachabilityStatus) {
            
        case YSNetworkReachabilityUnknown:
            return @"Unknown";
            break;
            
        case YSNetworkReachabilityNotReachable:
            return @"NotReachable";
            break;
            
        case YSNetworkReachabilityReachableViaWWAN:
            return @"WWAN";
            break;
            
        case YSNetworkReachabilityReachableViaWiFi:
            return @"WiFi";
            break;
            
        case YSNetworkReachabilityReachableVia2G:
            return @"2G";
            break;
            
        case YSNetworkReachabilityReachableVia3G:
            return @"3G";
            break;
            
        case YSNetworkReachabilityReachableVia4G:
            return @"4G";
            break;
            
        default:
            return @"";
            break;
    }
}

- (YSNetworkReachabilityStatus)currentRadioAccessTechnology {
    
    NSString *radioAccessTechnology = self.telephonyNetworkInfo.currentRadioAccessTechnology;
    if ([radioAccessTechnology isEqualToString: CTRadioAccessTechnologyGPRS] ||
        [radioAccessTechnology isEqualToString: CTRadioAccessTechnologyEdge] ||
        [radioAccessTechnology isEqualToString:  CTRadioAccessTechnologyCDMA1x]) {
        
        return YSNetworkReachabilityReachableVia2G;
    }
    
    if ([radioAccessTechnology isEqualToString: CTRadioAccessTechnologyWCDMA] ||
        [radioAccessTechnology isEqualToString: CTRadioAccessTechnologyHSDPA] ||
        [radioAccessTechnology isEqualToString: CTRadioAccessTechnologyHSUPA] ||
        [radioAccessTechnology isEqualToString: CTRadioAccessTechnologyCDMAEVDORev0] ||
        [radioAccessTechnology isEqualToString: CTRadioAccessTechnologyCDMAEVDORevA] ||
        [radioAccessTechnology isEqualToString: CTRadioAccessTechnologyCDMAEVDORevB] ||
        [radioAccessTechnology isEqualToString: CTRadioAccessTechnologyeHRPD]) {
        
        return YSNetworkReachabilityReachableVia3G;
    }
    
    if ([radioAccessTechnology isEqualToString: CTRadioAccessTechnologyLTE]) {
        
       return YSNetworkReachabilityReachableVia4G;
    }
    
    return YSNetworkReachabilityReachableViaWWAN;
}

@end
