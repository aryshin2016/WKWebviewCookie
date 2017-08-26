//
//  YSHinter.m
//

#import "YSHinter.h"
#import "MBProgressHUD.h"

@interface YSHinter()

@property (nonatomic,strong) MBProgressHUD *progressHUD;

@end

@implementation YSHinter

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
    }
    return self;
}

- (void)showHinterWithMessage:(NSString *)msg isLoading: (BOOL)isLoading completionBlock:(void (^)())completionBlock {
    
    UIView *parentView = [UIApplication sharedApplication].keyWindow.rootViewController.view;
    self.progressHUD = [[MBProgressHUD alloc] initWithView:parentView];
    self.progressHUD.removeFromSuperViewOnHide = YES;
    self.progressHUD.contentColor = [UIColor whiteColor]; // 字的颜色
    self.progressHUD.bezelView.color = UIColorFromHexValue(0xff6600); // 背景颜色
    [parentView addSubview:self.progressHUD];
    
    NSTimeInterval duration = 2;
    self.progressHUD.mode = MBProgressHUDModeText;
    
    if (isLoading) {
        
        duration = YS_REQUEST_TIMEOUTINTERVAL;
        self.progressHUD.mode = MBProgressHUDModeIndeterminate;
    }
    
    self.progressHUD.label.text = msg;
    self.progressHUD.completionBlock = completionBlock;
    [self.progressHUD showAnimated:YES];
    [self.progressHUD hideAnimated:YES afterDelay:duration];
}

+ (YSHinter *)share {
    
    static YSHinter *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        if (!sharedInstance) {
            
            sharedInstance = [[YSHinter alloc] init];
        }
    });
    
   return sharedInstance;
}

+ (void)hiddenHinterWithCompletionBlock: (void (^)())completionBlock {
    
    [self share].progressHUD.completionBlock = completionBlock;
    [[self share].progressHUD hideAnimated:YES];
}

+ (void)hiddenHinter {
    
    [self share].progressHUD.completionBlock = nil;
    [[self share].progressHUD hideAnimated:YES];
}

@end


@implementation NSString(Hinter)

- (void)showToast {

    [[YSHinter share] showHinterWithMessage:self isLoading:NO completionBlock:nil];
}

- (void)showToastWithCompletionBlock:(void (^)())completionBlock {
    
     [[YSHinter share] showHinterWithMessage:self isLoading:NO completionBlock:completionBlock];
}

- (void)showLoadingToast {
    
    [[YSHinter share] showHinterWithMessage:self isLoading:YES completionBlock:nil];
}

- (void)showLoadingToastWithCompletionBlock:(void (^)())completionBlock {
    
    [[YSHinter share] showHinterWithMessage:self isLoading:YES completionBlock:completionBlock];
}

- (void)showAlertViewWithTitle: (NSString *)title {
    
    [[[UIAlertView alloc] initWithTitle:title message:self delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
}
@end

