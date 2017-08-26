//
//  SQBaseWkViewController.m
//  SQPackingTool
//
//  Created by itogame on 2017/6/16.
//  Copyright © 2017年 if you. All rights reserved.
//

#import "SQBaseWkViewController.h"
#import <WebKit/WebKit.h>
#import "NSHTTPCookie+Utils.h"

@interface SQBaseWkViewController ()<WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler>

@property (strong, nonatomic) WKWebView *baseWKWebView;

@property (strong, nonatomic) NSMutableURLRequest *SQMutableRequest;

@end

/**
 JS 与 WK 交互的handle名称,JS写法如下:
 window.webkit.messageHandlers.H5GameMutually.postMessage({"action":action,"obj":obj});
 window.webkit.messageHandlers.H5GameLog.postMessage("H5Log");
 */
static NSString *const scriptMessageHandlerName = @"H5GameMutually";
static NSString *const scriptLogHandlerName = @"H5GameLog";

@implementation SQBaseWkViewController

#pragma mark - 控制器生命周期
- (void)viewDidLoad {
    [super viewDidLoad];

    //注册网络变化通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadRequest) name:YSNetworkingReachabilityDidChangeNotification object:nil];
    
    // 创建WKWebView
    [self.view addSubview:self.baseWKWebView];
    
    // 通过监听网络通知reloadRequest加载，这里不需要，否则可能会导致loadRequest两次
    // [self.baseWKWebView loadRequest:self.SQMutableRequest];    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.baseWKWebView.frame = self.view.frame;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.baseWKWebView.configuration.userContentController removeScriptMessageHandlerForName:scriptLogHandlerName];
    [self.baseWKWebView.configuration.userContentController removeScriptMessageHandlerForName:scriptMessageHandlerName];
    [self.baseWKWebView.configuration.userContentController removeScriptMessageHandlerForName:@"currentCookies"];

}

#pragma mark - getter & setter
- (NSMutableURLRequest *)SQMutableRequest {
    NSURL *url = [NSURL URLWithString:[self.httpString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    _SQMutableRequest = [NSMutableURLRequest requestWithURL:url];
    
    // 设置允许所有缓存策略（解决出现的跨域请求的cookie问题）
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    
    return _SQMutableRequest;
}

- (WKWebView *)baseWKWebView {
    if (_baseWKWebView == nil) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        WKUserContentController *controller = [[WKUserContentController alloc] init];
        // 添加消息处理，注意：self指代的对象需要遵守WKScriptMessageHandler协议，结束时需要移除
        [controller addScriptMessageHandler:self name:scriptMessageHandlerName];
        [controller addScriptMessageHandler:self name:scriptLogHandlerName];
        
        //页面加载完成立刻回调，获取页面上的所有Cookie
        WKUserScript *cookieScript = [[WKUserScript alloc] initWithSource:@"                window.webkit.messageHandlers.currentCookies.postMessage(document.cookie);" injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:NO];
        [controller addUserScript:cookieScript];
        [controller addScriptMessageHandler:self name:@"currentCookies"];
        
        
        configuration.userContentController = controller;
        _baseWKWebView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
        _baseWKWebView.scrollView.scrollEnabled = NO;// 不允许上下滚动
        _baseWKWebView.allowsBackForwardNavigationGestures = NO;    // 不允许右滑返回上个链接，左滑前进
        _baseWKWebView.UIDelegate = self;
        _baseWKWebView.navigationDelegate = self;
    }
    return _baseWKWebView;
}

#pragma mark - Navigation
//先：针对一次action来决定是否允许跳转，action中可以获取request，允许与否都需要调用decisionHandler，比如decisionHandler(WKNavigationActionPolicyCancel);
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {

    
    NSURL *jsURL = navigationAction.request.URL;
    
    if ([jsURL.absoluteString hasPrefix:@"weixin://"]) {
        decisionHandler(WKNavigationActionPolicyCancel);
        
        if ([[UIApplication sharedApplication] canOpenURL:navigationAction.request.URL]) {
            [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
        }
    } else if ([jsURL.absoluteString isEqualToString:@"about:blank"]) {
        decisionHandler(WKNavigationActionPolicyCancel);
    }else {
        //从已有的地方保存Cookie，比如登录成功
        NSArray *allCookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
        SQLog(@"跳转的URL:%@", jsURL.absoluteString);
        SQLog(@"allCookies%@******", allCookies);
        for (NSHTTPCookie *cookie in allCookies) {
            
            if ([cookie.name isEqualToString:@"userList"]) {
                NSDictionary *dict = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"userList"];
                if (dict) {
                    NSHTTPCookie *localCookie = [NSHTTPCookie cookieWithProperties:dict];
                    if (![cookie.value isEqual:localCookie.value]) {
                        SQLog(@"本地Cookie有更新");
                    }
                }
                [[NSUserDefaults standardUserDefaults] setObject:cookie.properties forKey:@"userList"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];// hahhahahah
#warning important 这里很重要
                //解决Cookie丢失问题
                NSURLRequest *originalRequest = navigationAction.request;
                [self fixRequest:originalRequest];

                break;
            }
        }
        
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

//后：根据response来决定，是否允许跳转，允许与否都需要调用decisionHandler，如decisionHandler(WKNavigationResponsePolicyAllow);
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    NSArray *allCookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    SQLog(@"allCookies%@******", allCookies);
    
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)navigationResponse.response;
    NSArray *cookies =[NSHTTPCookie cookiesWithResponseHeaderFields:[response allHeaderFields] forURL:response.URL];
   // SQLog(@"所有的cookie=%@", cookies);
    for (NSHTTPCookie *cookie in cookies) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    }
    
    decisionHandler(WKNavigationResponsePolicyAllow);
}

