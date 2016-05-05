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

typedef void(^SuccessBlock)(NSURLSessionDataTask *task, id _Nullable responseObject);

typedef void(^FailBlock)(NSURLSessionDataTask * _Nullable task, NSError *error);

@interface ClientNetWorkManager(){
    SuccessBlock _successBlock;
    FailBlock _failBlock;
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


- (void)authorizationRequestSuccess:(void (^)(NSURLSessionDataTask *, id _Nullable))success
                            failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError *))failure{
    _successBlock = success;
    _failBlock = failure;
    NSString * webUrlString = @"https://github.com/login/oauth/authorize?client_id=321cc634953013686064&scope=user,public_repo";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:webUrlString]];
}


- (BOOL)delaCallBackUrl:(NSURL *)url{
    if ([url.scheme isEqualToString:@"com.bear.githubclient"]) {
        
    
        NSString * codeString = [url.resourceSpecifier substringFromIndex:[url.resourceSpecifier rangeOfString:@"="].location+1];
        
        __weak ClientNetWorkManager * weakself = self;
        [self postNetWorkDataWithUrl:GitHubGetTokenUrlString AndParameter:@{@"client_id":GitHubClientID,@"client_secret":GitHubSecret,@"code":codeString} success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
            NSDictionary * dic = (NSDictionary *)responseObject;
            NSString * token = dic[@"access_token"];
            [weakself getUserInfomationWith:GitHubUserInformationUrlString token:token success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
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
                   AndParameter:(NSDictionary *)parameter
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


@end
