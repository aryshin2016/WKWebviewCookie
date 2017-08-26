//
//  UIView+Animation.m
//

#import "UIView+Animation.h"

@implementation UIView(Animation)

@dynamic doAnimationBlock;

- (void)setDoAnimationBlock:(void (^)(BOOL))doAnimationBlock {
    
    dispatch_main_queue_execute(^{
        
        [UIView animateWithDuration:0.65 animations:^{
            
            doAnimationBlock(false);
        } completion:^(BOOL finished) {
            
            doAnimationBlock(finished);
        }];
    });
}

@end
