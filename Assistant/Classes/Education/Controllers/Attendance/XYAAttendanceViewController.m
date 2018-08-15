//
//  XYAAttendanceViewController.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/21.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYAAttendanceViewController.h"
#import "XYAAppealViewController.h"
#import "XYAAttendanceView.h"

@interface XYAAttendanceViewController () <XYAAttendanceViewDelegate>

@property (nonatomic, strong) XYAAttendanceView *attendanceView;

@end

@implementation XYAAttendanceViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"考勤信息";
    self.attendanceView = [[XYAAttendanceView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.attendanceView.delegate = self;
    [self.attendanceView.beginTimeButton addTarget:self action:@selector(clickAttendanceButton:) forControlEvents:UIControlEventTouchUpInside];
    self.attendanceView.beginTimeButton.tag = 100001;
    [self.attendanceView.endTimeButton addTarget:self action:@selector(clickAttendanceButton:) forControlEvents:UIControlEventTouchUpInside];
    self.attendanceView.endTimeButton.tag = 100002;
    [self.attendanceView.classButton addTarget:self action:@selector(clickAttendanceButton:) forControlEvents:UIControlEventTouchUpInside];
    self.attendanceView.classButton.tag = 100003;
    [self.view addSubview:_attendanceView];
}

#pragma mark - clickAction

- (void)clickAttendanceButton:(UIButton *)sender {
    if (sender.tag == 100003) {
        [self.attendanceView viewAddPickerViewWithType:@"picker" buttonTag:sender.tag];
    } else {
        [self.attendanceView viewAddPickerViewWithType:@"time" buttonTag:sender.tag];
    }
}

#pragma mark - AttendanceDelegate
- (void)pushAppealViewController:(NSDictionary *)dictionary {
    NSLog(@"%@", dictionary);
    XYAAppealViewController *appealViewController = [[XYAAppealViewController alloc] init];
    [self.navigationController pushViewController:appealViewController animated:YES];
}

#pragma mark - pickerViewDelegate

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
