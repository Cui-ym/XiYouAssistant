//
//  XYAAttendanceView.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/25.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYAAttendanceView.h"
#import "XYAAttendanceTableViewCell.h"
#import "Assistant-Bridging-Header.h"
#import "Masonry.h"

#define RGB(__r,__g,__b) [UIColor colorWithRed:(__r)/255.0 green:(__g)/255.0 blue:(__b)/255.0 alpha:1]

@interface XYAAttendanceView () <UITableViewDelegate, UITableViewDataSource, ChartViewDelegate, IChartAxisValueFormatter>

@property (nonatomic, strong) UIImageView *timeImageView;

@property (nonatomic, strong) UILabel *zhiLabel;

@property (nonatomic, strong) UIImageView *classImageView;

@property (nonatomic, strong) UIView *backView;

/// 饼状图
@property (nonatomic, strong) PieChartView *pieChartView;

@property (nonatomic, strong) NSArray *xTitles;

@property (nonatomic, strong) NSArray *colorArray;

/// 选择器
@property (nonatomic, strong) UIDatePicker *datePicker;

@property (nonatomic, strong) UIPickerView *pickerView;

@end

@implementation XYAAttendanceView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        
        
    }
    return self;
}

#pragma mark - TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

#pragma mark - tableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XYAAttendanceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"noButtonCell" forIndexPath:indexPath];
    cell.timeLabel.text = @"2018.06.06";
    cell.weekLabel.text = @"星期三";
    cell.tagLabel.text = @"1-2";
    cell.classLabel.text = @"FZ155";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *array = [NSArray arrayWithObjects:@"正常", @"请假", @"正常", @"旷课", @"迟到", @"迟到", @"正常", @"正常", @"正常", @"正常", nil];
    cell.detailLabel.text = array[indexPath.row];
    if([cell.detailLabel.text  isEqual: @"正常"]) {
        cell.appealButton.userInteractionEnabled = NO;
        cell.detailLabel.textColor = [UIColor greenColor];
        cell.appealButton.backgroundColor = [UIColor clearColor];
    } else if ([cell.detailLabel.text isEqual:@"请假"]) {
        cell.appealButton.userInteractionEnabled = NO;
        cell.detailLabel.textColor = [UIColor yellowColor];
        cell.appealButton.backgroundColor = [UIColor clearColor];
    } else if ([cell.detailLabel.text isEqual:@"迟到"]) {
        cell.appealButton.userInteractionEnabled = NO;
        cell.detailLabel.textColor = [UIColor orangeColor];
        cell.appealButton.backgroundColor = [UIColor clearColor];
    } else if ([cell.detailLabel.text isEqual:@"旷课"]) {
        cell.appealButton.userInteractionEnabled = YES;
        cell.detailLabel.textColor = [UIColor redColor];
        cell.appealButton.backgroundColor = [UIColor redColor];
    }
    return cell;
}

#pragma mark - initUI

