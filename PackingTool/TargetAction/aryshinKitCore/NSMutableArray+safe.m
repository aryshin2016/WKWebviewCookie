//
//  NSMutableArray+safe.m
//  Pods
//
//  Created by 0-0 on 2017/5/12.
//
//

#import "NSMutableArray+safe.h"
#import <objc/message.h>

@implementation NSMutableArray (safe)

+ (void)load {
    Class arrayCls = NSClassFromString(@"__NSArrayM");
    
    Method originalMethod1 = class_getInstanceMethod(arrayCls, @selector(insertObject:atIndex:));
    Method swizzledMethod1 = class_getInstanceMethod(arrayCls, @selector(ary_insertObject:atIndex:));
    method_exchangeImplementations(originalMethod1, swizzledMethod1);
    
    Method originalMethod2 = class_getInstanceMethod(arrayCls, @selector(setObject:atIndexedSubscript:));
    Method swizzledMethod2 = class_getInstanceMethod(arrayCls, @selector(ary_setObject:atIndexedSubscript:));
    method_exchangeImplementations(originalMethod2, swizzledMethod2);
    
    Method originalMethod3 = class_getInstanceMethod(arrayCls, @selector(setObject:atIndex:));
    Method swizzledMethod3 = class_getInstanceMethod(arrayCls, @selector(ary_setObject:atIndex:));
    method_exchangeImplementations(originalMethod3, swizzledMethod3);
}

- (void)ary_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (!anObject) {
        NSLog(@"可变数组中有insert值为nil的对象！！！！！！");
        return;
    }
    [self ary_insertObject:anObject atIndex:index];
}

- (void)ary_setObject:(id)anObject atIndexedSubscript:(NSUInteger)index {
    if (!anObject) {
        NSLog(@"可变数组中的元素不可以赋值为nil的对象！！！！！！");
        return;
    }
    [self ary_setObject:anObject atIndexedSubscript:index];
}

- (void)ary_setObject:(id)anObject atIndex:(NSUInteger)index {
    if (!anObject){
        NSLog(@"可变数组中的元素不可以赋值为nil的对象！！！！！！");
        return;
    }
    [self ary_setObject:anObject atIndex:index];
}

@end
