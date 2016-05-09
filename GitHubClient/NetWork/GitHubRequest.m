//
//  GitHubRequest.m
//  GitHubClient
//
//  Created by ink on 16/5/6.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import "GitHubRequest.h"
#import "ClientNetWorkManager.h"
#import "ClientHttpConfigration.h"
@implementation GitHubRequest


- (void)startRequestWithFinshBlock:(void (^)(id result,NSError * error))block{
    _requestFinishedCallback = block;
    [self startRequest];
}


- (void)startRequest{
    [[ClientNetWorkManager shareManager] addRequest:self];
    [_sessionDataTask resume];
}


- (void)pause{
    [_sessionDataTask suspend];
}


- (void)cancel{
    [_sessionDataTask cancel];
}


- (NSString *)baseURL{
    return GitHubUserInformationURLString;
}


- (NSString *)requestURL{
    return @"/user";
}


- (GitHubRequestMethod)requestMethod{
    return GitHubRequestMethodGet;
}


- (NSDictionary *)requestParamter{
    return nil;
}

@end
