//
//  NetWorkDataStorage.m
//  GitHubClient
//
//  Created by ink on 16/5/11.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import "NetWorkDataStorage.h"
#import "NetWorkDataBase.h"
#import "UserModel.h"

static NSString * const kUserTable = @"User";

@implementation NetWorkDataStorage

+ (BOOL)storeUserNetWorkData:(UserModel *)userModel{
    FMDatabase * db = [NetWorkDataBase setUp];
    NSMutableArray * propertyArray = [NSMutableArray array];
    uint propertyCount;
    objc_property_t *ps = class_copyPropertyList([UserModel class], &propertyCount);
    for (uint i = 0; i < propertyCount; i++) {
        objc_property_t property = ps[i];
        const char *propertyName = property_getName(property);
        [propertyArray addObject:[NSString stringWithUTF8String:propertyName]];
    }
    if (![db tableExists:kUserTable]) {
        NSString * creatString = [NSString stringWithFormat:@"create table if not exists %@(",kUserTable];
        for (NSString *  propertyName in propertyArray) {
            if (propertyName != [propertyArray lastObject]) {
              creatString =  [ creatString stringByAppendingString:[NSString stringWithFormat:@"%@,",propertyName]];
            }else{
              creatString = [creatString stringByAppendingString:[NSString stringWithFormat:@"%@)",propertyName]];
            }
        }
        [db executeUpdate:creatString];
    }
    
    
    NSString * insertString = [NSString stringWithFormat:@"insert into %@(",kUserTable];
    NSString * valueString = @" values(";
    for (NSString *  propertyName in propertyArray) {
        if (propertyName != [propertyArray lastObject]) {
            insertString =  [ insertString stringByAppendingString:[NSString stringWithFormat:@"%@,",propertyName]];
            valueString =  [ valueString stringByAppendingString:[NSString stringWithFormat:@"'%@',",[userModel valueForKey:propertyName]]];
        }else{
            insertString = [insertString stringByAppendingString:[NSString stringWithFormat:@"%@)",propertyName]];
            valueString = [valueString stringByAppendingString:[NSString stringWithFormat:@"'%@')",[userModel valueForKey:propertyName]]];

        }
    }
    insertString = [insertString stringByAppendingString:valueString];
    BOOL result = [db executeUpdate:insertString];
    [db close];
    return result;
}


+ (UserModel *)getUserStorage{
    FMDatabase * db = [NetWorkDataBase setUp];
    UserModel * model = [UserModel new];
    NSString * selectString  = [NSString stringWithFormat: @"select * from %@",kUserTable];
    FMResultSet * resultSet = [db executeQuery:selectString];
    while ([resultSet next]) {
        for (int i = 0; i < [resultSet columnCount]; i++) {
            
            [model setValue:[resultSet objectForColumnIndex:i] forKey:[resultSet columnNameForIndex:i]];
        }

    }
    [db close];
    return model;
}

+ (BOOL)deleteAllUser{
    FMDatabase * db = [NetWorkDataBase setUp];
    NSString * deleteString = [NSString stringWithFormat:@"delete from %@",kUserTable];
    BOOL result = [db executeUpdate:deleteString];
    [db close];
    return result;
}




@end
