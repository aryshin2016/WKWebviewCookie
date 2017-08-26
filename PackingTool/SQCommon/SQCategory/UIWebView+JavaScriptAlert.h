//
//  UIWebView+JavaScriptAlert.h
//  WebDemo
//
//  Created by Harvey on 2016/9/29.
//  Copyright © 2016年 Harvey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol JavaScriptAlertDelegate<NSObject>

@optional
- (void)webView:(UIWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message;

@end


@interface UIWebView (JavaScriptAlert)

- (void)webView:(UIWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString * _Nullable)message initiatedByFrame:(id _Nullable)frame;
- (void)setJSDelegate:(id)jsDelegate;

@end

NS_ASSUME_NONNULL_END
