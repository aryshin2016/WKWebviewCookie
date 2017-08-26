//
//  YSNetwork.m
//

#import "YSNetwork.h"
#import "AFNetworking.h"
#import "NSString+MD5.h"

static YSNetwork *shareInstance;

@interface YSNetwork ()

@property (nonatomic, nonnull, strong) AFHTTPSessionManager *manager;

@end


@implementation YSNetwork

- (instancetype)init
{
    if (shareInstance) {
        
        return shareInstance;
    }
    
    self = [super init];
    if (self) {
        
        self.manager = [AFHTTPSessionManager manager];
        self.manager.requestSerializer.timeoutInterval = YS_REQUEST_TIMEOUTINTERVAL;
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"application/json",@"text/html",@"text/javascript", nil];
        
        shareInstance = self;
    }
    return self;
}

+ (instancetype)share {
    
    return [[YSNetwork alloc] init];
}

+ (void)post:(YSHttpAPI *)api params:(NSDictionary *)params success:(YSRequestSuccessBlock)success failure:(YSRequestFailureBlock)failure {
    
    if ([api.baseURL hasPrefix:@"https://apix.112wan.com"]) {
        
        SQLog(@"Request # 112wan #");
    }
    
    if ([api.baseURL hasPrefix:@"https://apix.3456wan.com"]) {
        
        SQLog(@"Request # 3456wan #");
    }
    
    if ([api.baseURL hasPrefix:@"https://igapix.112wan.com"]) {
        
        SQLog(@"Request # 112wantest #");
    }
    
    YSNetwork *network = [self share];
    
    // 转成json字符串
    NSString *jsonString = [params mj_JSONString];
    
    // 对json字符串进行 md5
    NSString *jsonStringMD5 = jsonString.md5;
    
    // 组装sign字符串: json + appkey
    NSString *signString = [NSString stringWithFormat:@"%@%@",jsonStringMD5, [YSKeyManager shared].appKey];
    
    // 对sign进行 md5
    signString = signString.md5;
    
    // 再次对sign进行 md5
    signString = signString.md5;
    
    NSString *wholeUrl = [NSString stringWithFormat:@"%@%@%@",api.baseURL, api.path, signString];
    SQLog(@"api.baseURL=%@%@",api.baseURL,api.path);
    
    [network.manager.requestSerializer setQueryStringSerializationWithBlock:^NSString * _Nonnull(NSURLRequest * _Nonnull request, id  _Nonnull parameters, NSError * _Nullable __autoreleasing * _Nullable error) {
        
        return jsonString;
        
    }];
    
    [network.manager POST:wholeUrl parameters:jsonString progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        SQLog(@"responseObject:%@",responseObject);
       success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSError *insideError = error.userInfo[@"NSUnderlyingError"];
        NSData *data = insideError.userInfo[@"com.alamofire.serialization.response.error.data"];
        SQLog(@"%d:%@",(int)error.code, error.domain.description);
        SQLog(@"Response Info: %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        
      failure(error);
    }];
}

@end
