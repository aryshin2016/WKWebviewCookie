//
//  Global+Queue.m
//

#import "Global+Queue.h"
//#import "YSLog.h"

void dispatch_main_queue_execute(void (^block)()) {
    
    dispatch_async(dispatch_get_main_queue(), block);
}

void dispatch_main_queue_after_execute(NSTimeInterval duration, void (^block)()) {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        
        block();
    });
}

void dispatch_global_queue_after_execute(NSTimeInterval duration, void (^block)()) {
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration*NSEC_PER_SEC), globalQueue, ^{
        
        block();
    });
}

void dispatch_timer_create(NSTimeInterval interval, void (^actionBlock)(void (^invalidateBlock)())) {
    
    // 全局队列
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,globalQueue);
    dispatch_source_set_timer(timer,dispatch_walltime(NULL, 0),interval*NSEC_PER_SEC, 0); // 间隔interval执行一次
    
    void (^invalidateBlock)() = ^ {
        
        dispatch_source_cancel(timer);
        SQLog(@"取消定时器");
    };
    
    dispatch_source_set_event_handler(timer, ^{
        
        actionBlock(invalidateBlock);
    });
    dispatch_resume(timer);
}
