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

//隐藏tabbar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) { // 如果现在push的不是栈底控制器(最先push进来的那个控制器)
        viewController.hidesBottomBarWhenPushed = YES;
    }
    // 修改tabBra的frame
    [super pushViewController:viewController animated:animated];
}
@end
