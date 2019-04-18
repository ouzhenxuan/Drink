//
//  ZXViewController.h
//  Drink
//
//  Created by 区振轩 on 2019/4/18.
//  Copyright © 2019 区振轩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXNavigationController.h"
#import "ZXTabBarController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZXViewController : UIViewController

@property(nonatomic, strong, readonly) ZXTabBarController *tabController;
@property(nonatomic, strong, readonly) ZXNavigationController * naviController;

@end

NS_ASSUME_NONNULL_END
