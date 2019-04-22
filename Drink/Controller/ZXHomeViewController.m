//
//  ViewController.m
//  Drink
//
//  Created by 区振轩 on 2018/10/18.
//  Copyright © 2018年 区振轩. All rights reserved.
//

#import "ZXHomeViewController.h"
#import <Masonry/Masonry.h>
#import "UIView+ZXCornerRadius.h"
#import "GWRoundView.h"
#import "JYWaveView.h"
#import "ZXUserValueModel.h"
#import "ZXDrinkDatabaseTool.h"
#import <UserNotifications/UserNotifications.h>
#import "ZXLocalPushHelper.h"
#import "ZXNavigationController.h"
#import "ZXChartController.h"

#define waveHeight 6
#define viewHeight ScreenBoundsHeight-TabBarH

//@import Charts;

@interface ZXHomeViewController () <ChooseRoundViewDelegate , UINavigationControllerDelegate>
{
    int desiredValue;
}

@property (nonatomic,assign) NSInteger totalWater;
@property (nonatomic,weak) UIView * bottonSeaView;
@property (nonatomic,strong) JYWaveView *waveView;
@property (nonatomic,weak) UILabel * waterValueLabel;

@end

@implementation ZXHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
//    波浪控件
    [self setWaveView];
//    添加喝水量的控件
    [self setGWRoundButtonView];
//    喝水总量的数字提示label和健康祝福语label
    [self setupTheTitle];
//    初始化布局，让前面添加的l控件有确定的frame
    [self.view layoutIfNeeded];
//    从数据库中读取用户数据
    [self readTheUserValue];
//    检查通知功能是否开启
    [self checkUserNotificationEnable];
//    左上统计按钮
    [self setStatisticsBtn];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}


- (void)setStatisticsBtn{
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 44, 44, 44)];
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor greenColor];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [btn setTitle:@"统计" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnClick:(UIButton *)btn{
    ZXChartController * chartVc = [[ZXChartController alloc] init];
    [self.naviController pushViewController:chartVc animated:YES hideBottomBar:YES];
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
    
    UILabel * waterlabel =  [[UILabel alloc] init];
    _waterValueLabel = waterlabel;
    [self.view addSubview:_waterValueLabel];
    [waterlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).mas_offset(-(100 + AAdaption(300 + 60)));
    }];
    [waterlabel setFont:AAFont(20)];
    [waterlabel setTextColor: [UIColor blackColor]];
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
    
    JYWaveView *waveView = [[JYWaveView alloc] initWithFrame:CGRectMake(0, viewHeight - margin, ScreenBoundsWidth,waveHeight)];
    waveView.frontSpeed = -0.08;
    waveView.insideSpeed = 0.08;
    waveView.frontColor = [UIColor colorWithRed:32.0/256.0 green:183/256.0 blue:223/256.0 alpha:0.6];
    waveView.insideColor = [UIColor colorWithRed:32.0/256.0 green:183/256.0 blue:223/256.0 alpha:1];
    _waveView = waveView;
    [self.view addSubview:_waveView];
    
    UIView * seaView = [[UIView alloc] initWithFrame:CGRectMake(0, viewHeight - (margin - waveHeight) , ScreenBoundsWidth, margin - waveHeight)];
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
    int waterValue = 0;
    switch (num) {
        case 0:
        //弹出对话框输入饮水值
            [self showAddWaterAlertView];
            return;
        case 1:
            //喝了150ml的水
            waterValue = 150;
            break;
        case 2:
            waterValue = 250;
            break;
        case 3:
            waterValue = 350;
            break;
        case 4:
            waterValue = 500;
            break;
        default:
            break;
    }
    [self addDataToDB:waterValue];
}

- (void)addDataToDB:(int)waterValue{
    //将数据添加到数据库
    ZXUserValueModel * model = [[ZXUserValueModel alloc] init];
    model.userName = APPLICATION_USERNAME;
    model.userId = APPLICATION_UUID;
    model.waterValue = waterValue;
    model.createDate = [NSDate date];
    [ZXDrinkDatabaseTool addModel:model];
    
    _totalWater += waterValue;
    [self setTheUserValue];
    [self changeTheBackgroundHeight];
}

