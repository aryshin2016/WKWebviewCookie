//
//  NSDictionary+safe.m
//  Pods
//
//  Created by 0-0 on 2017/5/12.
//
//

#import "NSDictionary+safe.h"
#import <objc/message.h>

@implementation NSDictionary (safe)

/**
 （load 方法程序启动过程中只执行一次）
 类加载时执行方法交换
 */
+ (void)load {
    // +[NSDictionary dictionaryWithObjects:forKeys:count:] 的交换
    Method originalWithObjects = class_getClassMethod(self, @selector(dictionaryWithObjects:forKeys:count:));
    Method swizzledWithObjects = class_getClassMethod(self, @selector(ary_dictionaryWithObjects:forKeys:count:));
    method_exchangeImplementations(originalWithObjects, swizzledWithObjects);
    
    /**
     -[__NSDictionaryM setObject:forKey:] 的交换
     注意NSMutableDictionary对象属于__NSDictionaryM类，而不是NSMutableDictionary
    */
    Method originSetObject = class_getInstanceMethod(NSClassFromString(@"__NSDictionaryM"), @selector(setObject:forKey:));
    Method swizzedSetObjec = class_getInstanceMethod(NSClassFromString(@"__NSDictionaryM"), @selector(ary_setObject:forKey:));
    method_exchangeImplementations(originSetObject, swizzedSetObjec);
}

/**
 定义自己的实现，替换系统的方法中
 +[NSDictionary dictionaryWithObjects:forKeys:count:] 的实现
 */
+ (instancetype)ary_dictionaryWithObjects:(const id [])objects forKeys:(const id <NSCopying> [])keys count:(NSUInteger)cnt {
    id nObjects[cnt];
    id nKeys[cnt];
    int i=0, j=0;
    for (; i<cnt && j<cnt; i++) {
        if (objects[i] && keys[i]) {// 过滤掉为nil的value和key
            nObjects[j] = objects[i];
            nKeys[j] = keys[i];
            j++;
        }else {
            NSLog(@"创建字典对象中赋值了key或者value为nil！！！！！！！！！！！");
        }
    }
    // 继续传递不为nil的键值对交给系统默认实现创建字典对象
    return [self ary_dictionaryWithObjects:nObjects forKeys:nKeys count:j];
}

/**
 NSMutableDictionary
 定义自己的实现，替换系统的方法中
 -[__NSDictionaryM setObject:forKey:] 的实现
 */
- (void)ary_setObject:(id)anObject forKey:(id <NSCopying>)aKey {
    if (nil == anObject || nil == aKey) {
        NSLog(@"字典对象中传入了key或者value为nil！！！！！！！！！！！");
        return;
    }
    [self ary_setObject:anObject forKey:aKey];
}


@end
