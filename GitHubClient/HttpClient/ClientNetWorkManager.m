//
//  ClientNetWorkManager.m
//  GitHubClient
//
//  Created by ink on 16/5/3.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import "ClientNetWorkManager.h"
#import "AFNetworking.h"
#import "ClientHttpConfigration.h"
#import "NSUserDefaults+TokenAccess.h"

typedef void(^SuccessBlock)(NSURLSessionDataTask *task, id _Nullable responseObject);

typedef void(^FailBlock)(NSURLSessionDataTask * _Nullable task, NSError *error);

@interface ClientNetWorkManager(){
    SuccessBlock _successBlock;
    FailBlock _failBlock;
//    ClientHttpConfigration * _httpConfigration;
    AFHTTPSessionManager * _manager;
}

@end

@implementation ClientNetWorkManager

+ (instancetype)shareManager{
    static ClientNetWorkManager * shareManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [self new];
    });
    return shareManager;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        _manager = [AFHTTPSessionManager manager];
    }
    return self;
}


- (void)authorizationRequestSuccess:(void (^)(NSURLSessionDataTask *, id _Nullable))success
                            failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError *))failure{
    _successBlock = success;
    _failBlock = failure;
    NSString * webUrlString = @"https://github.com/login/oauth/authorize?client_id=321cc634953013686064&scope=user,public_repo";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:webUrlString]];
}


- (BOOL)delaCallBackUrll:(NSURL *)url{
    if ([url.scheme isEqualToString:@"com.bear.githubclient"]) {
        
    
        NSString * codeString = [url.resourceSpecifier substringFromIndex:[url.resourceSpecifier rangeOfString:@"="].location+1];
        
        __weak ClientNetWorkManager * weakself = self;
        [self postNetWorkDataWithUrl:GitHubGetTokenURLString andParameter:@{@"client_id":GitHubClientID,@"client_secret":GitHubSecret,@"code":codeString} success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
            NSDictionary * dic = (NSDictionary *)responseObject;
            NSString * token = dic[@"access_token"];
            [weakself getUserInfomationWith:GitHubUserInformationURLString token:token success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
                _successBlock(task,responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
            _failBlock(task,error);
        }];
        
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        _failBlock(task,error);
        }];
        return YES;
        }else{
            return NO;
        }
}


- (void)getUserInfomationWith:(NSString *)urlString
                        token:(NSString *)token
                      success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                       failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"token %@",token] forHTTPHeaderField:@"Authorization"];
    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        success(task,error);
    }];
    
}


- (void)postNetWorkDataWithUrl:(NSString *)urlString
                   andParameter:(NSDictionary *)parameter
                        success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                        failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager POST:urlString parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
    
}


- (void)addRequest:(GitHubRequest *)request{
    AFJSONResponseSerializer * responseSerializer = [AFJSONResponseSerializer serializer];
    NSString * etag = [request getEtag];
    if (etag) {
        [_manager.requestSerializer setValue:etag forHTTPHeaderField:@"If-None-Match"];
        _manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    }
    NSMutableIndexSet *set = [[responseSerializer acceptableStatusCodes] mutableCopy];
    [set addIndex:304];
    responseSerializer.acceptableStatusCodes = set;
    _manager.responseSerializer = responseSerializer;
    [_manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [self addAuthorizationHeader];
    [self netWorkManagerAddBlockWithRequest:request];
    
    
}

- (void)netWorkManagerAddBlockWithRequest:(GitHubRequest *)request{
    switch (request.requestMethod) {
        case GitHubRequestMethodGet:{
            [self netManagerGetWithRequest:request];
            break;
        }
        case GitHubRequestMethodPost:{
            [self netManagerPostWithRequest:request];
          
            break;
        }

        case GitHubRequestMethodHead:{
            
            break;
        }
        case GitHubRequestMethodDelete:{
            
            break;
        }
        case GitHubRequestMethodPatch:{
            
            break;
        }



            
        default:
            break;
    }
}


#pragma mark - RequestMethon

- (void)netManagerGetWithRequest:(GitHubRequest *)request{
    __weak ClientNetWorkManager * weakManager = self;
    request.sessionDataTask = [_manager GET:[self buildRequest:request] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakManager setHttpRequestSuccess:task forRequest:request andResponse:responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakManager addResponseBlock:request response:nil error:error];

    }];
}


- (void)netManagerPostWithRequest:(GitHubRequest *)request{
    __weak ClientNetWorkManager * weakManager = self;
    request.sessionDataTask = [_manager POST:[self buildRequest:request] parameters:request.requestParamter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakManager setHttpRequestSuccess:task forRequest:request andResponse:responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakManager addResponseBlock:request response:nil error:error];

    }];
}





#pragma mark - Private Method
- (NSString *)buildRequest:(GitHubRequest *)request{
    NSString * URLString = request.requestURL;
    if ([URLString hasPrefix:@"http"]) {
        return URLString;
    }
    NSString * baseURLString;
    if (request.baseURL) {
        baseURLString = request.baseURL;
    }
    return [NSString stringWithFormat:@"%@%@",baseURLString,URLString];
    
}


- (void)addResponseBlock:(GitHubRequest *)request response:(id) response error:(NSError *)error{
    if (request.requestFinishedCallback) {
        request.requestFinishedCallback(response,error);
    }
}


- (void)addAuthorizationHeader{
    NSString * token = [[NSUserDefaults standardUserDefaults] getToken];
    if (token) {
        [_manager.requestSerializer setValue:[NSString stringWithFormat:@"token %@",token] forHTTPHeaderField:@"Authorization"];
 
    }
}


- (void)setHttpRequestSuccess:(NSURLSessionTask *)task forRequest:(GitHubRequest *)request andResponse:(id)responseObject{
    NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *)task.response;
    NSLog(@"%d",httpResponse.statusCode);
    if (httpResponse.statusCode != 304) {
        if ([httpResponse respondsToSelector:@selector(allHeaderFields)]) {
            NSString * etag = httpResponse.allHeaderFields[@"Etag"];
            [request setEtag:etag];
            [request setCache:responseObject];
        }
        [self addResponseBlock:request response:responseObject error:nil];

    }else{
        [self addResponseBlock:request response:[request getCache] error:nil];
    }

}



@end
