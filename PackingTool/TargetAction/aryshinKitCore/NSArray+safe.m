//
//  NSArray+safe.m
//  Pods
//
//  Created by 0-0 on 2017/5/12.
//
//

#import "NSArray+safe.h"
#import <objc/message.h>

@implementation NSArray (safe)

+ (void)load {
    Method originalMethod = class_getClassMethod(self, @selector(arrayWithObjects:count:));
    Method swizzledMethod = class_getClassMethod(self, @selector(ary_arrayWithObjects:count:));
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

+ (instancetype)ary_arrayWithObjects:(const id [])objects count:(NSUInteger)cnt {
    id nObjects[cnt];
    int i=0, j=0;
    for (; i<cnt && j<cnt; i++) {
        if (objects[i]) {// 过滤掉nil
            nObjects[j] = objects[i];
            j++;
        }else {
            NSLog(@"数组@[]创建时有nil值！！！！！！");
        }
    }
    // 继续使用不为nil的对象创建数组
    return [self ary_arrayWithObjects:nObjects count:j];
}

@end
