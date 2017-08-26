//
//  NSString+Common.m
//

#import "NSString+Common.h"

@implementation NSString(Common)

+ (NSString *)randomStringWithLegnth: (NSInteger)len {
    
    NSString *supportString = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
    char data[len];
    
    for (int index = 0; index < len; data[index++] = [supportString characterAtIndex: arc4random_uniform((uint32_t)supportString.length)]);
    
    return [[NSString alloc] initWithBytes:data length:len encoding:NSUTF8StringEncoding];
}

- (CGFloat)realWidth:(UIFont *)font {
    
    return ceil([self sizeWithAttributes:@{NSFontAttributeName: font}].width);
}

- (CGFloat)realHeight:(UIFont *)font {
    
    return ceil([self sizeWithAttributes:@{NSFontAttributeName: font}].height);
}

- (NSURL *)toURL {
    
    SQLog(@"load: %@",self);
    return [NSURL URLWithString:self];
}

- (NSInteger)ASCIIValue {
    
    NSInteger ASCII = 0;
    
    if (self.length > 0) { } else {
        
        return ASCII;
    }
    
    for (int i=0; i<self.length; i++) {
        
        char ch = [self characterAtIndex:i];
        ASCII += ch;
    }
    
    return ASCII;
}

@end
