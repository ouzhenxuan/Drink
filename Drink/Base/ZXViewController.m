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
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - getter

- (ZXNavigationController *)naviController
{
    return (ZXNavigationController *)self.navigationController;
}

- (ZXTabBarController *)tabController
{
    return (ZXTabBarController *)self.tabBarController;
}


@end
