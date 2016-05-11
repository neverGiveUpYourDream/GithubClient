//
//  UserModel.h
//  GitHubClient
//
//  Created by ink on 16/5/11.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface UserModel : NSObject

@property (nonatomic, copy) NSString * avatar_url;

@property (nonatomic, copy) NSString * created_at;

@property (nonatomic, copy) NSString * events_url;

@property (nonatomic, copy) NSString * following_url;

@property (assign) NSInteger following;

@property (nonatomic, copy) NSString * gists_url;

@property (nonatomic, copy) NSString * gravatar_id;

@property (nonatomic, copy) NSString * hireable;

@property (nonatomic, copy) NSString * html_url;

@property (nonatomic, copy) NSString * login;

@property (nonatomic, copy) NSString * name;

@property (nonatomic, copy) NSString * organizations_url;

@property (nonatomic, copy) NSString * owned_private_repos;

@property (assign) NSInteger  private_gists;

@property (assign) NSInteger  public_gists;

@property (assign) NSInteger public_repos;

@property (nonatomic, copy) NSString * received_events_url;

@property (nonatomic, copy) NSString * repos_url;

@property (assign) NSInteger site_admin;

@property (nonatomic, copy) NSString * starred_url;

@property (nonatomic, copy) NSString * subscriptions_url;

@property (assign) NSInteger total_private_repos;

@property (nonatomic, copy) NSString * type;

@property (nonatomic, copy) NSString * updated_at;

@property (nonatomic, copy) NSString * url;




@end
