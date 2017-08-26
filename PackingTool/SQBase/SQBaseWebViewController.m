//
//  SQBaseWebViewController.m
//  SQPackingTool
//
//  Created by if you on 2017/5/4.
//  Copyright © 2017年 if you. All rights reserved.
//

#import "SQBaseWebViewController.h"
#import "UIWebView+JavaScriptAlert.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface SQBaseWebViewController ()<UIWebViewDelegate,JavaScriptAlertDelegate>
@property (strong ,nonatomic) UIWebView *webView;
@property (strong ,nonatomic) NSMutableURLRequest *request;
@property (strong ,nonatomic) JSContext *context;
@end

@implementation SQBaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!_webView) {
        self.webView = [[UIWebView alloc] init];
        self.webView.delegate = self;
        [self.webView setJSDelegate:self];
        self.webView.scrollView.bounces = NO;
        self.webView.scrollView.showsVerticalScrollIndicator = NO;
        self.webView.scrollView.showsHorizontalScrollIndicator = NO;
        self.webView.scalesPageToFit = YES;
        self.webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
        [self.view addSubview:self.webView];
        
        [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view.mas_top);
            make.leading.mas_equalTo(self.view.mas_leading);
            make.trailing.mas_equalTo(self.view.mas_trailing);
            make.bottom.mas_equalTo(self.view.mas_bottom);
        }];
    }
    
    //判断是否沙盒中是否有Cookie这个值
    if ([[[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] allKeys] containsObject:@"cookie"]) {
        //获取cookies：程序起来之后，uiwebview加载url之前获取保存好的cookies，并设置cookies，
        NSArray *cookies =[[NSUserDefaults standardUserDefaults]  objectForKey:@"cookie"];
        NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
        [cookieProperties setObject:[cookies objectAtIndex:0] forKey:NSHTTPCookieName];
        [cookieProperties setObject:[cookies objectAtIndex:1] forKey:NSHTTPCookieValue];
        [cookieProperties setObject:[cookies objectAtIndex:3] forKey:NSHTTPCookieDomain];
        [cookieProperties setObject:[cookies objectAtIndex:4] forKey:NSHTTPCookiePath];
        NSHTTPCookie *cookieuser = [NSHTTPCookie cookieWithProperties:cookieProperties];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage]  setCookie:cookieuser];
    }
    // 设置允许所有缓存策略（解决出现的跨域请求的cookie问题）
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    
    //NSURL *url = [[NSBundle mainBundle] URLForResource:@"MyH55.html" withExtension:nil];
    self.request = [NSMutableURLRequest requestWithURL:self.urlString.toURL];
    self.request.cachePolicy=NSURLRequestReturnCacheDataElseLoad;
    [self.webView loadRequest:self.request];
    
    //设置缓存大小
    NSURLCache *cache = [NSURLCache sharedURLCache];
    [cache setMemoryCapacity:1024*1024*50];
    [cache setDiskCapacity:1024*1024*500];
    
}

/*!
 
 * @brief 把字典格式的JSON格转换成json字符串
 * @param dic 字典
 * @return 返回字符串
 
 */
- (NSString*)dictionaryToJson:(NSDictionary *)dic{
    
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:kNilOptions
                                                         error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

/*!
 
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 
 */
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
    
}

//JS调用OC方法／*H5GameMutually(action,jsonStr)*／
- (void)addMutuallyWithContext:(JSContext *)context
{
    context[@"H5GameMutually"] = ^(NSString *action , NSString *jsonStr) {
        NSDictionary *dic = [self dictionaryWithJsonString:jsonStr];
        SQLog(@"action:%@ , str:%@",action,jsonStr);
        if (!action) {
            return ;
        }
        if ([action isEqualToString:@"onload"]) {//初始化
            
            [self onloadSDK];
            
        }else if ([action isEqualToString:@"register"]&&dic[@"account"]) {//注册
            
            [TalkingDataAppCpa onRegister:dic[@"account"]];
            
        }else if ([action isEqualToString:@"login"]&&dic[@"account"]){//登录
            
            [TalkingDataAppCpa onLogin:dic[@"account"]];
            
        }else if ([action isEqualToString:@"pay"]&&dic[@"account"]&&dic[@"order_id"]&&dic[@"pay_amount"]){//支付
            
            [YSStorager removeVerifyPruchaseWithOrderID:dic[@"order_id"]];
            [TalkingDataAppCpa onPay:dic[@"account"] withOrderId:dic[@"order_id"] withAmount:[dic[@"pay_amount"] intValue]*100 withCurrencyType:@"CNY" withPayType:@"online"];
            
        }else if ([action isEqualToString:@"qq"]){
            
            [YSGameInitConvertModel share].qq = dic[@"qq"];
            [YSGameInitConvertModel share].platformServiceQQ = dic[@"platform_service_qq"];
            
        }else{
            SQLog(@"### JS方法没找到或参数传错了");
        }
    };
}

