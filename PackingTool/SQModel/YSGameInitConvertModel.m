//
//  YSGameInitConvertModel.m
//

#import "YSGameInitConvertModel.h"

static YSGameInitConvertModel *shareInstance = nil;

@implementation YSGameInitConvertModel

- (instancetype)init {
    
    if (shareInstance) {
        
        return shareInstance;
    }
    
    self = [super init];
    if (self) {
        
        shareInstance = self;
    }
    return self;
}

+ (instancetype)share {
    
    return [[self alloc] init];
}

+ (void)clean {
    
    shareInstance = nil;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{
             @"update":             @"data.update",
             @"updateVersion":      @"data.update_version",
             @"updateNotice":       @"data.update_notice",
             @"updateURL":          @"data.update_url",
             @"recommendGameURL":   @"data.recommend_game_url",
             @"tel":                @"data.tel",
             @"qq":                 @"data.qq",
             @"platformServiceQQ":  @"data.platform_service_qq",
             @"giftURL":            @"data.gift_url",
             @"activityURL":        @"data.activity_url",
             @"bbsURL":             @"data.bbs_url",
             @"serviceCenterURL":   @"data.service_center_url",
             @"agreementURL":       @"data.agreement_url",
             @"lastMessageURL":     @"data.last_message_url",
             @"messaggeCenterURL":  @"data.message_center_url",
             @"showLevitateWindow": @"data.show_win",
             @"hiddenCopyright":    @"data.hide_ltd",
             @"errorCode":          @"errno",
             @"errorInfo":          @"msg",
             @"data":               @"data"
             };
}

@end
