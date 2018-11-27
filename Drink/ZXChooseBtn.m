//
//  ZXChooseBtn.m
//  Drink
//
//  Created by 区振轩 on 2018/11/26.
//  Copyright © 2018年 区振轩. All rights reserved.
//

#import "ZXChooseBtn.h"
#import "DCPathButton.h"
@interface ZXChooseBtn() <DCPathButtonDelegate>
@property (nonatomic,strong) DCPathButton *dcPathButton;
@end

@implementation ZXChooseBtn

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    _dcPathButton = [[DCPathButton alloc]initWithCenterImage:[UIImage imageNamed:@"chooser-button-tab"]
                                                         highlightedImage:[UIImage imageNamed:@"chooser-button-tab-highlighted"]];
    _dcPathButton.delegate = self;
    
    // Configure item buttons
    //
    DCPathItemButton *itemButton_1 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-music"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-music-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    DCPathItemButton *itemButton_2 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-place"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-place-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    DCPathItemButton *itemButton_3 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-camera"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-camera-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    DCPathItemButton *itemButton_4 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-thought"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-thought-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    DCPathItemButton *itemButton_5 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-sleep"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-sleep-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    // Add the item button into the center button
    //
    [_dcPathButton addPathItems:@[itemButton_1,
                                 itemButton_2,
                                 itemButton_3,
                                 itemButton_4,
                                 itemButton_5
                                 ]];
    
    // Change the bloom radius, default is 105.0f
    //
    _dcPathButton.bloomRadius = 120.0f;
    
    // Change the DCButton's center
    //
//    dcPathButton.dcButtonCenter = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height - 25.5f);
    
    _dcPathButton.dcButtonCenter = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height - 25.5f);
    
    // Setting the DCButton appearance
    //
    _dcPathButton.allowSounds = YES;
    _dcPathButton.allowCenterButtonRotation = YES;
    
    _dcPathButton.bottomViewColor = [UIColor grayColor];
    
    _dcPathButton.bloomDirection = kDCPathButtonBloomDirectionTopRight;
    
    _dcPathButton.bottomViewColor = [UIColor redColor];
    
    [self addSubview:_dcPathButton];
    
}

- (void)layoutSubviews{
    _dcPathButton.dcButtonCenter = CGPointMake(10 + _dcPathButton.frame.size.width/2, self.frame.size.height - _dcPathButton.frame.size.height/2 - 10);
}


#pragma mark - DCPathButton Delegate

- (void)willPresentDCPathButtonItems:(DCPathButton *)dcPathButton {
    
    NSLog(@"ItemButton will present");
    
}

- (void)pathButton:(DCPathButton *)dcPathButton clickItemButtonAtIndex:(NSUInteger)itemButtonIndex {
    NSLog(@"You tap %@ at index : %lu", dcPathButton, (unsigned long)itemButtonIndex);
}

- (void)didPresentDCPathButtonItems:(DCPathButton *)dcPathButton {
    
    NSLog(@"ItemButton did present");
    
}

@end