//调用JS初始化方法
-(void)onloadSDK{
    
    NSDictionary * packInfo = @{
                                @"game_package_id" : @([YSKeyManager shared].gamePackageID) ,
                                @"secret"          : [YSKeyManager shared].appKey
                                };
    
    NSDictionary *devInfo = @{
                              @"random_id"    : [YSDeviceInfo randomID],
                              @"idfa"         : [YSDeviceInfo idfa],
                              @"brand"        : [YSDeviceInfo brand],
                              @"model"        : [YSDeviceInfo model],
                              @"net_type"     : [YSDeviceInfo currentNetwork],
                              @"game_version" : [YSDeviceInfo gameVersion],
                              @"sdk_version"  : [YSDeviceInfo sdkVersion],
                              @"os_version"   : [YSDeviceInfo osVersion]
                              };
    
    NSString *str1=[self dictionaryToJson:packInfo];
    NSString *str2=[self dictionaryToJson:devInfo];
    SQLog(@"packInfo=%@devInfo=%@",str1,str2);
    [self.context[@"sdkShellInit"] callWithArguments:@[str1,str2]];
}

#pragma mark - JavaScriptAlertDelegate - NativeAlert替换JS的alert
-(void)webView:(UIWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message{
    if ([message isEqualToString:@"qq"]) {
        if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {
            message = [NSString stringWithFormat:@"请先安装QQ再联系QQ客服: %@", [YSGameInitConvertModel share].qq];
        }else{
            NSString *openQQURL = [NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web", [YSGameInitConvertModel share].qq];
            [[UIApplication sharedApplication] openURL:openQQURL.toURL];
            return ;
        }
        
    }
    [UIPasteboard generalPasteboard].string = message;
    UIAlertView *webAlert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil];
    [webAlert show];
}

-(void)reloadRequest{
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]]];
}

#pragma mark - UIWebViewDelegate
-(void)webViewDidFinishLoad:(UIWebView *)webView{

    NSArray *nCookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    NSHTTPCookie *cookie;
    for (id c in nCookies)
    {
        if ([c isKindOfClass:[NSHTTPCookie class]])
        {
            
            cookie=(NSHTTPCookie *)c;
            SQLog(@"cookieName:%@,value:%@",cookie.name,cookie.value);
            if ([cookie.name isEqualToString:@"userList"]) {
                NSNumber *sessionOnly = [NSNumber numberWithBool:cookie.sessionOnly];
                NSNumber *isSecure = [NSNumber numberWithBool:cookie.isSecure];
                NSArray *cookies = [NSArray arrayWithObjects:cookie.name, cookie.value, sessionOnly, cookie.domain, cookie.path, isSecure, nil];
                [[NSUserDefaults standardUserDefaults] setObject:cookies forKey:@"cookie"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                break;
            }
        }
    }
    
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:YSNetworkingReachabilityDidChangeNotification object:nil];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    if ([error code] ==NSURLErrorCancelled) {
        return;
    }
    SQLog(@"加载失败%@",error);
    //注册网络变化通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadRequest) name:YSNetworkingReachabilityDidChangeNotification object:nil];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    if ([request.URL.description isEqualToString:@"about:blank"]) {
        return NO;
    }
    
    //页面加载完成后初始化content
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //打印异常,由于JS的异常信息是不会在OC中被直接打印的,所以我们在这里添加打印异常信息
    self.context.exceptionHandler =
    ^(JSContext *context, JSValue *exceptionValue)
    {
        context.exception = exceptionValue;
        NSLog(@"JSContext异常信息%@", exceptionValue);
    };
    [self addMutuallyWithContext:self.context];
    
    NSURLCache *cache = [NSURLCache sharedURLCache];
    NSCachedURLResponse *response = [cache cachedResponseForRequest:request];
    NSString *isCache;
    isCache=response!=nil?@"已缓存":@"未缓存";
    SQLog(@"RequestURLString(%@):%@",isCache,request.URL.description);
    SQLog(@"User-Agent:%@", [request valueForHTTPHeaderField:@"User-Agent"]);
    return YES;
}

#pragma mark - 移除通知
- (void)dealloc {
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
