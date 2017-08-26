//
//  YSStorager.m
//

#import "YSStorager.h"

#define STORAGER_KEY_VERIFY_PRUCHASE @"key"

@interface YSStorager ()

@property (weak) NSUserDefaults *userDefaults;

@end

@implementation YSStorager

- (instancetype)init {

    self = [super init];
    if (self) {
        
        self.userDefaults = [NSUserDefaults standardUserDefaults];
    }

    return self;
}

+ (NSUserDefaults *)share {
    
    static YSStorager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
       
        if (!sharedInstance) {
            
            sharedInstance = [[YSStorager alloc] init];
        }
    });
    
    return sharedInstance.userDefaults;
}

+ (BOOL)isExistVerifyPruchase {
    
    NSDictionary *orders = [[self share] objectForKey:STORAGER_KEY_VERIFY_PRUCHASE];
    return orders.count > 0;
}

+ (void)removeVerifyPruchaseWithOrderID: (NSString *)orderID {
    
    NSMutableDictionary *orders = [[[self share] objectForKey:STORAGER_KEY_VERIFY_PRUCHASE] mutableCopy];
    [orders removeObjectForKey:orderID];
    
    [[self share] setObject:orders forKey:STORAGER_KEY_VERIFY_PRUCHASE];
}

+ (void)addVerifyPruchase:(NSDictionary *)params withOrderID: (NSString *)orderID {
    
    NSMutableDictionary *orders = [[[self share] objectForKey:STORAGER_KEY_VERIFY_PRUCHASE] mutableCopy];
    
    if (!orders) {
        
        orders = [[NSMutableDictionary alloc] init];
    }
    [orders setObject:params forKey:orderID];
    
    [[self share] setObject:orders forKey:STORAGER_KEY_VERIFY_PRUCHASE];
}

+ (NSDictionary *)verifyPruchase {
    
    return [[self share] objectForKey:STORAGER_KEY_VERIFY_PRUCHASE];
}

@end
