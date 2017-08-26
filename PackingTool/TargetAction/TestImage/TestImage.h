//
//  TestImage.h
//  Pods
//
//  Created by zhouhavey on 2017/5/3.
//
//

#import <Foundation/Foundation.h>
#import "UIImage+named.h"

@interface TestImage : NSObject

- (UIImage *)loadPic;

+ (UIImage *)ar_imageNamed:(NSString *)name;

@end
