//
//  TokenRequest.h
//  GitHubClient
//
//  Created by ink on 16/5/9.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import "GitHubRequest.h"

@interface TokenRequest : GitHubRequest

@property (nonatomic, copy) NSString * code;

- (instancetype)initWithCode:(NSString *)code;

@end
