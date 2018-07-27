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

@interface XYAEducationViewController ()<XYAEducationViewDelegate>

@property (nonatomic, strong) XYAEducationView *educationView;
@property (nonatomic, strong) XYAAttendanceViewController *attendanceViewController;
@property (nonatomic, strong) XYACETViewController *CETViewController;

@end

@implementation XYAEducationViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

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
    [self.view addSubview:_educationView];
    
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
        
    } else if ([type isEqual:@"计算机二级"]) {
        
    } else if ([type isEqual:@"课表"]) {
        
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