- (void)initUI {
    self.backgroundColor = [UIColor whiteColor];
    
    self.classImageView = [[UIImageView alloc] init];
    [self addSubview:_classImageView];
    
    self.timeImageView = [[UIImageView alloc] init];
    [self addSubview:_timeImageView];
    
    self.beginTimeButton = [[UIButton alloc] init];
    self.beginTimeButton.tag = 1001;
    [self addSubview:_beginTimeButton];
    
    self.endTimeButton = [[UIButton alloc] init];
    self.endTimeButton.tag = 1002;
    [self addSubview:_endTimeButton];
    
    self.classButton = [[UIButton alloc] init];
    self.classButton.tag = 1003;
    [self addSubview:_classButton];
    
    self.zhiLabel = [[UILabel alloc] init];
    [self addSubview:_zhiLabel];
    
    self.backView = [[UIView alloc] init];
    [self addSubview:_backView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.tableView registerClass:[XYAAttendanceTableViewCell class] forCellReuseIdentifier:@"noButtonCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [_backView addSubview:_tableView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.timeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.equalTo(self.mas_width).multipliedBy(0.051);
        make.top.equalTo(self.mas_bottom).multipliedBy(0.055);
        make.left.equalTo(self.mas_left).offset(15);
    }];
    self.timeImageView.image = [UIImage imageNamed:@"time_icon"];
    self.timeImageView.backgroundColor = [UIColor clearColor];
    
    [self.classImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width).multipliedBy(0.051);
        make.height.equalTo(self.mas_width).multipliedBy(0.051);
        make.top.equalTo(self.mas_bottom).multipliedBy(0.15);
        make.left.equalTo(self.mas_left).offset(15);
    }];
    self.classImageView.image = [UIImage imageNamed:@"class_icon"];
    self.classImageView.backgroundColor = [UIColor clearColor];
    self.classImageView.contentMode = UIViewContentModeScaleToFill;
    
    [self.beginTimeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left ).offset(60);
        make.width.equalTo(self.mas_width).multipliedBy(0.33);
        make.centerY.equalTo(self.timeImageView);
        make.height.equalTo(self.mas_height).multipliedBy(0.05);
    }];
    self.beginTimeButton.layer.masksToBounds = YES;
    self.beginTimeButton.backgroundColor = [UIColor whiteColor];
    self.beginTimeButton.layer.cornerRadius = self.frame.size.height * 0.025;
    self.beginTimeButton.layer.borderWidth = 3;
    self.beginTimeButton.layer.borderColor = [UIColor colorWithRed:0.36f green:0.68f blue:0.89f alpha:1.00f].CGColor;
    [self.beginTimeButton setTitleColor:[UIColor colorWithRed:0.36f green:0.68f blue:0.89f alpha:1.00f] forState:UIControlStateNormal];
    [self.beginTimeButton setTitle:@"18-09-01" forState:UIControlStateNormal];
    
    [self.endTimeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-15);
        make.width.equalTo(self.mas_width).multipliedBy(0.33);
        make.centerY.equalTo(self.timeImageView);
        make.height.equalTo(self.mas_height).multipliedBy(0.05);
    }];
    self.endTimeButton.layer.masksToBounds = YES;
    self.endTimeButton.layer.cornerRadius = self.frame.size.height * 0.025;
    self.endTimeButton.layer.borderWidth = 3;
    self.endTimeButton.layer.borderColor = [UIColor colorWithRed:0.36f green:0.68f blue:0.89f alpha:1.00f].CGColor;
    [self.endTimeButton setTitleColor:[UIColor colorWithRed:0.36f green:0.68f blue:0.89f alpha:1.00f] forState:UIControlStateNormal];
    [self.endTimeButton setTitle:@"18-09-30" forState:UIControlStateNormal];
    
    [self.zhiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.beginTimeButton.mas_right);
        make.right.equalTo(self.endTimeButton.mas_left);
        make.top.and.bottom.equalTo(self.beginTimeButton);
    }];
    self.zhiLabel.textColor = [UIColor blackColor];
    self.zhiLabel.text = @"至";
    self.zhiLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.classButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.beginTimeButton.mas_left);
        make.right.equalTo(self.endTimeButton.mas_right);
        make.centerY.equalTo(self.classImageView);
        make.height.equalTo(self.beginTimeButton);
    }];
    self.classButton.layer.masksToBounds = YES;
    self.classButton.layer.cornerRadius = self.frame.size.height * 0.025;
    self.classButton.layer.borderWidth = 3;
    self.classButton.layer.borderColor = [UIColor colorWithRed:0.36f green:0.68f blue:0.89f alpha:1.00f].CGColor;
    [self.classButton setTitleColor:[UIColor colorWithRed:0.36f green:0.68f blue:0.89f alpha:1.00f] forState:UIControlStateNormal];
    [self.classButton setTitle:@"C语言程序设计" forState:UIControlStateNormal];
    
    [self.pieChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.and.height.equalTo(self.mas_width).multipliedBy(0.65);
        make.top.equalTo(self.mas_bottom).multipliedBy(0.2);
    }];
    [self setData];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.mas_height).multipliedBy(0.3);
        make.centerX.equalTo(self);
        make.width.equalTo(self.mas_width).multipliedBy(0.925);
        make.bottom.equalTo(self.mas_bottom).offset(-80);
    }];
    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.backView.layer.shadowOpacity = 0.5f;
    self.backView.layer.shadowRadius = 10.0f;
    self.backView.layer.shadowOffset = CGSizeMake(0,0);
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.backView);
        make.top.equalTo(self.backView).offset(20);
        make.bottom.equalTo(self.backView).offset(-20);
    }];
    self.tableView.bounces = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    
}
- (void)viewAddPickerView:(NSString *)type {
    if ([type isEqual:@"time"]) {
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.backgroundColor = [UIColor whiteColor];
        self.datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        self.datePicker.datePickerMode = UIDatePickerModeDate;
        [self.datePicker setMinimumDate:[NSDate date]];
        NSDate *date = [NSDate date];
        [self addSubview:_datePicker];
    }
}

