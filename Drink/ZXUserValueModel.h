//
//  ZXUserValueModel.h
//  Drink
//
//  Created by 区振轩 on 2018/12/13.
//  Copyright © 2018 区振轩. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZXUserValueModel : NSObject <NSCoding>
@property (nonatomic,strong) NSDate * lastModifyDate;
@property (nonatomic,assign) NSInteger waterValue;
@property (nonatomic,copy) NSString * userName;
@property (nonatomic,copy) NSString * userId;
@property (nonatomic,strong) NSDate * createDate;
@end

