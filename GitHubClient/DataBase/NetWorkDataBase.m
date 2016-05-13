//
//  NetWorkDataBase.m
//  GitHubClient
//
//  Created by ink on 16/5/11.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import "NetWorkDataBase.h"

static FMDatabase * dbPointer;
@implementation NetWorkDataBase

+ (FMDatabase *)setUp{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * path = paths[0];
    NSString * dbPath = [path stringByAppendingPathComponent:@"NetWorkHistory.db"];
    dbPointer = [FMDatabase databaseWithPath:dbPath];
    if (![dbPointer open]) {
        return 0;
    }
    return dbPointer;
}

+ (BOOL)close{
    if (dbPointer) {
        [dbPointer close];
        dbPointer = nil;
        return YES;
    }else{
        return NO;
    }
}


@end
