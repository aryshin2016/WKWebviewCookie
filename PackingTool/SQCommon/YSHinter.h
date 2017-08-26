//
//  YSHinter.h
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YSHinter : NSObject

// 设置提示窗口关闭后回调，并立刻执行关闭提示窗口操作（一般用与showLoadingToast配对使用）
+ (void)hiddenHinterWithCompletionBlock: (void (^)())completionBlock;

/// 将正在显示的Hinter隐藏
+ (void)hiddenHinter;

@end


@interface NSString(Hinter)

/**
 显示一个提示
 */
- (void)showToast;

/**
 显示一个提示

 @param completionBlock 提示隐藏后回调
 */
- (void)showToastWithCompletionBlock:(void (^)())completionBlock;

/**
 显示一个加载提示
 */
- (void)showLoadingToast;

/**
 显示一个加载提示

 @param completionBlock 提示隐藏后回调
 */
- (void)showLoadingToastWithCompletionBlock:(void (^)())completionBlock;

- (void)showAlertViewWithTitle: (NSString *)title;

@end

NS_ASSUME_NONNULL_END
