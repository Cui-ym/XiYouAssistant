//
//  XYAAttendanceViewController.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/21.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYAAttendanceViewController.h"
#import "XYAAttendanceView.h"

@interface XYAAttendanceViewController ()<UITableViewDelegate, UITableViewDataSource>

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
    self.attendanceView.tableView.delegate = self;
    self.attendanceView.tableView.dataSource = self;
    [self.view addSubview:_attendanceView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30.0;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    NSArray *array = [NSArray arrayWithObjects:@"aaaa", @"bbbb", @"cccc", @"dddd", @"eeee", @"aaaa", @"bbbb", @"cccc", @"dddd", @"eeee", nil];
    cell.textLabel.text = array[indexPath.row];
    return cell;
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
