//
//  ViewController.m
//  Drink
//
//  Created by 区振轩 on 2018/10/18.
//  Copyright © 2018年 区振轩. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "UIView+ZXCornerRadius.h"
#import "ZXChooseBtn.h"
#import "DCPathButton.h"
#import "GWRoundView.h"

@interface ViewController () <ChooseRoundViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setGWRoundButtonView];
}

//添加自定义视图
-(void)setGWRoundButtonView{
    
    GWRoundView *roundView = [[GWRoundView alloc] init];
    [self.view addSubview:roundView];
    [roundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-100);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(AAdaption(300));
        make.width.mas_equalTo(AAdaption(300));
    }];
    roundView.backgroundColor = [UIColor greenColor];
    roundView.delegate = self;
}

- (void)returnNumber:(int)num{
    NSLog(@"num: %d",num);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
