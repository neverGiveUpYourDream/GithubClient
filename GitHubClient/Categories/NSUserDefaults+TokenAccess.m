//
//  NSUserDefaults+TokenAccess.m
//  GitHubClient
//
//  Created by ink on 16/5/6.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import "NSUserDefaults+TokenAccess.h"

static NSString * const kGitHubToken = @"GitHubToken";

@implementation NSUserDefaults (TokenAccess)

- (void)setToken:(NSString *)token{
    NSAssert(token.length > 0, @"token must not nil");
    [self setGitHubValue:token andKey:kGitHubToken];
}


- (NSString *)getToken{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kGitHubToken];
}


- (void)setGitHubValue:(id)value andKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
