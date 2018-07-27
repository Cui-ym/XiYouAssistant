//
//  XYAEducationView.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/20.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYAEducationView.h"
#import "XYATimetableTableViewCell.h"

@interface XYAEducationView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) XYATimetableTableViewCell *timetableViewCell;


@end

@implementation XYAEducationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStyleGrouped];
        [self.tableView registerClass:[XYATimetableTableViewCell class] forCellReuseIdentifier:@"timetable"];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self addSubview:_tableView];
        
        NSLog(@"%lf", self.frame.size.width);
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark - tableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 0.3 * self.frame.size.height;
    }
    return 0.07 * self.frame.size.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *array0 = [NSArray arrayWithObjects:@"占位", @"考勤查询", nil];
    NSArray *array1 = [NSArray arrayWithObjects:@"CET", @"期末成绩", @"计算机二级", nil];
    NSArray *array2 = [NSArray arrayWithObjects:@"课表", @"无课教室", nil];
    NSMutableArray *cellArray = [NSMutableArray array];
    [cellArray addObject:array0];
    [cellArray addObject:array1];
    [cellArray addObject:array2];
    if ([_delegate respondsToSelector:@selector(selectedCellWithtype:)]) {
            [_delegate selectedCellWithtype:cellArray[indexPath.section][indexPath.row]];
    }
}

#pragma mark - tableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    if (indexPath.section == 0 && indexPath.row == 0) {
        self.timetableViewCell = [tableView dequeueReusableCellWithIdentifier:@"timetable" forIndexPath:indexPath];
        return _timetableViewCell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (indexPath.section == 0 && indexPath.row == 1) {
            cell.textLabel.text = @"考勤查询";
        } else if (indexPath.section == 1) {
            NSArray *array = [NSArray arrayWithObjects:@"四/六级成绩查询", @"期末考试成绩/绩点查询", @"计算机等级考试成绩查询", nil];
            cell.textLabel.text = array[indexPath.row];
        } else {
            NSArray *array = [NSArray arrayWithObjects:@"课表查询", @"无课教室查询", nil];
            cell.textLabel.text = array[indexPath.row];
        }
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger number = 1;
    switch (section) {
        case 0:
            number = 2;
            break;
            
        case 1:
            number = 3;
            break;
            
        default:
            number = 2;
            break;
    }
    return number;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

@end
