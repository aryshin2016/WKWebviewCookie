//
//  AKKeyManager.m
//  AggregateKitCore
//
//  Created by Harvey on 2017/3/2.
//  Copyright © 2017年 ZuopanYao. All rights reserved.
//

#import "YSKeyManager.h"

@interface YSKeyManager ()

@property (copy) NSDictionary *plistReader;

@end

@implementation YSKeyManager

+ (instancetype)shared {
    
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"SQUnionParams" ofType:@"plist"];
        if (plistPath) {
            
//            plistPath = [plistPath stringByAppendingString:@"/YSUnionParams.plist"];
            self.plistReader = [NSDictionary dictionaryWithContentsOfFile:plistPath];
        }
    }
    
    return self;
}

- (NSString *)appKey {
    
    return [self.plistReader valueForKey:@"SQAppKey"];
}

- (NSInteger)gamePackageID {
    
     return ((NSNumber *)[self.plistReader valueForKey:@"SQGamePackageID"]).integerValue;
}

- (NSString *)gameUrlString {
    
    return [self.plistReader valueForKey:@"SQGameUrl"];
}

- (NSString *)talkingDataAppCpaAppID {
    
    return [self.plistReader valueForKey:@"TalkingDataAppID"];
}
    
- (NSString *)talkingDataAppCpaChannelID {
    
    return [self.plistReader valueForKey:@"TalkingDataChannelID"];
}

- (NSString *)reYunAppKey {
 
    return [self.plistReader valueForKey:@"ReYunAppKey"];
}

- (NSString *)reYunChannelID {
    
    return [self.plistReader valueForKey:@"ReYunChannelID"];
}
    
@end
