//
//  NSUserDefaults+TokenAccess.h
//  GitHubClient
//
//  Created by ink on 16/5/6.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (TokenAccess)

- (void)setToken:(NSString *)token;

- (NSString *)getToken;

@end
