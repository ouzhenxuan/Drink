//
//  ZXTabbarController.h
//  Drink
//
//  Created by 区振轩 on 2018/12/27.
//  Copyright © 2018 区振轩. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZXTabBarController : UITabBarController

+ (instancetype)sharedInstance;

- (void)initViewControllers;

@end

NS_ASSUME_NONNULL_END
