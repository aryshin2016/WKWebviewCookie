//
//  UIImage+ZH.m
//  BaiSiJie
//
//  Created by aryshin2016 on 16/9/18.
//  Copyright © 2016年 aryshin2016. All rights reserved.
//

#import "UIImage+ZH.h"

@implementation UIImage (ZH)

+ (UIImage *)zh_originalImageWithName:(NSString *)imageName {
   UIImage *originalImage = [UIImage imageNamed:imageName];
    originalImage = [originalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return originalImage;
}

@end
