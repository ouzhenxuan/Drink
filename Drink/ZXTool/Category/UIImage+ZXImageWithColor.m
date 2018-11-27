//
//  UIImage+ZXImageWithColor.m
//  Drink
//
//  Created by 区振轩 on 2018/11/27.
//  Copyright © 2018年 区振轩. All rights reserved.
//

#import "UIImage+ZXImageWithColor.h"



@implementation UIImage (ZXImageWithColor)
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
