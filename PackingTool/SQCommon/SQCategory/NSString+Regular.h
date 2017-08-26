//
//  NSString+Regular.h
//

#import <Foundation/Foundation.h>

@interface NSString (Regular)


// 合法密码。6-18位字符或者数字，单一混合都可以
- (BOOL)isLegalPassword;

// 合法账号。字母开头，3-20位字母数字。
- (BOOL)isLegalAccount;

// 判断手机号码
- (BOOL)isPhoneNumber;

- (BOOL)isQQ;

@end
