//
//  NetWorkDataBase.h
//  GitHubClient
//
//  Created by ink on 16/5/11.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
@interface NetWorkDataBase : NSObject

+ (FMDatabase *)setUp;

+ (BOOL)close;
@end
