//
//  UIView+ZXCornerRadius.h
//  Drink
//
//  Created by 区振轩 on 2018/11/21.
//  Copyright © 2018年 区振轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZXCornerRadius)

- (void)setCornerRadius:(CGFloat)value addRectCorners:(UIRectCorner)rectCorner;

- (void)setCornerRadius:(CGFloat)value;

@end
