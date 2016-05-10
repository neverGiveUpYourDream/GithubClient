//
//  UserRequest.m
//  GitHubClient
//
//  Created by ink on 16/5/9.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import "UserRequest.h"

@implementation UserRequest

- (NSString *)requestURL{
    return @"/user";
}


- (void)setCache:(id)response{
    BOOL result = [NSKeyedArchiver archiveRootObject:response toFile:[self getHomePath]];
    NSLog(@"%d,%@",result,[self getHomePath]);
}


- (id)getCache{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self getHomePath]];
}

@end
