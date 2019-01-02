//
//  UIView+ZXCornerRadius.m
//  Drink
//
//  Created by 区振轩 on 2018/11/21.
//  Copyright © 2018年 区振轩. All rights reserved.
//

#import "UIView+ZXCornerRadius.h"

@implementation UIView (ZXCornerRadius)


/**
 * setCornerRadius   给view设置圆角
 * @param value      圆角大小
 * @param rectCorner 圆角位置
 **/
- (void)setCornerRadius:(CGFloat)value addRectCorners:(UIRectCorner)rectCorner{
    
    [self layoutIfNeeded];//这句代码很重要，不能忘了
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(value, value)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    shapeLayer.path = path.CGPath;
    self.layer.mask = shapeLayer;
    
}

/**
 * setCornerRadius   给view设置圆角
 * @param value      圆角大小
 **/
- (void)setCornerRadius:(CGFloat)value{
    
    [self layoutIfNeeded];//这句代码很重要，不能忘了
    
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:value];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    shapeLayer.path = path.CGPath;
    [self.layer setMask:shapeLayer];
//    self.layer.masksToBounds = true;
//    self.userInteractionEnabled = YES;
}


@end


