#pragma mark - PeiChartView
- (void)setData
{
    
    double mult = 4;
    NSArray *array = [NSArray arrayWithObjects:@"正常", @"迟到", @"旷课", @"请假", nil];
    NSMutableArray *values = [[NSMutableArray alloc] init];
    for (int i = 0; i < 4; i++) {
        [values addObject:[[PieChartDataEntry alloc] initWithValue:(arc4random_uniform(mult + 1)) label:array[i]]];
    }
    
    PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithValues:values label:@""];
    dataSet.sliceSpace = 2.0;
    
    // add a lot of colors
    
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    [colors addObjectsFromArray:ChartColorTemplates.vordiplom];
    [colors addObjectsFromArray:ChartColorTemplates.joyful];
    [colors addObjectsFromArray:ChartColorTemplates.colorful];
    [colors addObjectsFromArray:ChartColorTemplates.liberty];
    [colors addObjectsFromArray:ChartColorTemplates.pastel];
    [colors addObject:[UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]];
    
    dataSet.colors = colors;
    
    PieChartData *data = [[PieChartData alloc] initWithDataSet:dataSet];
    
    NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
    pFormatter.numberStyle = NSNumberFormatterPercentStyle;
    pFormatter.maximumFractionDigits = 1;
    pFormatter.multiplier = @1.f;
    pFormatter.percentSymbol = @" %";
    [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:pFormatter]];
    [data setValueFont:[UIFont systemFontOfSize:12 weight:UIFontWeightMedium]];
    [data setValueTextColor:UIColor.whiteColor];
    
    _pieChartView.data = data;
    [_pieChartView highlightValues:nil];
    
    
    
}

#pragma mark - ChartView x-Titles Datasource
- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis
{
    return self.xTitles[(int)value % self.xTitles.count];
}
#pragma mark - ChartView Delegate
- (void)chartScaled:(ChartViewBase *)chartView scaleX:(CGFloat)scaleX scaleY:(CGFloat)scaleY
{
    NSLog(@"%2f %2f", scaleX, scaleY);
}

- (void)chartValueSelected:(ChartViewBase *)chartView entry:(ChartDataEntry *)entry highlight:(ChartHighlight *)highlight
{
    
}

#pragma mark - getter and setter
- (PieChartView *)pieChartView
{
    if (_pieChartView == nil) {
        
        _pieChartView = [[PieChartView alloc] init];
        [self addSubview:_pieChartView];
        [_pieChartView animateWithXAxisDuration:1 easingOption:ChartEasingOptionEaseInSine];
        _pieChartView.delegate = self;
        _pieChartView.rotationAngle = -90.0;
        
        ChartLegend *legend = _pieChartView.legend;
        legend.horizontalAlignment = ChartLegendHorizontalAlignmentRight;
        legend.verticalAlignment = ChartLegendVerticalAlignmentTop;
        legend.orientation = ChartLegendOrientationVertical;
        legend.drawInside = NO;
        legend.xEntrySpace = 7.0;
        legend.yEntrySpace = 0.0;
        legend.yOffset = 0.0;
        
        // entry label styling
        _pieChartView.entryLabelColor = UIColor.whiteColor;
        _pieChartView.entryLabelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.f];
        
        _pieChartView.drawCenterTextEnabled = YES;
        _pieChartView.drawHoleEnabled = YES;
        NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        paragraphStyle.lineBreakMode =NSLineBreakByTruncatingTail;
        paragraphStyle.alignment = NSTextAlignmentCenter;
        NSMutableAttributedString *centerText = [[NSMutableAttributedString alloc] initWithString:@"abcdefg"];
        [centerText setAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:12 weight:UIFontWeightMedium], NSParagraphStyleAttributeName: paragraphStyle, NSForegroundColorAttributeName: [UIColor orangeColor] } range:NSMakeRange(0, centerText.length)];
        _pieChartView.centerAttributedText = centerText;
    }
    return _pieChartView;
}

- (NSArray *)colorArray
{
    if (_colorArray == nil) { //橘黄色  蓝色 淡绿色 浅紫色 浅红色
        _colorArray = @[ RGB(242, 152, 80), RGB(92, 178, 240), RGB(158, 202, 97), RGB(219, 95, 153), RGB(233, 84, 83)];
    }
    return _colorArray;
}

- (NSArray *)xTitles
{
    if (_xTitles == nil) {
        
        _xTitles = @[@"正常", @"迟到", @"旷课", @"请假"];
    }
    return _xTitles;
}

@end
