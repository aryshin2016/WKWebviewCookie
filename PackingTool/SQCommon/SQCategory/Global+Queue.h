//
//  Global+Queue.h
//

#import <Foundation/Foundation.h>

// async
UIKIT_EXTERN void dispatch_main_queue_execute(void (^block)());

/**
 延迟执行
 
 @param duration 延迟多少秒
 @param block  事件block
 */
UIKIT_EXTERN void dispatch_main_queue_after_execute(NSTimeInterval duration, void (^block)());
UIKIT_EXTERN void dispatch_global_queue_after_execute(NSTimeInterval duration, void (^block)());

/**
 创建一个定时器
 
 @param interval     间隔时间(秒)
 @param actionBlock do something
 */
UIKIT_EXTERN void dispatch_timer_create(NSTimeInterval interval, void (^actionBlock)(void (^invalidateBlock)()));
