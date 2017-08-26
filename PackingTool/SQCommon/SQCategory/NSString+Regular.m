//
//  NSString+Regular.m
//

//#import "NSString+Regular.h"

@implementation NSString (Regular)

- (BOOL)isLegalPassword {
    
    return [self isMatchWithRegular:@"^[0-9A-Za-z_]{6,20}$"];
}

- (BOOL)isLegalAccount {
    
    return [self isMatchWithRegular:@"^[0-9A-Za-z_]{3,18}$"];
}

-(BOOL)isPhoneNumber {
    
//    BOOL mobile = [self isMatchWithRegular:@"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$"];
//    
//    // 虚拟运营商170
//    BOOL VNO = [self isMatchWithRegular:@"^170[0,5,9,7]([0-9]{7})$"];
//    
//    return (mobile || VNO);
//    
//    BOOL mobile = [self isMatchWithRegular:@"^1(3[0-9]|4[57]|5[0-35-9]|7[01678]|8[0-9])\\d{8}$"];
//    
//    // 虚拟运营商170
//    BOOL VNO = [self isMatchWithRegular:@"^170[0,5,9,7]([0-9]{7})$"];
//    
//    return (mobile || VNO);
    
    return self.length>0;
}

- (BOOL)isQQ {
    
    return [self isMatchWithRegular:@"^[1-9][0-9]{4,9}$"];
}

- (BOOL)isMatchWithRegular: (NSString *)regularExpression {
    
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", regularExpression] evaluateWithObject: self];
}


@end
