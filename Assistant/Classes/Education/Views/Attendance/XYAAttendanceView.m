//
//  XYAAttendanceView.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/25.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYAAttendanceView.h"
#import "XYAAttendanceTableViewCell.h"
#import "Masonry.h"

@interface XYAAttendanceView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIImageView *timeImageView;

@property (nonatomic, strong) UILabel *zhiLabel;

@property (nonatomic, strong) UIImageView *classImageView;

@property (nonatomic, strong) UIView *backView;

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
    [self addSubview:_beginTimeButton];
    
    self.endTimeButton = [[UIButton alloc] init];
    [self addSubview:_endTimeButton];
    
    self.classButton = [[UIButton alloc] init];
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
    [self.beginTimeButton setTitle:@"09-01" forState:UIControlStateNormal];
    
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
    [self.endTimeButton setTitle:@"09-30" forState:UIControlStateNormal];
    
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


@end
