//
//  YSUUID.m
//

#import "YSUUID.h"
#import <sys/sysctl.h>
#import "AMDKeyChain.h"

#define YSUNION_UUID_KEY @"YSUnioUUIDKey"

@implementation YSUUID

+ (NSString *)UUIDString {
    
    NSData *data = [AMDKeyChain loadKey:YSUNION_UUID_KEY];
    if ([[YSUUID deviceType] isEqualToString:@"x86_64"]) {
    
        data = [[NSUserDefaults standardUserDefaults] objectForKey:YSUNION_UUID_KEY];
    }
    
    if (data) {
        
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    
    return [self createUUID];
}

+ (NSString *)createUUID {
    
    NSString *uuid = [UIDevice currentDevice].identifierForVendor.UUIDString;
    [AMDKeyChain saveData:[uuid dataUsingEncoding:NSUTF8StringEncoding] forKey:YSUNION_UUID_KEY];
    
    if ([[YSUUID deviceType] isEqualToString:@"x86_64"]) {
        
        [[NSUserDefaults standardUserDefaults] setObject:[uuid dataUsingEncoding:NSUTF8StringEncoding] forKey:YSUNION_UUID_KEY];
    }
    
    return uuid;
}

+ (NSString *)deviceType {
    
    size_t len = 16;
    char *machine = (char *)malloc(len);
    
    sysctlbyname([@"hw.machine" cStringUsingEncoding:NSUTF8StringEncoding], machine, &len, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    
    free(machine);
    return platform;
}

@end
