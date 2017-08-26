//
//  NSString+YSBundle.m
//

#import "NSString+YSBundle.h"

@implementation NSString(YSBundle)

- (nullable UIImage *)toImage {
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"YSBundle" ofType:@"bundle"];
    NSString *imagePath = [bundlePath stringByAppendingFormat:@"/%@@2x.png",self];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    
    if (__SCREEN_WIDTH == 414 || __SCREEN_HEIGHT == 414) {
        
        imagePath = [bundlePath stringByAppendingFormat:@"/%@@3x.png",self];
        image = [UIImage imageWithContentsOfFile:imagePath];
    }
    
    return image;
}

@end
