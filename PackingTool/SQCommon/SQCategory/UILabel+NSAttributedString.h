//
//  UILabel+NSAttributedString.h
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UILabel(NSAttributedString)

/**
 加注颜色

 @param color 颜色
 @param font  字体
 @param index 从哪个下标开始(不包含index)
 */
- (void)conspicuousWithColor: (UIColor *)color font: (UIFont *)font from:(NSInteger)index;
- (void)addUnderlineWithColor: (UIColor *)color font: (UIFont *)font from:(NSInteger)index;

@end
