//
//  LoginUserStorager.h
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static NSString *const kLoginUserKey  = @"3456wan_userkey";

@interface LoginUserStorager : NSObject

/**
 *  存储用户登陆号码
 *
 *  @param userID 用户id
 *  @param userName 用户名
 *  @param passpord 密码
 */
+ (void)storeUserID:(NSString *)userID
           userName:(NSString *)userName
           passpord:(NSString *)passpord;

/**
 *  获取所有的用户身份
 */
+ (NSArray *)getAllUserNames;

/**
 * 根据userName删除用户
 */
+ (void)deleteUserName:(NSString *)username;

@end




#pragma mark - 登陆信息存储类
@interface LoginUserModel : NSObject <NSCoding>

@property(nonatomic, copy) NSString *userID;        //用户id
@property(nonatomic, copy) NSString *userName;      //用户名
@property(nonatomic, copy) NSString *password;      //密码
//@property(nonatomic, strong) NSNumber *isDefault;   //用户默认登陆的
@property(nonatomic, strong) NSNumber *createAt;    //创建时间
@property(nonatomic, strong) NSNumber *updateAt;    //更新时间

// 实例化
- (id)initWithUserID:(NSString *)userid
            userName:(NSString *)userName
          userPassword:(NSString *)password
            createAt:(NSNumber *)createAt;
//             isDefault:(NSNumber *)isDefault;

- (NSDictionary *)toDictionary;

@end










