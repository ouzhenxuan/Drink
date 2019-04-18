//
//  ZXChartController.m
//  Drink
//
//  Created by 区振轩 on 2019/4/18.
//  Copyright © 2019 区振轩. All rights reserved.
//

#import "ZXChartController.h"

@interface ZXChartController ()
@property (weak, nonatomic) IBOutlet UIButton *popBtn;

@end

@implementation ZXChartController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)popView:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
