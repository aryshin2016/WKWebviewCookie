//
//  AMDKeyChain.h
//  AppMicroDistribution
//  keychain处理类
//  Created by SunSet on 15-6-4.
//  Copyright (c) 2015年 SunSet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMDKeyChain : NSObject



/*
 *保存内容
 *@param 存储的键 类似主键
 *@param 对应于主键的内容
 */
+ (void)saveData:(id)data forKey:(NSString *)key;

/*
 *根据主键取出相应的内容
 */
+ (id)loadKey:(NSString *)service;

/*
 *根绝主键删除相应的内容
 */
+ (void)deleteKey:(NSString *)service;


@end





