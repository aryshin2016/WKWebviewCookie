//
//  Config.h
//


#pragma mark - ########## 以下宏定义发布时请注意配置 ##########

#define SQReleaseURL            @"https://apix.itogame.com/v3/"          //!< 正式环境
#define SQDeBugURL              @"https://apix.itogame.com/v3/"          //!< 测试环境

#define SQ_USER_PROTOCOL_TEXT   @"手趣游戏服务协议"
#define SQ_USER_TYPE            @"手趣用户"
#define SQ_SDK_IDENTIFIER       @"itogame"

#ifdef DEBUG
#define ENABLE_CONSOLE_PRINT
#define SQ_SDK_MODEL_DEBUG    YES
#else
#define SQ_SDK_MODEL_DEBUG    NO
#endif

#pragma mark -