- (void)showAddWaterAlertView{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"显示的标题" message:@"标题的提示信息" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击取消");
    }]];
    __block UITextField * text;
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        NSLog(@"添加一个textField就会调用 这个block");
        text = textField;
        [textField setKeyboardType:UIKeyboardTypeNumberPad];
    }];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击确定");
        NSLog(@"%@", text.text);
        [self addDataToDB:text.text.intValue];
    }]];
    [self presentViewController:alertController animated:YES completion:^{
        NSLog(@"completion");
    }];
}

//喝水总量/目标喝水量 的计算
- (void)changeTheBackgroundHeight{
    CGFloat scale = _totalWater / 1.0 / desiredValue;
    scale = scale >=1 ? 1 : scale;
    CGFloat mutableHeight = viewHeight - AAdaption(100 + 88);
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
    [_waterValueLabel setText:[NSString stringWithFormat:@"%ld ml",_totalWater]];
}

//从数据库中加载目标值
- (void)readTheUserValue{
    NSData * data = [[NSUserDefaults standardUserDefaults] objectForKey:@"TotalWater"] ;
    
    ZXUserValueModel *  model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (model.lastModifyDate && [self pleaseInsertStarTime:model.lastModifyDate andInsertEndTime:[NSDate new]]<1) {
        _totalWater = model.waterValue;
    }
    
    desiredValue = [[[NSUserDefaults standardUserDefaults] objectForKey:@"DesiredValue"] intValue];
    if (desiredValue == 0) {
        desiredValue = 2000;
    }
    [self changeTheBackgroundHeight];
}

- (void)setTheUserValue{
    ZXUserValueModel * model = [[ZXUserValueModel alloc] init];
    model.waterValue = _totalWater;
    model.lastModifyDate = [NSDate date];
    model.userName = @"";
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
    [[NSUserDefaults standardUserDefaults] setValue:data forKey:@"TotalWater"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSTimeInterval)pleaseInsertStarTime:(NSDate *)starTime andInsertEndTime:(NSDate *)endTime{
    NSDate *date1 = starTime;
    NSTimeZone *zone1 = [NSTimeZone systemTimeZone];
    NSInteger interval1 = [zone1 secondsFromGMTForDate:date1];
    NSDate *localDate1 = [date1 dateByAddingTimeInterval:interval1];
    
    // 时间2
    NSDate *date2 = endTime;
    NSTimeZone *zone2 = [NSTimeZone systemTimeZone];
    NSInteger interval2 = [zone2 secondsFromGMTForDate:date2];
    NSDate *localDate2 = [date2 dateByAddingTimeInterval:interval2];
    
    // 时间2与时间1之间的时间差（秒）
    double dayTime = [localDate2 timeIntervalSinceReferenceDate]/60/60/24 - [localDate1 timeIntervalSinceReferenceDate]/60/60/24;
    return dayTime;
}


#pragma 检测是否打开通知
- (bool)checkUserNotificationEnable { // 判断用户是否允许接收通知
    if (@available(iOS 10.0, *)) {
        __block BOOL isOn = NO;
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            if (settings.notificationCenterSetting == UNNotificationSettingEnabled) {
                isOn = YES;
                NSLog(@"打开了通知");
            }else {
                isOn = NO;
                NSLog(@"关闭了通知");
                [self showNotificationAlertView];
            }
        }];
        return isOn;
    }else {
        if ([[UIApplication sharedApplication] currentUserNotificationSettings].types == UIUserNotificationTypeNone){
            NSLog(@"关闭了通知");
            [self showNotificationAlertView];
            return NO;
        }else {
            NSLog(@"打开了通知");
            return YES;
        }
    }
}

- (void)showNotificationAlertView {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"通知" message:@"未获得通知权限，请前去设置" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self goToAppSystemSetting];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    });
    
}

// 如果用户关闭了接收通知功能，该方法可以跳转到APP设置页面进行修改
- (void)goToAppSystemSetting {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIApplication *application = [UIApplication sharedApplication];
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([application canOpenURL:url]) {
            if (@available(iOS 10.0, *)) {
                if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
                    [application openURL:url options:@{} completionHandler:nil];
                }
            }else {
                [application openURL:url];
            }
        }
    });
}


@end
