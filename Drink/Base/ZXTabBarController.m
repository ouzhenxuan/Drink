//
//  ZXTabbarController.m
//  Drink
//
//  Created by 区振轩 on 2018/12/27.
//  Copyright © 2018 区振轩. All rights reserved.
//

#import "ZXTabBarController.h"
#import "ZXHomeViewController.h"
#import "ZXTipViewController.h"
#import "ZXNavigationController.h"

@interface ZXTabBarController ()<UITabBarControllerDelegate>

@end

@implementation ZXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
}

+ (instancetype)sharedInstance
{
    static id _sharedInstance = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)initViewControllers
{
    ZXHomeViewController *vc1 = [[ZXHomeViewController alloc] init];
    vc1.title = NSLocalizedString(@"喝水", @"喝水");
    ZXTipViewController *vc2 = [[ZXTipViewController alloc]init];
    vc2.title = NSLocalizedString(@"提示", @"提示");
    
    ZXNavigationController *navi1 = [[ZXNavigationController alloc] initWithRootViewController:vc1];
    
    self.viewControllers = @[navi1,vc2];
    self.selectedIndex = 0;
    
    UITabBarItem *item;
    item = self.tabBar.items[0];
    item.image = [UIImage imageNamed:@"icon_not_flight"];
    item.selectedImage = [UIImage imageNamed:@"飞行icon-已点击状态-0"];
    
    item = self.tabBar.items[1];
    item.image = [UIImage imageNamed:@"icon_not_media"];
    item.selectedImage = [UIImage imageNamed:@"icon_media"];
    
    self.tabBar.itemSpacing = 20;
    self.tabBar.translucent = NO;
    self.tabBar.barTintColor = [UIColor greenColor];
    self.tabBar.tintColor = [UIColor yellowColor];
    
    self.delegate = self;
    self.selectedIndex = 0;
}

@end
