//
//  ClientNetWorkManager.h
//  GitHubClient
//
//  Created by ink on 16/5/3.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClientNetWorkManager : NSObject

+ (instancetype)shareManager;

- (void)authorizationRequestSuccess:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                            failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;

- (BOOL)delaCallBackUrl:(NSURL *)url;

@end
