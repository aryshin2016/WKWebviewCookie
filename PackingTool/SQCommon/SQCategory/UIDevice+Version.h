//
//  UIDevice+version.h
//

#import <Foundation/Foundation.h>

@interface UIDevice(Version)

+ (NSInteger)systemVersion;
+ (BOOL)isSimulator;

@end
