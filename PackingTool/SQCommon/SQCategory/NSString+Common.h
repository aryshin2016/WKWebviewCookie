//
//  NSString+Common.h
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString(Common)

+ (NSString *)randomStringWithLegnth: (NSInteger)len;
- (nullable NSURL *)toURL;
- (CGFloat)realWidth:(UIFont *)font;
- (CGFloat)realHeight:(UIFont *)font;
- (NSInteger)ASCIIValue;

@end

NS_ASSUME_NONNULL_END
