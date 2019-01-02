//
//  Adaption.h
//  Drink
//
//  Created by 区振轩 on 2018/11/22.
//  Copyright © 2018年 区振轩. All rights reserved.
//

#ifndef Adaption_h
#define Adaption_h

#import <UIKit/UIKit.h>

#pragma 屏幕尺寸

#define kwidth [UIScreen mainScreen].bounds.size.width
#define kheight [UIScreen mainScreen].bounds.size.height

#pragma UI设计图尺寸

#define kBaseWidth 750
#define kBaseHeight 1334
//宏定义内联函数
#define Inline static inline
#pragma mark --设置比例
//实际屏幕宽度和设计图宽度的比例
Inline CGFloat AAdaptionWidth() {
    return kwidth/kBaseWidth;
}

//传入设计图尺寸标注，转化为实际屏幕尺寸标注
Inline CGFloat AAdaption(CGFloat x) {
    return x * AAdaptionWidth();
}
//传入设计图size，转化为实际屏幕的CGsize返回
Inline CGSize AAdaptionSize(CGFloat width, CGFloat height) {
    CGFloat newWidth = width * AAdaptionWidth();
    CGFloat newHeight = height * AAdaptionWidth();
    return CGSizeMake(newWidth, newHeight);
}
//传入设计图Point，转化成CGpoint返回
Inline CGPoint AAadaptionPoint(CGFloat x, CGFloat y) {
    CGFloat newX = x * AAdaptionWidth();
    CGFloat newY = y * AAdaptionWidth();
    return  CGPointMake(newX, newY);
}
//传入设计图Rect，返回已适配真实屏幕的CGrect
Inline CGRect AAdaptionRect(CGFloat x, CGFloat y, CGFloat width, CGFloat height){
    CGFloat newX = x*AAdaptionWidth();
    CGFloat newY = y*AAdaptionWidth();
    CGFloat newW = width*AAdaptionWidth();
    CGFloat newH = height*AAdaptionWidth();
    return CGRectMake(newX, newY, newW, newH);
}

Inline CGRect AAdaptionRectFromFrame(CGRect frame){
    CGFloat newX = frame.origin.x*AAdaptionWidth();
    CGFloat newY = frame.origin.y*AAdaptionWidth();
    CGFloat newW = frame.size.width*AAdaptionWidth();
    CGFloat newH = frame.size.height*AAdaptionWidth();
    return CGRectMake(newX, newY, newW, newH);
}



//字体适配：传出设计图字体大小
Inline UIFont * AAFont(CGFloat font){
    return [UIFont systemFontOfSize:font*AAdaptionWidth()];
}
//加粗字体适配
Inline UIFont * BoldFont(CGFloat font){
    return [UIFont boldSystemFontOfSize:font*AAdaptionWidth()];
}

#endif /* Adaption_h */
