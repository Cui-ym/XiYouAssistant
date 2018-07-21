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

@interface XYAEducationViewController ()<XYAEducationViewDelegate>

@property (nonatomic, strong) XYAEducationView *educationView;
@property (nonatomic, strong) XYAAttendanceViewController *attendanceViewController;

@end

@implementation XYAEducationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"教务";
    self.educationView = [[XYAEducationView alloc] initWithFrame:self.view.frame];
    self.educationView.delegate = self;
    [self.view addSubview:_educationView];
    
}

#pragma mark - XYAEducationViewDelegate

- (void)selectedAttendanceCell {
    self.attendanceViewController = [[XYAAttendanceViewController alloc] init];
    [self.navigationController pushViewController:_attendanceViewController animated:YES];
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
