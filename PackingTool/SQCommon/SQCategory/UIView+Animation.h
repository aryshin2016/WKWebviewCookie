//
//  UIView+Animation.h
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView(Animation)

// 设置该属性后自动开始(使用弱引用 ### 重要 ### )
@property (nonatomic, copy, nullable) void (^doAnimationBlock)(BOOL finished); // 动画

@end
