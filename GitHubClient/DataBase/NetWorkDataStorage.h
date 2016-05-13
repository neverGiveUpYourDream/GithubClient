//
//  NetWorkDataStorage.h
//  GitHubClient
//
//  Created by ink on 16/5/11.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserModel;

@interface NetWorkDataStorage : NSObject

+ (BOOL)storeUserNetWorkData:(UserModel *)userModel;

+ (UserModel *)getUserStorage;

+ (BOOL)deleteAllUser;

@end
