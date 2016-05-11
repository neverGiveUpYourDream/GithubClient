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
    if (![db tableExists:kUserTable]) {
        NSMutableArray * propertyArray = [NSMutableArray array];
        uint propertyCount;
        objc_property_t *ps = class_copyPropertyList([UserModel class], &propertyCount);
        for (uint i = 0; i < propertyCount; i++) {
            objc_property_t property = ps[i];
            const char *propertyName = property_getName(property);
            [propertyArray addObject:[NSString stringWithUTF8String:propertyName]];
            NSLog(@"%@",[NSString stringWithUTF8String:propertyName]);
        }

        NSMutableString * creatString = [NSMutableString stringWithFormat:@"creat table if not exists %@(",kUserTable];
        for (NSString *  propertyName in propertyArray) {
            if (propertyName != [propertyArray lastObject]) {
                [ creatString stringByAppendingString:[NSString stringWithFormat:@"%@,",propertyName]];
            }else{
                [creatString stringByAppendingString:[NSString stringWithFormat:@"%@)",propertyName]];
            }
        }
        
        NSLog(@"%@",creatString);
    }
    return YES;
    
    
}

@end
