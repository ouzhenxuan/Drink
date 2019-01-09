//
//  ZXTipCell.m
//  Drink
//
//  Created by 区振轩 on 2019/1/9.
//  Copyright © 2019 区振轩. All rights reserved.
//

#import "ZXTipCell.h"

@interface ZXTipCell ()


@end

@implementation ZXTipCell

+(instancetype)xibTableViewZXTipCell{
    NSLog(@"%s",__func__);
    return (ZXTipCell *)[[[NSBundle mainBundle] loadNibNamed:@"ZXTipCell" owner:nil options:nil] lastObject];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        //初始化子类
        NSLog(@"%s",__func__);
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    //设置子类
    NSLog(@"%s",__func__);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
