//
//  TokenRequest.m
//  GitHubClient
//
//  Created by ink on 16/5/9.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import "TokenRequest.h"
#import "ClientHttpConfigration.h"



@implementation TokenRequest

- (instancetype)initWithCode:(NSString *)code{
    self = [super init];
    if (self) {
        _code = code;
    }
    return self;
}

- (NSString *)requestURL{
    return GitHubGetTokenURLString;
}


- (GitHubRequestMethod)requestMethod{
    return GitHubRequestMethodPost;
}

- (NSDictionary *)requestParamter{
    return @{@"client_id":GitHubClientID,@"client_secret":GitHubSecret,@"code":_code};
}

@end
