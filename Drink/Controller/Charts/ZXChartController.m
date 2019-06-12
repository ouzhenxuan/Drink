//
//  ZXChartController.m
//  Drink
//
//  Created by 区振轩 on 2019/4/18.
//  Copyright © 2019 区振轩. All rights reserved.
//

#import "ZXChartController.h"
#import "Drink-Swift.h"
#import "ZXDatabase.h"
#import "ZXDrinkDatabaseTool.h"


@interface ZXChartController ()<ChartViewDelegate>

@property (nonatomic, strong) IBOutlet LineChartView *chartView;
@property (nonatomic, strong) IBOutlet UISlider *sliderX;               ///< 数据数量c
@property (nonatomic, strong) IBOutlet UISlider *sliderY;               ///< 数据随机大小
@property (nonatomic, strong) IBOutlet UITextField *sliderTextX;
@property (nonatomic, strong) IBOutlet UITextField *sliderTextY;


@end

@implementation ZXChartController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getFMDBData];
    self.view.backgroundColor = [UIColor whiteColor];
    _chartView = [[LineChartView alloc] initWithFrame:CGRectMake(0, 0, ScreenBoundsWidth, 500)];
    _sliderX = [[UISlider alloc] init];
    [_sliderX addTarget:self action:@selector(slidersValueChanged:) forControlEvents:UIControlEventValueChanged];
    _sliderY = [[UISlider alloc] init];
    [_sliderY addTarget:self action:@selector(slidersValueChanged:) forControlEvents:UIControlEventValueChanged];
    _sliderTextX = [[UITextField alloc] init];
    _sliderTextY = [[UITextField alloc] init];
    
    [self.view addSubview:_chartView];
    
    self.title = @"Line Chart 1";
    
    self.options = @[
                     @{@"key": @"toggleValues", @"label": @"Toggle Values"},
                     @{@"key": @"toggleFilled", @"label": @"Toggle Filled"},
                     @{@"key": @"toggleCircles", @"label": @"Toggle Circles"},
                     @{@"key": @"toggleCubic", @"label": @"Toggle Cubic"},
                     @{@"key": @"toggleHorizontalCubic", @"label": @"Toggle Horizontal Cubic"},
                     @{@"key": @"toggleIcons", @"label": @"Toggle Icons"},
                     @{@"key": @"toggleStepped", @"label": @"Toggle Stepped"},
                     @{@"key": @"toggleHighlight", @"label": @"Toggle Highlight"},
                     @{@"key": @"animateX", @"label": @"Animate X"},
                     @{@"key": @"animateY", @"label": @"Animate Y"},
                     @{@"key": @"animateXY", @"label": @"Animate XY"},
                     @{@"key": @"saveToGallery", @"label": @"Save to Camera Roll"},
                     @{@"key": @"togglePinchZoom", @"label": @"Toggle PinchZoom"},
                     @{@"key": @"toggleAutoScaleMinMax", @"label": @"Toggle auto scale min/max"},
                     @{@"key": @"toggleData", @"label": @"Toggle Data"},
                     ];
    
    _chartView.delegate = self;
    
    _chartView.chartDescription.enabled = NO;
    
    _chartView.dragEnabled = YES;
    [_chartView setScaleEnabled:YES];
    _chartView.pinchZoomEnabled = YES;
    _chartView.drawGridBackgroundEnabled = NO;
    
    // x-axis limit line
//    ChartLimitLine *llXAxis = [[ChartLimitLine alloc] initWithLimit:10.0 label:@"Index 10"];
//    llXAxis.lineWidth = 4.0;
//    llXAxis.lineDashLengths = @[@(10.f), @(10.f), @(0.f)];
//    llXAxis.labelPosition = ChartLimitLabelPositionBottomRight;
//    llXAxis.valueFont = [UIFont systemFontOfSize:10.f];
    
//    [_chartView.xAxis addLimitLine:llXAxis];
    
//    _chartView.xAxis.gridLineDashLengths = @[@10.0, @10.0];
//    _chartView.xAxis.gridLineDashPhase = 0.f;
    

//    对x轴的设计
    ChartXAxis*xAxis =_chartView.xAxis;
