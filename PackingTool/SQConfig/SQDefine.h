//
//  SQDefine.h
//  SQPackingTool
//
//  Created by if you on 2017/5/5.
//  Copyright © 2017年 if you. All rights reserved.
//

#ifndef SQDefine_h
#define SQDefine_h

#pragma mark - ########## 常用宏定义 ##########
#define __SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)        // 获取屏幕宽度
#define __SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)      // 获取屏幕高度
#define __IPHONE_CURRENT [UIDevice systemVersion]                       // 获取系统版本


#pragma mark - ########## API地址 ##########
#define  InitSDKParam           @"game/init?sign="                      // 初始化SDK

#pragma mark - ########## 悬浮按钮相关 ##########
#define YS_LEVITATE_BUTTON_WIDTH  51                                    // 悬浮按钮宽
#define YS_LEVITATE_BUTTON_HEIGHT 51                                    // 悬浮按钮高
#define YS_LEVITATE_BAR_ITEM_WIDTH 40                                   // 悬浮条里的按钮宽度
#define YS_LEVITATE_BAR_ITEM_LAST_MARGIN 0                              // 悬浮条里排在最后的一个按钮距离父视图的的空隙
#define YS_LEVITATE_BAR_ITEM_DOTTED_COLOR   [UIColor whiteColor]        // 悬浮条里按钮之间的虚线颜色
#define YS_LEVITATE_BAR_ITEM_DOTTED_HEIGHT  20                          // 悬浮条里按钮之间的虚线高度
#define YS_LEVITATE_BAR_BACKGROUND_COLOR   UIColorFromHexValue(0xf0f0f0)// 悬浮条背景颜色
#define YS_HIDDEN_WINDOW_TIMER 5                                        // 无操作多少秒后将悬浮按钮隐藏一半


#pragma mark - ########## 屏幕旋转相关 ##########
#define YS_DID_ROTATE_FROM_INTERFACE_ORIENTATION @"didRotateFromInterfaceOrientation"   // 视图旋转完成
#define YS_WILL_ROTATE_TO_INTERFACE_ORIENTATION  @"willRotateToInterfaceOrientation"    // 视图即将旋转
#define YS_WILL_ANIMATE_ROTATION_TO_INTERFACE_ORIENTATION @"willAnimateRotationToInterfaceOrientation" // 视图即将开始旋转动画

#pragma mark - ########## UI相关宏定义 ##########
#define COMMON_COLOR_BACKGROUND                 UIColorFromHexValue(0xf0f0f0)   // 主要的背景颜色
#define COMMON_COLOR_BACKGROUND_1               [UIColor whiteColor]            // 背景颜色
#define COMMON_COLOR_BACKGROUND_NAVIGATIONBAR   UIColorFromRGB(255, 155, 45)    // 导航栏的背景颜色
#define COMMON_COLOR_PLACEHOLDER                UIColorFromHexValue(0x999999)   // 占位文字颜色
#define COMMON_COLOR_TEXT_INPUT                 UIColorFromHexValue(0x333333)   // 输入文字颜色
#define COMMON_COLOR_TEXT                       [UIColor whiteColor]            // 一般文本字颜色
#define COMMON_COLOR_TEXT_1                     UIColorFromHexValue(0xff9900)   // 文本颜色
#define COMMON_COLOR_TEXT_2                     UIColorFromHexValue(0x999999)   // 文本颜色
#define COMMON_COLOR_BORDER                     UIColorFromHexValue(0xcccccc)   // 边框颜色
#define COMMON_COLOR_BACKGROUND_BUTTON_NORMAL   UIColorFromHexValue(0x33cc00)   // 按钮正常背景颜色
#define COMMON_COLOR_BACKGROUND_BUTTON_HIGHLIGHTED UIColorFromHexValue(0x339900)// 按钮高亮背景颜色

#define COMMON_FONT_LARGER              [UIFont systemFontOfSize:20]    // 特殊情况用这个
#define COMMON_FONT_LARGE               [UIFont systemFontOfSize:18]    // 一般用于标题
#define COMMON_FONT_MIDDLE              [UIFont systemFontOfSize:16]    // 一般用于按钮
#define COMMON_FONT_SMALL               [UIFont systemFontOfSize:14]    // 太多数情况下用这个
#define COMMON_FONT_SMALLER             [UIFont systemFontOfSize:12]    // 特殊情况用这个

#define COMMON_WIDTH_BORDER             1.0                             // borderWidth
#define COMMON_RADIUS_CORNER            5.0


#pragma mark - ########## 其他 ##########
#define YS_REQUEST_TIMEOUTINTERVAL 60                                   // 网络超时
//#define self.navigationbarHeight 44                                      // navigationbar 高度



#endif /* SQDefine_h */
