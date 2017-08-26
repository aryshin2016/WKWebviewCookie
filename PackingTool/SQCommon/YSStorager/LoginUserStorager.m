//
//  LoginUserStorager.m
//

#import "LoginUserStorager.h"
#import "AMDKeyChain.h"

@implementation LoginUserStorager

// 将用户密码存储到钥匙串里面
+ (void)storeUserID:(NSString *)userID
           userName:(NSString *)userName
           passpord:(NSString *)passpord
{
    
    SQLog(@"save:userid=%@, username=%@, passpord=%@",userID, userName, passpord);
    if (!(userID && userName && passpord)) {
        return;
    }
    
    // 所有的数据
    NSMutableArray *arry = [[self getAllUserNames] mutableCopy];
    NSArray *allUserNames = [arry valueForKey:@"userName"];
    // 如果本地已存储相应用户--更新本地的用户信息
    if ([allUserNames containsObject:userName]) {
        
        [self selectUserId:nil userName:userName userPassword:passpord];
        return;
    }
    
    NSNumber *createat = @([[NSDate date] timeIntervalSince1970]);
    LoginUserModel *model = [[LoginUserModel alloc]initWithUserID:userID userName:userName userPassword:passpord createAt:createat];
    [arry insertObject:model atIndex:0];
    [AMDKeyChain saveData:arry forKey:kLoginUserKey];
}

/**
 *  获取所有的用户身份
 */
+ (NSArray *)getAllUserNames
{
    NSArray *allUsers = [AMDKeyChain loadKey:kLoginUserKey];
    
    // 按更新时间降序排列
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc]initWithKey:@"updateAt" ascending:NO];
    NSArray *resault = [allUsers sortedArrayUsingDescriptors:@[descriptor]];
    
    if (resault == nil)   return [NSArray array];
    return resault;
}

// 传入一项即可
+ (void)selectUserId:(NSString *)userID userName:(NSString *)userName userPassword:(NSString *)passpord
{
    // 如果用户选择某个账号登陆
    // 调整本地排第顺序
    
    NSMutableArray *arry = [[self getAllUserNames] mutableCopy];
    LoginUserModel *model = nil;
    for (model in arry) {
        
        if (userID != nil && userID.length > 0) {
            
            if ([model.userID isEqualToString:userID]) {
                break;
            }
        }
        
        if (userName != nil && userName.length > 0) {
            
            if ([model.userName isEqualToString:userName]) {
                break;
            }
        }
    }
    
    model.updateAt = @([[NSDate date] timeIntervalSince1970]);
    model.password = passpord;
    
    SQLog(@"update:%@",model.updateAt);
    
    [AMDKeyChain saveData:arry forKey:kLoginUserKey];
}

#pragma mark 根据条件删除用户
+ (void)deleteUserName:(NSString *)username
{
    [self deleteUser:@"userName" user:username];
}

+ (void)deleteUser:(NSString *)key user:(NSString *)user
{
    NSMutableArray *arry = [[self getAllUserNames] mutableCopy];
    NSArray *allUserNames = [arry valueForKey:key];
    if (![allUserNames containsObject:user])
    {
        return;
    }
    NSUInteger index = [allUserNames indexOfObject:user];
    [arry removeObjectAtIndex:index];
    //    }
    [AMDKeyChain saveData:arry forKey:kLoginUserKey];
}

@end



@implementation LoginUserModel

- (void)dealloc
{
    self.userName = nil;
    self.password = nil;
    self.createAt = nil;
//    self.isDefault = nil;
    self.userID = nil;
}

- (id)initWithUserID:(NSString *)userid
            userName:(NSString *)userName
        userPassword:(NSString *)password
            createAt:(NSNumber *)createAt
//           isDefault:(NSNumber *)isDefault;
{
    if (self = [super init]) {
        self.userID = userid;
        self.userName = userName;
        self.password = password;
        self.createAt = createAt;
        self.updateAt = createAt;
//        self.isDefault = isDefault;
    }
    return self;
}

- (NSDictionary *)toDictionary
{
    return @{@"userName":self.userName,@"password":self.password,@"createAt":self.createAt,@"userID":self.userID,@"updateAt":self.updateAt};
}



#pragma mark -
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.userID forKey:@"userID"];
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeObject:self.createAt forKey:@"createAt"];
    [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeObject:self.updateAt forKey:@"updateAt"];
}


- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        
        self.userID = [aDecoder decodeObjectForKey:@"userID"];
        self.userName = [aDecoder decodeObjectForKey:@"userName"];
        self.password = [aDecoder decodeObjectForKey:@"password"];
        self.createAt = [aDecoder decodeObjectForKey:@"createAt"];
        self.updateAt = [aDecoder decodeObjectForKey:@"updateAt"];
    }
    return self;
}



@end










