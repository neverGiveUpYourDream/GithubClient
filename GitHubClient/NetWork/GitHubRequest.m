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

static NSString * Etag = @"";
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


- (void)setEtag:(NSString *)etag{
    Etag = etag;
}


- (NSString *)getEtag{
    return Etag;
}


- (void)setCache:(id)response{

}


- (id)getCache{
    return nil;
}


- (BOOL)cached{
    return NO;
}


- (NSString *)getHomePath{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docPath stringByAppendingPathComponent:@"response"];
    
    
    return path;
}

@end