//开始加载，对应UIWebView的- (void)webViewDidStartLoad:(UIWebView *)webView;
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
}

//加载成功，对应UIWebView的- (void)webViewDidFinishLoad:(UIWebView *)webView;
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    
    SQLog(@"加载结束%@", NSStringFromSelector(_cmd));
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:YSNetworkingReachabilityDidChangeNotification object:nil];
    
}

//加载失败，对应UIWebView的- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
}

// 当 WKWebView 总体内存占用过大，页面即将白屏的时候，系统会调用的回调函数
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    // 在该函数里执行[webView reload](这个时候 webView.URL 取值尚不为 nil）解决白屏问题。
    [webView reload];
}

#pragma mark - WKScriptMessageHandler
-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    if ([message.name isEqualToString:@"currentCookies"]) {
        NSString *cookiesStr = message.body;
        SQLog(@"当前的cookie为： %@", cookiesStr);
    }
    
    if ([message.name isEqualToString:scriptLogHandlerName]) {
        SQLog(@"logMsgBody ==%@",[NSString stringWithFormat:@"%@", message.body]);
    }
    
    if(message.name ==nil || [message.name isEqualToString:@""])
        return;
    //message body : js 传过来值
    NSDictionary *msgBody = message.body;
    NSLog(@"msgBody ==%@",msgBody);
    if (msgBody == nil || ![msgBody isKindOfClass:[NSDictionary class]]) {
        NSLog(@"JS传递的body参数为nil或者body不是字典类型！！！！！");
        return;
    }
    
    NSString *action = [NSString stringWithFormat:@"%@", msgBody[@"action"]];
    if (!action) {return ;}
    
    NSString *objString = [NSString stringWithFormat:@"%@", msgBody[@"obj"]];
    NSDictionary *dic = [self dictionaryWithJsonString:objString];
    
    if ([action isEqualToString:@"onload"]) {//初始化
        [self onloadSDK];
    }else if ([action isEqualToString:@"register"]&&dic[@"account"]) {//注册
        [TalkingDataAppCpa onRegister:dic[@"account"]];
    }else if ([action isEqualToString:@"login"]&&dic[@"account"]){//登录
        [TalkingDataAppCpa onLogin:dic[@"account"]];
    }else if ([action isEqualToString:@"pay"]&&dic[@"account"]&&dic[@"order_id"]&&dic[@"pay_amount"]){//支付
        [TalkingDataAppCpa onPay:dic[@"account"] withOrderId:dic[@"order_id"] withAmount:[dic[@"pay_amount"] intValue]*100 withCurrencyType:@"CNY" withPayType:@"online"];
    }else if ([action isEqualToString:@"copy_code"]&&dic[@"code"]){
        [UIPasteboard generalPasteboard].string = [NSString stringWithFormat:@"%@", dic[@"code"]];
    }else if ([action isEqualToString:@"qq"]){// 保存客服QQ到静态模型
        [self saveGameServiceQQ:dic];
    }else{
        SQLog(@"###");
    }
}

#pragma mark - 自定义业务实现
- (void)saveGameServiceQQ:(NSDictionary *)jsonDic {
    // 保存客服QQ到静态模型
    [YSGameInitConvertModel share].platformServiceQQ = [NSString stringWithFormat:@"%@", jsonDic[@"platform_service_qq"]];// 平台客服QQ
    [YSGameInitConvertModel share].qq = [NSString stringWithFormat:@"%@", jsonDic[@"qq"]];// 游戏客服QQ
}

