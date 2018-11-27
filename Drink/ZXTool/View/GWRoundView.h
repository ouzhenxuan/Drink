//
//  GWRoundView.h
//  GWRoundButton
//
//  Created by mac on 16/8/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChooseRoundViewDelegate <NSObject>

@optional
- (void)returnNumber:(int)num;
@end

@interface GWRoundView : UIView


//中心按钮中心点，中心圆和周围圆的圆心距，圆心夹角，
@property(nonatomic,assign)CGPoint btnCenter;
@property(nonatomic,assign)CGFloat R;
@property(nonatomic,assign)CGFloat angle;

@property (nonatomic,weak) id<ChooseRoundViewDelegate> delegate;

@end
