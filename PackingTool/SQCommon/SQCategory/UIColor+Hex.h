//
//  UIColor+Hex.h
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

UIKIT_EXTERN  UIColor * __nullable UIColorFromRGB(CGFloat R, CGFloat G, CGFloat B);
UIKIT_EXTERN  UIColor * __nullable UIColorFromRGBA(CGFloat R, CGFloat G, CGFloat B, CGFloat alpha);
UIKIT_EXTERN  UIColor * __nullable UIColorFromHexValue(NSUInteger hexValue);   // e.g. 0xDDFFEE

