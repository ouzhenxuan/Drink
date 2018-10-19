//
//  ZXConstants.h
//  Drink
//
//  Created by 区振轩 on 2018/10/19.
//  Copyright © 2018年 区振轩. All rights reserved.
//

#import <Foundation/Foundation.h>


#define ScreenBoundsWidth (ScreenBounds.size.width<ScreenBounds.size.height?ScreenBounds.size.width:ScreenBounds.size.height)
#define ScreenBoundsHeight (ScreenBounds.size.height>ScreenBounds.size.width?ScreenBounds.size.height:ScreenBounds.size.width)

#define ScreenBounds [UIScreen mainScreen].bounds
#define ScreenScale ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)?ScreenBoundsWidth/768.0 :ScreenBoundsWidth/414.0)
#define ScreenScaleH ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)?ScreenBoundsHeight/1024.0 :ScreenBoundsHeight/736.0)

#define iPhoneX (ScreenBoundsWidth == 375.f && ScreenBoundsHeight == 812.f)


extern NSString* const ShareSDKAppID;
extern NSString* const ShareSDKAppSecret;
