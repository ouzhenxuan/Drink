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
    [aCoder encodeObject:_userId forKey:@"userId"];
    [aCoder encodeObject:_createDate forKey:@"createDate"];
    [aCoder encodeObject:_lastModifyDate forKey:@"lastModifyDate"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    if (self = [super init]) {
        _userName = [aDecoder decodeObjectForKey:@"userName"];
        _userId = [aDecoder decodeObjectForKey:@"userId"];
        _waterValue = [aDecoder decodeIntegerForKey:@"waterValue"];
        _lastModifyDate = [aDecoder decodeObjectForKey:@"lastModifyDate"];
        _createDate = [aDecoder decodeObjectForKey:@"createDate"];
    }
    return self;
}

@end
