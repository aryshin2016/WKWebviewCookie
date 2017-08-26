//
//  AKKeyManager.h
//  AggregateKitCore
//
//  Created by Harvey on 2017/3/2.
//  Copyright © 2017年 ZuopanYao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSKeyManager : NSObject

@property (copy, readonly)   NSString *appKey;
@property (assign, readonly) NSInteger gamePackageID;
@property (assign, readonly) NSString *gameUrlString;
    
@property (copy, readonly)   NSString *talkingDataAppCpaAppID;
@property (copy, readonly)   NSString *talkingDataAppCpaChannelID;
    
@property (copy, readonly)   NSString *reYunAppKey;
@property (copy, readonly)   NSString *reYunChannelID;
    
+ (instancetype)shared;

@end
