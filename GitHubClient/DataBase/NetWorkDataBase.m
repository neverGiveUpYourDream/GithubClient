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
    NSString * path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString * dbPath = [path stringByAppendingString:@"NetWorkHistory.db"];
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
