//
//  ZXDrinkDatabaseTool.h
//  Drink
//
//  Created by 区振轩 on 2019/1/3.
//  Copyright © 2019 区振轩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXDatabase.h"
#import "ZXUserValueModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZXDrinkDatabaseTool : NSObject

+ (NSMutableArray <ZXUserValueModel *> *)allModelsWithUserId:(NSString *)userId;
+ (void)addModel:(ZXUserValueModel *)model;
+ (void)deleteModel:(ZXUserValueModel *)model;
+ (void)deleteAll;

@end

NS_ASSUME_NONNULL_END
