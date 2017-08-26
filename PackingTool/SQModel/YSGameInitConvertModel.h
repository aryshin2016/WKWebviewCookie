//
//  YSGameInitConvertModel.h
//

#import <Foundation/Foundation.h>
#import "YSBaseConvertModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 SDK初始化数据转换模型(单例)
 */
@interface YSGameInitConvertModel : YSBaseConvertModel

@property (assign) NSInteger update;                    //!< 是否需要更新。0=无更新，1=可选更新，2=强制更新
@property (copy, nullable) NSString *updateVersion;     //!< 更新的版本号
@property (copy, nullable) NSString *updateNotice;      //!< 更新提示
@property (copy, nullable) NSString *updateURL;         //!< 更新地址
@property (copy, nullable) NSString *recommendGameURL;  //!< 推荐游戏url
@property (copy, nullable) NSString *tel;               //!< 客服电话
@property (copy, nullable) NSString *qq;                //!< 游戏客服qq
@property (copy, nullable) NSString *platformServiceQQ; //!< 平台客服QQ
@property (copy, nullable) NSString *giftURL;           //!< 礼包url
@property (copy, nullable) NSString *activityURL;       //!< 活动中心url
@property (copy, nullable) NSString *bbsURL;            //!< bbs url
@property (copy, nullable) NSString *serviceCenterURL;  //!< 客服中心url
@property (copy, nullable) NSString *agreementURL;      //!< 游戏服务协议url
@property (copy, nullable) NSString *lastMessageURL;    //!< 最新消息地址url
@property (copy, nullable) NSString *messaggeCenterURL; //!< 我的消息地址url
@property (assign) NSInteger showLevitateWindow;        //!< 是否显示悬浮窗口，1为显示
@property (assign) NSInteger hiddenCopyright;             //!< 显示版本信息

@property (assign) NSInteger status;                    // SDK初始化状态，1为初始化成功


+ (instancetype)share;

/**
 释放单例(下次调用会重新实例化)
 */
+ (void)clean;


@end

NS_ASSUME_NONNULL_END
