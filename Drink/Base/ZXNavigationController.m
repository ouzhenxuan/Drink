//
//  ZXNavigationController.m
//  Drink
//
//  Created by 区振轩 on 2018/12/27.
//  Copyright © 2018 区振轩. All rights reserved.
//

#import "ZXNavigationController.h"

@interface ZXNavigationController ()

@end

@implementation ZXNavigationController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.barTintColor = [UIColor blueColor];
    self.navigationBar.translucent =  NO;
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated hideBottomBar:(BOOL)hide
{
    viewController.hidesBottomBarWhenPushed = hide;
    [self pushViewController:viewController animated:animated];
}
@end
