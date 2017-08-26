//
//  ARYKeyChain.h
//  Pods
//
//  Created by 0-0 on 2017/5/18.
//
//

#import <Foundation/Foundation.h>

@import Security;

@interface ARYKeyChain : NSObject

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service;

// save username and password to keychain
+ (id)saveToKeyChain:(NSString *)service data:(id)data;

// load username and password from keychain
+ (id)loadFromKeyChain:(NSString *)service;

// delete username and password from keychain
+ (void)delete:(NSString *)serviece;

@end
