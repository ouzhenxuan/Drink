//
//  ZXTipCell.h
//  Drink
//
//  Created by 区振轩 on 2019/1/9.
//  Copyright © 2019 区振轩. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZXTipCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UISwitch *tipSwitch;

+(instancetype)xibTableViewZXTipCell;
@end

NS_ASSUME_NONNULL_END
