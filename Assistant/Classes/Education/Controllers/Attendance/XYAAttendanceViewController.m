//
//  XYAAttendanceViewController.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/21.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYAAttendanceViewController.h"
#import "XYAAttendanceView.h"

@interface XYAAttendanceViewController ()

@property (nonatomic, strong) XYAAttendanceView *attendanceView;

@end

@implementation XYAAttendanceViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"考勤信息";
    self.attendanceView = [[XYAAttendanceView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:_attendanceView];
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
