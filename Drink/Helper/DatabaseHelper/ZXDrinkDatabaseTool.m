//
//  ZXDrinkDatabaseTool.m
//  Drink
//
//  Created by 区振轩 on 2019/1/3.
//  Copyright © 2019 区振轩. All rights reserved.
//

#import "ZXDrinkDatabaseTool.h"
#import <FMDB/FMDB.h>


static FMDatabase *_db;

@implementation ZXDrinkDatabaseTool


+ (void)initialize{
    _db = [ZXDatabase shareDatabase];
    if ([_db open]) {
        if ([_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_userInfo(id integer PRIMARY KEY AUTOINCREMENT,userId text, username text, waterValue int,createdate datetime);"]) {
            ZXLog(@"drink 建表成功");
        }
        [_db close];
    }
}

+ (NSMutableArray <ZXUserValueModel *> *)allModelsWithUserId:(NSString *)userId
{
    [_db open];
    
    FMResultSet *set = [_db executeQuery:@"SELECT * FROM t_userInfo WHERE userId=? ORDER BY id ASC;",userId];
    
    NSMutableArray *models = [NSMutableArray array];
    while (set.next) {
        ZXUserValueModel *temp = [[ZXUserValueModel alloc] init];
        temp.userName = [set stringForColumn:@"username"];
        temp.userId = [set stringForColumn:@"userId"];
        temp.waterValue = [set intForColumn:@"waterValue"];
        temp.createDate = [NSDate dateWithTimeIntervalSince1970:[set doubleForColumn:@"createdate"]];
        [models addObject:temp];
    }
    
    [_db close];
    return models;
}

+ (void)addModel:(ZXUserValueModel *)model;
{
    BOOL isSuccess=[_db open];
    if (!isSuccess) {
        ZXErrorLog(@"打开数据库失败");
        return;
    }
    [_db beginTransaction];
    BOOL isRollBack = NO;
    @try {
        if ([_db executeUpdateWithFormat:@"INSERT INTO t_userInfo(username,userId,waterValue,createDate) VALUES (%@,%@,%ld,%f);",model.userName,model.userId,(long)model.waterValue,[model.createDate timeIntervalSince1970]]) {
            ZXLog(@"插入用户信息成功,%@",model.userName);
        }
    }
    @catch (NSException *exception) {
        isRollBack = YES;
        ZXLog(@"数据库回退");
        [_db rollback];
    }
    @finally {
        if (!isRollBack) {
            ZXLog(@"数据库 commit");
            [_db commit];
        }
    }
    [_db close];
}

+ (void)deleteModel:(ZXUserValueModel *)model
{
    BOOL isSuccess=[_db open];
    if (!isSuccess) {
        ZXErrorLog(@"打开数据库失败");
        return;
    }
    
    [_db beginTransaction];
    BOOL isRollBack = NO;
    @try {
        if ([_db executeUpdate:@"DELETE FROM t_userInfo WHERE userId=?",model.userId]) {
            ZXLog(@"删除记录成功,%@ , %@",model.userName,model.userId);
        }
    }
    @catch (NSException *exception) {
        isRollBack = YES;
        ZXLog(@"数据库回退");
        [_db rollback];
    }
    @finally {
        if (!isRollBack) {
            ZXLog(@"数据库 commit");
            [_db commit];
        }
    }
    [_db close];
}

+ (void)deleteAll
{
    [_db executeUpdate:@"DELETE FROM t_userInfo;"];
}

@end
