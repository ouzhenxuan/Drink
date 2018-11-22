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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton * recordBtn = [[UIButton alloc] init];
    [self.view addSubview:recordBtn];
    
    [recordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.mas_equalTo(AAdaption(106));
        make.width.mas_equalTo(AAdaption(106));
    }];
    recordBtn.backgroundColor = [UIColor redColor];
    [recordBtn setTitle:@"喝水" forState:UIControlStateNormal];
    [recordBtn setCornerRadius:AAdaption(106/2.0)];

    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
