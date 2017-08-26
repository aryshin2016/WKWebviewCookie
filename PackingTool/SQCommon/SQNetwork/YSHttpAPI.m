//
//  SQHttpApi.m
//  SQPackingTool
//
//  Created by if you on 2017/5/5.
//  Copyright © 2017年 if you. All rights reserved.
//

#import "YSHttpAPI.h"

@interface YSHttpAPI ()
{
    NSString *_path;
}
@end

@implementation YSHttpAPI

@synthesize baseURL;
@synthesize path;

- (instancetype)initWihtPath: (NSString *)lastpath
{
    self = [super init];
    if (self) {
        
        _path = lastpath;
    }
    return self;
}

- (NSString *)baseURL {
    
    if (SQ_SDK_MODEL_DEBUG) {
        
        return SQDeBugURL;
    }
    return SQReleaseURL;
}

- (NSString *)path {
    
    return _path;
}

+ (instancetype)initSDK {
    
    return [[YSHttpAPI alloc] initWihtPath:InitSDKParam];
}

@end
