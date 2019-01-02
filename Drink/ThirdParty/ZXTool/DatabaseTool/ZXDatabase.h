//
//  ZXDatabase.h
//  Drink
//
//  Created by 区振轩 on 2019/1/2.
//  Copyright © 2019 区振轩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>
NS_ASSUME_NONNULL_BEGIN

@interface ZXDatabase : FMDatabase

+ (instancetype)shareDatabase;

@end

NS_ASSUME_NONNULL_END
