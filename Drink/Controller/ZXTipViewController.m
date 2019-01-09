//
//  ZXTipViewController.m
//  Drink
//
//  Created by 区振轩 on 2018/12/24.
//  Copyright © 2018 区振轩. All rights reserved.
//

#import "ZXTipViewController.h"
#import "ZXTipCell.h"

@interface ZXTipViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tipTableView;

@end

@implementation ZXTipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tipTableView.delegate = self;
    _tipTableView.dataSource = self;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZXTipCell * cell = [tableView dequeueReusableCellWithIdentifier:@"myTipCell"];
    if (cell == nil) {
        cell = [ZXTipCell  xibTableViewZXTipCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.timeLabel.text = [NSString stringWithFormat:@"第 %ld 个", indexPath.row];
    return cell;
}



@end
