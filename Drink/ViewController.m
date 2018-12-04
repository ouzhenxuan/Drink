//
//  ViewController.m
//  Drink
//
//  Created by 区振轩 on 2018/10/18.
//  Copyright © 2018年 区振轩. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "UIView+ZXCornerRadius.h"
#import "GWRoundView.h"
#import "JYWaveView.h"

#define waveHeight 6

@interface ViewController () <ChooseRoundViewDelegate>
{
    int desiredValue;
}

@property (nonatomic,assign) int totalWater;
@property (nonatomic,weak) UIView * bottonSeaView;
@property (nonatomic,strong) JYWaveView *waveView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setWaveView];
    
    [self setGWRoundButtonView];
    
    [self setupTheTitle];
    
    [self.view layoutIfNeeded];
    
    [self readTheUserValue];
}

- (void)setupTheTitle{
    UILabel * tipLabel = [[UILabel alloc] init];
    [self.view addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).mas_offset(-(100 + AAdaption(300 + 100)));
    }];
    [tipLabel setText:@"多多喝水，有益于身体健康"];
    [tipLabel setFont:AAFont(20)];
    [tipLabel setTextColor: [UIColor blackColor]];
}

//添加自定义视图
-(void)setGWRoundButtonView{
    GWRoundView *roundView = [[GWRoundView alloc] init];
    [self.view addSubview:roundView];
    [roundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-100);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(AAdaption(300));
        make.width.mas_equalTo(AAdaption(300));
    }];
    roundView.delegate = self;
}

- (void)setWaveView{
    CGFloat margin = AAdaption(100);
    
    JYWaveView *waveView = [[JYWaveView alloc] initWithFrame:CGRectMake(0, ScreenBoundsHeight - margin, ScreenBoundsWidth,waveHeight)];
    waveView.frontSpeed = -0.08;
    waveView.insideSpeed = 0.08;
    waveView.frontColor = [UIColor colorWithRed:32.0/256.0 green:183/256.0 blue:223/256.0 alpha:0.6];
    waveView.insideColor = [UIColor colorWithRed:32.0/256.0 green:183/256.0 blue:223/256.0 alpha:1];
    _waveView = waveView;
    [self.view addSubview:_waveView];
    
    UIView * seaView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenBoundsHeight - (margin - waveHeight) , ScreenBoundsWidth, margin - waveHeight)];
    [seaView setBackgroundColor:[UIColor colorWithRed:32.0/256.0 green:183/256.0 blue:223/256.0 alpha:1]];
    self.bottonSeaView = seaView;
    [self.view addSubview:self.bottonSeaView];
    
    [_waveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).mas_offset(-(margin - waveHeight));
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(waveHeight);
        make.width.mas_equalTo(ScreenBoundsWidth);
    }];

    [_bottonSeaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo((margin - waveHeight));
        make.width.mas_equalTo(ScreenBoundsWidth);
    }];
}

- (void)returnNumber:(int)num{
//    NSLog(@"num: %d",num);
    switch (num) {
        case 0:
            
            //弹出对话框输入饮水值
            break;
        case 1:
            //喝了150ml的水
            _totalWater += 150;
            break;
        case 2:
            _totalWater += 250;
            break;
        case 3:
            _totalWater += 350;
            break;
        case 4:
            _totalWater += 500;
            break;
        default:
            break;
    }
    [self setTheUserValue];
    [self changeTheBackgroundHeight];
}

//喝水总量/目标喝水量 的计算
- (void)changeTheBackgroundHeight{
    CGFloat scale = _totalWater / 1.0 / desiredValue;
    scale = scale >=1 ? 1 : scale;
    CGFloat mutableHeight = ScreenBoundsHeight - AAdaption(100 + 88);
    CGFloat offsetHeight = mutableHeight * scale + AAdaption(100);
    
    [self.view setNeedsUpdateConstraints];
    [self.bottonSeaView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(offsetHeight - waveHeight);
    }];
    
    [self.waveView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).mas_offset(-(offsetHeight - waveHeight));
    }];
    [UIView animateWithDuration:1 animations:^{
            [self.view layoutIfNeeded];
    }];
}

//从数据库中加载目标值
- (void)readTheUserValue{
    _totalWater = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TotalWater"] intValue];
    desiredValue = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TotalWater"] intValue];
    if (desiredValue == 0) {
        desiredValue = 2000;
    }
    [self changeTheBackgroundHeight];
}

- (void)setTheUserValue{
    [[NSUserDefaults standardUserDefaults] setValue:@(_totalWater) forKey:@"TotalWater"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
