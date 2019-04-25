//
//  ZXViewController.m
//  Drink
//
//  Created by 区振轩 on 2019/4/18.
//  Copyright © 2019 区振轩. All rights reserved.
//

#import "ZXViewController.h"


@interface ZXViewController ()

@end

@implementation ZXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //JmoVxia---统一设置返回按钮
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] init];
    backBtn.title = NSLocalizedString(@"返回", nil);
    self.navigationItem.backBarButtonItem = backBtn;
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
}

@end
