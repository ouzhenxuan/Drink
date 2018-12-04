//
//  GWRoundView.m
//  GWRoundButton
//
//  Created by mac on 16/8/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GWRoundView.h"
#import "UIView+ZXCornerRadius.h"
#import "UIImage+ZXImageWithColor.h"
#import <Masonry.h>
@interface GWRoundView (){
    CGFloat _Width;
    CGFloat _Height;
    BOOL isCenterBtnSelected;
}


@property (nonatomic,assign) int circleNumber ;//小圆的个数
@property (nonatomic,strong) NSMutableArray * btnArray;
@property (nonatomic,strong) UIButton * centenButton;
@end

@implementation GWRoundView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setRoundButton];
    }
    return self;
}

- (void)layoutSubviews{
    
}

-(void)setRoundButton{
    UIImage * normalImage  = [UIImage imageWithColor:[UIColor colorWithRed:52.0/256.0 green:128/256.0 blue:249/256.0 alpha:1]];
    
    _circleNumber = 5;
    self.R = 90; //中心圆和周围圆的圆心距
    _Width = self.frame.size.width;
    _Height = self.frame.size.height;
    
    self.angle = 2 * M_PI / _circleNumber;
    
//    CGFloat a = 10; //小圆的间距
//    CGFloat r = self.R * sinf(self.angle/2.0) - a / 2.0; //小圆的半径
    CGFloat r = 40;
    
    _centenButton = [[UIButton alloc] init];
    _centenButton.tag = 300;
    _centenButton.backgroundColor = [UIColor blueColor];
    [_centenButton setTitle:@"添加" forState:UIControlStateNormal];
    [_centenButton setBackgroundImage:normalImage forState:UIControlStateNormal];
    [_centenButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_centenButton];
    [_centenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.height.mas_equalTo(AAdaption(80));
        make.width.mas_equalTo(AAdaption(80));
    }];
    [_centenButton setCornerRadius:40];
    
    NSArray *array = @[@"自定义",@"150ml",@"250ml",@"300ml",@"500ml",@"750ml"];
    _btnArray = [NSMutableArray array];
    for (int i=0; i<_circleNumber; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(0, 0, 2*r, 2*r);
        btn.center = _centenButton.center;
        btn.tag = 100+i;
        btn.alpha = 0;
        btn.layer.cornerRadius = r;
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setCornerRadius:r];
        [btn setBackgroundImage:normalImage forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [_btnArray addObject:btn];
    }
    
    //把中心按钮永远放在父视图最上层
    [self bringSubviewToFront:_centenButton];
}

//所有button的点击事件
-(void)buttonClick:(UIButton *)button{
    CGFloat offsetAngle = M_PI_2;
    self.btnCenter = _centenButton.center;
    if (button.tag==300) {
        if (!isCenterBtnSelected) {
            for (UIButton * btn  in _btnArray) {
                btn.center = _centenButton.center;
            }
            [UIView animateWithDuration:0.3 animations:^{
                button.center = self.btnCenter;
            }];
            
            [UIView animateWithDuration:0.3 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
                for (int i=0; i<self->_circleNumber; i++) {
                    UIButton *btn = (UIButton *)[self viewWithTag:i+100];
                    CGFloat x = self.R * cosf(self.angle * i + offsetAngle) + self.btnCenter.x;
                    CGFloat y = self.R * sinf(self.angle * i + offsetAngle) + self.btnCenter.y;
                    btn.center = CGPointMake(x ,y);
                    btn.alpha = 1;
                }
            } completion:^(BOOL finished) {
                
            }];
            
        }else{
            [self dismissTheBt];
        }
    }else if (button.tag>=100&&button.tag<107){
        [self selectDataWithNumber:button.tag-100.0];
        [self dismissTheBt];
    }
    isCenterBtnSelected = !isCenterBtnSelected;
}

- (void)dismissTheBt{
    [UIView animateWithDuration:0.3 animations:^{
        for (int i=0; i<self->_circleNumber; i++) {
            UIButton *btn = (UIButton *)[self viewWithTag:i+100];
            btn.center = self.btnCenter;
            btn.alpha = 0;
        }
    }];
}

//根据点击按钮的不同，进行不同的操作
-(void)selectDataWithNumber:(int)index{
    if ([self.delegate respondsToSelector:@selector(returnNumber:)]) {
        [self.delegate returnNumber:index];
    }
}

@end
