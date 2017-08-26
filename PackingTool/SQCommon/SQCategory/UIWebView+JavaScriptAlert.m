//
//  UIWebView+JavaScriptAlert.m
//  WebDemo
//
//  Created by Harvey on 2016/9/29.
//  Copyright © 2016年 Harvey. All rights reserved.
//

#import "UIWebView+JavaScriptAlert.h"
#import <objc/runtime.h>

const void *JSAlertDelegate = "JavaScriptAlertDelegate";

@implementation UIWebView(JavaScriptAlert)

- (void)webView:(UIWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame {
    
    [[self getJSDelegate] webView:webView runJavaScriptAlertPanelWithMessage:message];
}

- (void)setJSDelegate:(id<JavaScriptAlertDelegate>)jsDelegate {
    
    objc_setAssociatedObject(self, JSAlertDelegate, jsDelegate, OBJC_ASSOCIATION_ASSIGN);
}

- (id<JavaScriptAlertDelegate>)getJSDelegate {
    
    return objc_getAssociatedObject(self, JSAlertDelegate);
}

@end
