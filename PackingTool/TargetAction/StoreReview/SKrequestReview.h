//
//  SKrequestReview.h
//  GDStoreReview
//
//  Created by ZZL on 2017/4/6.
//  Copyright © 2017年 MOMO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKrequestReview : NSObject
//调取评星功能 注：苹果限制一年只能使用三次，注意调取时机
- (void)Ratings;

//链接跳转功能
//urlStr参数应填入当前app的苹果商店URL,只需要输入https://之后的部分
- (void)deepLinkingToAppStore:(NSString*)urlStr;
@end