//    xAxis.
    xAxis.axisLineColor = [UIColor lightGrayColor];
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.labelFont = [UIFont systemFontOfSize:12];
    xAxis.labelTextColor = [UIColor lightGrayColor];
    xAxis.axisMinimum = 0.3;  // label间距
    xAxis.granularity = 1.0;
    xAxis.axisMinimum = 100;
    xAxis.drawAxisLineEnabled = YES; //是否画x轴线
    xAxis.drawGridLinesEnabled = NO;    //是否画网格
    xAxis.labelCount = 10;//x轴上的个数
    
//    对Y轴的设计
    ChartYAxis *leftAxis = _chartView.leftAxis;
    [leftAxis removeAllLimitLines];
//    [leftAxis addLimitLine:ll1];
//    [leftAxis addLimitLine:ll2];
    leftAxis.axisMaximum = 200.0;
    leftAxis.axisMinimum = -50.0;
    leftAxis.gridLineDashLengths = @[@5.f, @5.f];
    leftAxis.drawZeroLineEnabled = NO;
    leftAxis.drawLimitLinesBehindDataEnabled = YES;
    
    _chartView.rightAxis.enabled = NO;
    
    //[_chartView.viewPortHandler setMaximumScaleY: 2.f];
    //[_chartView.viewPortHandler setMaximumScaleX: 2.f];
    
    ///< 显示数值的气泡
    BalloonMarker *marker = [[BalloonMarker alloc]
                             initWithColor: [UIColor colorWithWhite:180/255. alpha:1.0]
                             font: [UIFont systemFontOfSize:12.0]
                             textColor: UIColor.whiteColor
                             insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)];
    marker.chartView = _chartView;
    marker.minimumSize = CGSizeMake(80.f, 40.f);
    _chartView.marker = marker;
    
    _chartView.legend.form = ChartLegendFormLine;
    
    _chartView.legend.form = ChartLegendFormNone;   //说明图
    _chartView.dragEnabled = NO; //拖动手势
    _chartView.pinchZoomEnabled = NO; //捏合手势
    _chartView.rightAxis.enabled = NO; //隐藏右Y轴
    _chartView.chartDescription.enabled = NO; //不显示描述label
    _chartView.doubleTapToZoomEnabled = NO; //禁止双击缩放      _linechartView.drawGridBackgroundEnabled = NO;
    _chartView.drawBordersEnabled= NO;
    _chartView.dragEnabled = YES;//拖动气泡
    [_chartView animateWithXAxisDuration:2.20 easingOption:ChartEasingOptionEaseOutBack]; //加载动画时长
    
    ///< 上下限制线
    //    ChartLimitLine *ll1 = [[ChartLimitLine alloc] initWithLimit:150.0 label:@"Upper Limit"];
    //    ll1.lineWidth = 4.0;
    //    ll1.lineDashLengths = @[@5.f, @5.f];
    //    ll1.labelPosition = ChartLimitLabelPositionTopRight;
    //    ll1.valueFont = [UIFont systemFontOfSize:10.0];
    
    //    ChartLimitLine *ll2 = [[ChartLimitLine alloc] initWithLimit:-30.0 label:@"Lower Limit"];
    //    ll2.lineWidth = 4.0;
    //    ll2.lineDashLengths = @[@5.f, @5.f];
    //    ll2.labelPosition = ChartLimitLabelPositionBottomRight;
    //    ll2.valueFont = [UIFont systemFontOfSize:10.0];
    
    _sliderX.maximumValue = 1500;
    _sliderY.maximumValue = 150;
    _sliderX.value = 45.0;
    _sliderY.value = 100.0;
    
    
    [self slidersValueChanged:nil];
    
    [_chartView animateWithXAxisDuration:2.5];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _sliderX.value = 46.0;
    _sliderY.value = 101.0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateChartData
{
    if (self.shouldHideData)
    {
        _chartView.data = nil;
        return;
    }
    
    [self setDataCount:10 range:_sliderY.value];
//    [self setDataCount:_sliderX.value range:_sliderY.value];
}

