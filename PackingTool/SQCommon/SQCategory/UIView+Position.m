//
//  UIView+Position.m
//

#import "UIView+Position.h"
#import <UIKit/UIKit.h>

@implementation UIView (Position)

- (CGFloat)left {
    
    return self.frame.origin.x;
}

- (CGFloat)right {
 
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)top {
    
    return self.frame.origin.y;
}

- (CGFloat)bottom {
    
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)width {
    
    return self.frame.size.width;
}

- (CGFloat)height {

    return self.frame.size.height;
}

@end
