//
//  ZXUserValueModel.m
//  Drink
//
//  Created by 区振轩 on 2018/12/13.
//  Copyright © 2018 区振轩. All rights reserved.
//

#import "ZXUserValueModel.h"



@implementation ZXUserValueModel

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    [aCoder encodeObject:_userName forKey:@"userName"];
    [aCoder encodeInteger:_waterValue forKey:@"waterValue"];
//    [aCoder encodeDouble:_lastModifyDate forKey:@"lastModifyDate"];
    [aCoder encodeObject:_lastModifyDate forKey:@"lastModifyDate"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    if (self = [super init]) {
        _userName = [aDecoder decodeObjectForKey:@"userName"];
        _waterValue = [aDecoder decodeIntegerForKey:@"waterValue"];
        _lastModifyDate = [aDecoder decodeObjectForKey:@"lastModifyDate"];
//        _lastModifyDate = [aDecoder decodeDoubleForKey:@"lastModifyDate"];
    }
    return self;
}

@end