- (void)setDataCount:(int)count range:(double)range
{
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        double val = arc4random_uniform(range) + 3;
        [values addObject:[[ChartDataEntry alloc] initWithX:i+100 y:val icon: [UIImage imageNamed:@"chooser-button-input"]]];
//        [values addObject:[[ChartDataEntry alloc] initWithX:i y:val icon: [UIImage imageNamed:@"icon"]]];
    }
    
    LineChartDataSet *set1 = nil;
    if (_chartView.data.dataSetCount > 0)
    {
        set1 = (LineChartDataSet *)_chartView.data.dataSets[0];
        [set1 replaceEntries: values];
        [_chartView.data notifyDataChanged];
        [_chartView notifyDataSetChanged];
    }
    else
    {
        set1 = [[LineChartDataSet alloc] initWithEntries:values label:@"DataSet 1"];
        
        set1.drawIconsEnabled = NO;
        
        set1.lineDashLengths = @[@5.f, @2.5f];
        set1.highlightLineDashLengths = @[@5.f, @2.5f];
        [set1 setColor:UIColor.blackColor];
        [set1 setCircleColor:UIColor.blackColor];
        set1.lineWidth = 1.0;
        set1.circleRadius = 3.0;
        set1.drawCircleHoleEnabled = NO;
        set1.valueFont = [UIFont systemFontOfSize:9.f];
        set1.formLineDashLengths = @[@5.f, @2.5f];
        set1.formLineWidth = 1.0;
        set1.formSize = 15.0;
        
        NSArray *gradientColors = @[
                                    (id)[ChartColorTemplates colorFromString:@"#00ff0000"].CGColor,
                                    (id)[ChartColorTemplates colorFromString:@"#ffff0000"].CGColor
                                    ];
        CGGradientRef gradient = CGGradientCreateWithColors(nil, (CFArrayRef)gradientColors, nil);
        
        set1.fillAlpha = 1.f;
        set1.fill = [ChartFill fillWithLinearGradient:gradient angle:90.f];
        set1.drawFilledEnabled = YES;
        
        CGGradientRelease(gradient);
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
        
        _chartView.data = data;
    }
}

- (void)optionTapped:(NSString *)key
{
    if ([key isEqualToString:@"toggleFilled"])
    {
        for (id<ILineChartDataSet> set in _chartView.data.dataSets)
        {
            set.drawFilledEnabled = !set.isDrawFilledEnabled;
        }
        
        [_chartView setNeedsDisplay];
        return;
    }
    
    if ([key isEqualToString:@"toggleCircles"])
    {
        for (id<ILineChartDataSet> set in _chartView.data.dataSets)
        {
            set.drawCirclesEnabled = !set.isDrawCirclesEnabled;
        }
        
        [_chartView setNeedsDisplay];
        return;
    }
    
    if ([key isEqualToString:@"toggleCubic"])
    {
        for (id<ILineChartDataSet> set in _chartView.data.dataSets)
        {
            set.mode = set.mode == LineChartModeCubicBezier ? LineChartModeLinear : LineChartModeCubicBezier;
        }
        
        [_chartView setNeedsDisplay];
        return;
    }
    
    if ([key isEqualToString:@"toggleStepped"])
    {
        for (id<ILineChartDataSet> set in _chartView.data.dataSets)
        {
            switch (set.mode) {
                case LineChartModeLinear:
                case LineChartModeCubicBezier:
                case LineChartModeHorizontalBezier:
                    set.mode = LineChartModeStepped;
                    break;
                case LineChartModeStepped: set.mode = LineChartModeLinear;
            }
        }
        
        [_chartView setNeedsDisplay];
    }
    
    if ([key isEqualToString:@"toggleHorizontalCubic"])
    {
        for (id<ILineChartDataSet> set in _chartView.data.dataSets)
        {
            set.mode = set.mode == LineChartModeHorizontalBezier ? LineChartModeCubicBezier : LineChartModeHorizontalBezier;
        }
        
        [_chartView setNeedsDisplay];
        return;
    }
    
    [super handleOption:key forChartView:_chartView];
}

#pragma mark - Actions

- (IBAction)slidersValueChanged:(id)sender
{
    _sliderTextX.text = [@((int)_sliderX.value) stringValue];
    _sliderTextY.text = [@((int)_sliderY.value) stringValue];
    
    [self updateChartData];
}

#pragma mark - ChartViewDelegate

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry highlight:(ChartHighlight * __nonnull)highlight
{
    NSLog(@"chartValueSelected");
}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView
{
    NSLog(@"chartValueNothingSelected");
}

-(void)getFMDBData{
    NSArray * arr =  [ZXDrinkDatabaseTool allModelsWithUserId:APPLICATION_UUID] ;
    NSLog(@"asd");
    
    
    
}
@end
