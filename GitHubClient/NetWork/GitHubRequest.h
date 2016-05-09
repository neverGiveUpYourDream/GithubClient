//
//  GitHubRequest.h
//  GitHubClient
//
//  Created by ink on 16/5/6.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^GithutRequestCallback)(id result,NSError * error);

typedef NS_ENUM(NSInteger , GitHubRequestMethod) {
    GitHubRequestMethodGet = 0,
    GitHubRequestMethodPost,
    GitHubRequestMethodHead,
    GitHubRequestMethodPut,
    GitHubRequestMethodDelete,
    GitHubRequestMethodPatch,
};



@interface GitHubRequest : NSObject

@property (nonatomic, strong) NSURLSessionTask * sessionDataTask;

@property (nonatomic, copy) GithutRequestCallback requestFinishedCallback;

- (void)startRequestWithFinshBlock:(void(^)(id result,NSError * error))block;

- (void)cancel;

- (void)pause;

- (NSString *)baseURL;

- (NSString *)requestURL;

- (GitHubRequestMethod)requestMethod;

- (NSDictionary *)requestParamter;






@end
