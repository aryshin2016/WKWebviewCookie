//  YSLog.h
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Config.h"

#define Console(fmt, ...) printf("%s %s ###Log %s\n", [CurrentDateString() UTF8String], [[NSString stringWithFormat:@"%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:kCFBundleExecutableKey]] UTF8String],  [[NSString stringWithFormat:fmt, ## __VA_ARGS__] UTF8String])

#ifdef DEBUG
#define SQLog(fmt, ...) printf("%s %s [line %d] ###Log %s\n", [CurrentDateString() UTF8String], [[[[NSString alloc] initWithUTF8String:__FILE__] componentsSeparatedByString:@"/"].lastObject UTF8String], __LINE__,  [[NSString stringWithFormat:fmt, ## __VA_ARGS__] UTF8String])
#else
#define SQLog(fmt, ...) 
#endif


NS_INLINE NSString *CurrentDateString() {
  
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MM-dd HH:mm:ss";

    return [formatter stringFromDate:[NSDate date]];
};
