//
//  UIImage+ZH.h
//  BaiSiJie
//
//  Created by aryshin2016 on 16/9/18.
//  Copyright © 2016年 aryshin2016. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZH)
/**
 *  根据图片名称创建原始图片（不渲染）
 *
 *  @param imageName 图片名称
 *
 *  @return 原始图片
 */
+ (UIImage *)zh_originalImageWithName:(NSString *)imageName;

@end
