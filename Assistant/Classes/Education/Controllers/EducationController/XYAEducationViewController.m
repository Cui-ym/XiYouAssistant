//
//  XYAEducationViewController.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/20.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYAEducationViewController.h"
#import "XYAEducationView.h"
#import "XYAAttendanceViewController.h"
#import "XYACETViewController.h"
#import "XYAComputerViewController.h"
#import "XYAGradesViewController.h"
#import "XYAClassTableViewController.h"
#import "XYAEducationAPI.h"
#import "XYAEducationManager.h"

@interface XYAEducationViewController ()<XYAEducationViewDelegate>

@property (nonatomic, strong) XYAEducationView *educationView;
@property (nonatomic, strong) XYAAttendanceViewController *attendanceViewController;
@property (nonatomic, strong) XYACETViewController *CETViewController;
@property (nonatomic, strong) XYAComputerViewController *computerViewController;
@property (nonatomic, strong) XYAGradesViewController *gradesViewController;
@property (nonatomic, strong) XYAClassTableViewController *classTableViewController;

@property (nonatomic, strong) XYAEducationAPI *educationAPI;
@property (nonatomic, strong) XYAEducationManager *manager;

@property (nonatomic, strong) NSMutableArray *termArray;
@property (nonatomic, strong) NSMutableArray *termBeginTimeArray;
@property (nonatomic, strong) NSMutableDictionary *termTimeDictionary;
@property (nonatomic, assign) NSInteger week;
@property (nonatomic, assign) NSInteger nowWeekday;
@end

@implementation XYAEducationViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"教务";
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    self.educationView = [[XYAEducationView alloc] initWithFrame:self.view.frame];
    self.educationView.delegate = self;
    
    [self getTermAndWeek];
    
    [self.view addSubview:_educationView];
    
}

#pragma mark - HTTP

// 得到学段信息
- (void)getTermAndWeek {
    self.educationAPI = [XYAEducationAPI shareEducationAPI];
    // 获取学期段信息
    [self.educationAPI getTermList];
    _manager = [XYAEducationManager educationManager];
    [_manager fetchEducationResultWithEducationAPI:_educationAPI success:^(XYAEducationResultModel * _Nullable educationResult) {
        
        self.termArray = [NSMutableArray array];
        self.termTimeDictionary = [NSMutableDictionary dictionary];
        NSArray *array = (NSArray *)educationResult.Obj;
        for (id obj in array) {
            [self.termArray addObject:obj[@"NAME"]];
            [self.termTimeDictionary setObject:obj[@"ENDDATE"] forKey:obj[@"STARTDATE"]];
        }
        self.termBeginTimeArray = [NSMutableArray arrayWithArray:[[self.termTimeDictionary allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]];
        [self weekNumberWithFromdate:self.termBeginTimeArray[3]];
        
        // 获取本学期所有课表
        [self getAllTermLessonTable];
    } error:^(NSError * _Nonnull error) {
        NSLog(@"error:::::%@", error);
    }];
}

// 请求课程表
- (void)getLessonTableWithWeek:(NSInteger)week {
    _manager = [XYAEducationManager educationManager];
    [_manager fetchEducationClassTableWithTermNumber:self.termArray[0] week:week success:^(XYAEducationClassTableModel * _Nullable educationClassTable) {
        NSLog(@"课表信息：：：%@", [educationClassTable Obj]);
    } error:^(NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - lessonTable

- (void)getAllTermLessonTable {
    for (NSInteger i = 2; i <= 20; i++) {
        [self getLessonTableWithWeek:i];
    }
}

#pragma mark - Week
// 计算现在是第几周 周几
- (void)weekNumberWithFromdate:(NSString *)fromDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *startDate = [dateFormatter dateFromString:fromDate];
    
    NSString *string = @"2018-03-11";
    NSDate *nowDate = [dateFormatter dateFromString:string];
    
    NSTimeInterval time = [nowDate timeIntervalSinceDate:startDate];
    NSInteger days = ((NSInteger)time) / (3600 * 24);
    
    // 获取星期几
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *startComponents = [calendar components:calendarUnit fromDate:startDate];
    NSInteger startWeekday = startComponents.weekday - 1;
    NSDateComponents *nowComponents = [calendar components:calendarUnit fromDate:nowDate];
    NSInteger nowWeekday = nowComponents.weekday - 1;
    
    // 获取当前是第几周
    NSInteger week = 1;
    NSInteger first = 7 - startWeekday;
    NSInteger temp = days - first;
    if (temp < 7) {
        week = 1;
    } else {
        week += temp / 7;
        if (nowWeekday >= 1) {
            week += 1;
        }
    }
    NSLog(@"起始日期：%@  当前日期：%@  相差天数：%ld 当前周数：%ld 起始星期：%ld  当前星期：%ld", fromDate, string, days, week, startWeekday, nowWeekday);
    
    self.week = week;
    self.nowWeekday = nowWeekday;
    
    // 获取课程表
    [self getLessonTableWithWeek:self.week];
}

#pragma mark - XYAEducationViewDelegate

- (void)selectedCellWithtype:(NSString *)type {
    if ([type isEqual:@"考勤查询"]) {
        self.attendanceViewController = [[XYAAttendanceViewController alloc] init];
        [self.navigationController pushViewController:_attendanceViewController animated:YES];
    } else if ([type isEqual:@"CET"]) {
        self.CETViewController = [[XYACETViewController alloc] init];
        [self.navigationController pushViewController:_CETViewController animated:YES];
    } else if ([type isEqual:@"期末成绩"]) {
        self.gradesViewController = [[XYAGradesViewController alloc] init];
        [self.navigationController pushViewController:_gradesViewController animated:YES];
    } else if ([type isEqual:@"计算机二级"]) {
        self.computerViewController = [[XYAComputerViewController alloc] init];
        [self.navigationController pushViewController:_computerViewController animated:YES];
    } else if ([type isEqual:@"课表"]) {
        self.classTableViewController = [[XYAClassTableViewController alloc] init];
        [self.navigationController pushViewController:_classTableViewController animated:YES];
    } else if ([type isEqual:@"无课教室"]) {
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
