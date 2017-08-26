//
//  UIDevice+version.m
//

#import "UIDevice+Version.h"

@implementation UIDevice(Version)

+ (NSInteger)systemVersion {
    
    // NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1
    NSArray *vers = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    if (vers.count == 3) {
        
        return [vers[0] integerValue]*10000 +  [vers[1] integerValue]*100 + [vers[2] integerValue];
    }
    return [vers[0] integerValue]*10000 +  [vers[1] integerValue]*100;
}


+ (BOOL)isSimulator {

   return [[UIDevice currentDevice].model hasSuffix:@"Simulator"];
}

@end
