//
//  UIImage+AspectRatio.m
//

#import "UIImage+AspectRatio.h"

@implementation UIImage(AspectRatio)

- (CGFloat)aspectRatio {
    
    if (self) {
        
        return self.size.width/self.size.height;
    }
    
    return 0;
}

- (CGFloat)inverseAspectRatio {
    
    if (self) {
        
        return self.size.height/self.size.width;
    }
    
    return 0;
}

- (CGFloat)width {
    
    return self.size.width;
}

- (CGFloat)height {
    
    return self.size.height;
}

+ (UIImage *)imageFromColor: (UIColor *)color withSize:(CGSize)size {
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageFromHexColor: (NSUInteger)hexColor withSize:(CGSize)size {
    
    return [self imageFromColor:UIColorFromHexValue(hexColor) withSize:size];
}
@end