-(void)reloadRequest{
    [self.baseWKWebView loadRequest:[self fixRequest: self.SQMutableRequest]];
}

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
    SQLog(@"packInfo=%@\n devInfo=%@",str1,str2);
    // 将初始化结果返回给js
    NSString *jsStr = [NSString stringWithFormat:@"sdkShellInit('%@','%@')",str1, str2];
    [self.baseWKWebView evaluateJavaScript:jsStr completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        SQLog(@"%@----%@",result, error);
    }];
}

/**
 解决首次加载页面Cookie带不上问题
 
 @param url 链接
 */
- (void)loadUrl:(NSString *)url
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [self.baseWKWebView loadRequest:[self fixRequest:request]];
}

/**
 修复打开链接Cookie丢失问题
 
 @param request 请求
 @return 一个fixedRequest
 */
- (NSURLRequest *)fixRequest:(NSURLRequest *)request
{
    NSMutableURLRequest *fixedRequest;
    if ([request isKindOfClass:[NSMutableURLRequest class]]) {
        fixedRequest = (NSMutableURLRequest *)request;
    } else {
        fixedRequest = request.mutableCopy;
    }
    //防止Cookie丢失
    NSDictionary *dict = [NSHTTPCookie requestHeaderFieldsWithCookies:[NSHTTPCookieStorage sharedHTTPCookieStorage].cookies];
    
        NSMutableDictionary *mDict = request.allHTTPHeaderFields.mutableCopy;
        [mDict setValuesForKeysWithDictionary:dict];
        fixedRequest.allHTTPHeaderFields = mDict;
    
    return fixedRequest;
}
/*!
 *  更新webView的cookie
 */
- (void)updateWebViewCookie
{
    WKUserScript * cookieScript = [[WKUserScript alloc] initWithSource:[self cookieString] injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
    //添加Cookie
    [self.baseWKWebView.configuration.userContentController addUserScript:cookieScript];
}

- (NSString *)cookieString
{
    NSMutableString *script = [NSMutableString string];
    for (NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
        // Skip cookies that will break our script
        if ([cookie.value rangeOfString:@"'"].location != NSNotFound) {
            continue;
        }
        // Create a line that appends this cookie to the web view's document's cookies
        [script appendFormat:@"document.cookie='%@'; \n", cookie.da_javascriptString];
    }
    return script;
}

#pragma mark - WKUIDelegate
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
#warning important 这里也很重要
    //这里不打开新窗口
    [self.baseWKWebView loadRequest:[self fixRequest:navigationAction.request]];
    //这里不打开新窗口
    return nil;
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(nonnull void (^)(void))completionHandler {
    [UIPasteboard generalPasteboard].string = [NSString stringWithFormat:@"%@", message];// 复制到剪切板
    
    if ([message isEqualToString:@"qq"]) {// 打开QQ客户端
        NSString *qqString = [NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",
                              [YSGameInitConvertModel share].qq];
        NSURL *qqURL = [NSURL URLWithString:[qqString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        if ([[UIApplication sharedApplication] canOpenURL:qqURL]) {
            [[UIApplication sharedApplication] openURL:qqURL];
            completionHandler();
            return;
        }else {
            message = [NSString stringWithFormat:@"请先安装QQ再联系QQ客服: %@", [YSGameInitConvertModel share].qq];
        }
    }
    
    //js 里面的alert实现，如果不实现，网页的alert函数无效
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    [self presentViewController:alertController animated:YES completion:^{}];
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    [UIPasteboard generalPasteboard].string = [NSString stringWithFormat:@"%@", message];// 复制到剪切板
    //  js 里面的alert实现，如果不实现，网页的alert函数无效  ,
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        completionHandler(NO);
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        completionHandler(YES);
    }]];
    [self presentViewController:alertController animated:YES completion:^{}];
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString *))completionHandler {
    [UIPasteboard generalPasteboard].string = [NSString stringWithFormat:@"%@", prompt];// 复制到剪切板
    //用于和JS交互，弹出输入框
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        completionHandler(nil);
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *textField = alertController.textFields.firstObject;
        completionHandler(textField.text);
    }]];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [self presentViewController:alertController animated:YES completion:NULL];
}

#pragma mark - json 字典 互相转换
/*!* @brief 把字典格式的JSON格转换成json字符串
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
/*!* @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:kNilOptions
                                                          error:&err];
    if(err) {        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
#pragma mark - 移除通知中心
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
