//
//  ZXDatabase.m
//  Drink
//
//  Created by 区振轩 on 2019/1/2.
//  Copyright © 2019 区振轩. All rights reserved.
//

#import "ZXDatabase.h"
#import "ZXTool.h"

@implementation ZXDatabase

+ (instancetype)shareDatabase{
    static id _db = nil;
    dispatch_once_t once ;
    dispatch_once(&once, ^{
        NSString * tempPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingString:@"Drink"];
        if (![[NSFileManager defaultManager] createDirectoryAtPath:tempPath withIntermediateDirectories:YES attributes:nil error:nil]) {
            ZXErrorLog(@"创建路径失败");
        }
        _db = [FMDatabase databaseWithPath:[tempPath stringByAppendingPathComponent:@"drink.sqlite"]];
    });
    return _db;
}

@end
