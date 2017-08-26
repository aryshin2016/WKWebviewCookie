//
//  UIImage+AspectRatio.h
//

#import <Foundation/Foundation.h>

@interface UIImage(AspectRatio)

@property (assign, readonly) CGFloat aspectRatio;           // 宽:高
@property (assign, readonly) CGFloat inverseAspectRatio;    // 高:宽

@property (assign, readonly) CGFloat width;
@property (assign, readonly) CGFloat height;


+ (UIImage *)imageFromColor: (UIColor *)color withSize:(CGSize)size;
+ (UIImage *)imageFromHexColor: (NSUInteger)hexColor withSize:(CGSize)size;

@end
