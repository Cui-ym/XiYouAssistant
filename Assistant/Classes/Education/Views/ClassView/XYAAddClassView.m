//
//  XYAAddClassView.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/8/1.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYAAddClassView.h"
#import "XYAAddClassTableViewCell.h"
#import "Masonry.h"

@interface XYAAddClassView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *classNameView;

@property (nonatomic, strong) UILabel *classNameLabel;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIView *whiteBackgroundView;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation XYAAddClassView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1.00f];
        
        [self initClassNameView];
        
        [self initWhiteBackgroundView];
        
        self.saveButton = [[UIButton alloc] init];
        [self addSubview:_saveButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_bottom).multipliedBy(0.7);
        make.centerX.equalTo(self);
        make.width.equalTo(self.mas_width).multipliedBy(0.93);
        make.height.equalTo(self.mas_height).multipliedBy(0.075);
    }];
    self.saveButton.backgroundColor = [UIColor colorWithRed:0.20f green:0.60f blue:0.86f alpha:1.00f];
    [self.saveButton setTitle:@"保            存" forState:UIControlStateNormal];
    self.saveButton.layer.cornerRadius = 15;
}

#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0.16 * 0.45 * self.frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XYAAddClassTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSArray *imageArray = [NSArray arrayWithObjects:@"icon_lesson_class", @"icon_lesson_week", @"icon_lesson_number", @"icon_lesson_teacher", nil];
    NSArray *titleArray = [NSArray arrayWithObjects:@"地点", @"周数", @"节数", @"老师", nil];
    cell.iconImageview.image = [UIImage imageNamed:imageArray[indexPath.row]];
    cell.titleLabel.text = titleArray[indexPath.row];
    if (indexPath.row == 0 || indexPath.row == 3) {
        NSArray *array = @[@"请输入地点", @"", @"", @"未填写"];
        cell.detailTextField.placeholder = array[indexPath.row];
    } else {
        NSArray *array = @[@"", @"1-20周", @"请选择", @""];
        cell.detailTextField.text = array[indexPath.row];
    }
    return cell;
}

#pragma mark - init

- (void)initWhiteBackgroundView {
    self.whiteBackgroundView = [[UIView alloc] init];
    [self addSubview:_whiteBackgroundView];
    self.whiteBackgroundView.backgroundColor = [UIColor whiteColor];
    [self.whiteBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.classNameView);
        make.top.equalTo(self.mas_bottom).multipliedBy(0.187);
        make.height.equalTo(self.mas_height).multipliedBy(0.45);
    }];
    self.whiteBackgroundView.layer.cornerRadius = 15;
    self.whiteBackgroundView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.whiteBackgroundView.layer.shadowOpacity = 0.5;
    self.whiteBackgroundView.layer.shadowRadius = 5;
    self.whiteBackgroundView.layer.shadowOffset = CGSizeMake(0, 0);
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.whiteBackgroundView addSubview:_tableView];
    self.tableView.userInteractionEnabled = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.whiteBackgroundView);
        make.top.equalTo(self.whiteBackgroundView.mas_bottom).multipliedBy(0.16);
        make.height.equalTo(self.whiteBackgroundView.mas_height).multipliedBy(0.64);
    }];
    [self.tableView registerClass:[XYAAddClassTableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

- (void)initClassNameView {
    self.classNameView = [[UIView alloc] init];
    [self addSubview:_classNameView];
    [self.classNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_bottom).multipliedBy(0.05);
        make.width.equalTo(self.mas_width).multipliedBy(0.93);
        make.height.equalTo(self.mas_height).multipliedBy(0.075);
    }];
    self.classNameView.layer.cornerRadius = 15;
    self.classNameView.backgroundColor = [UIColor whiteColor];
    self.classNameView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.classNameView.layer.shadowOpacity = 0.5;
    self.classNameView.layer.shadowRadius = 5;
    self.classNameView.layer.shadowOffset = CGSizeMake(0,0);
    
    self.classNameLabel = [[UILabel alloc] init];
    [self.classNameView addSubview:_classNameLabel];
    [self.classNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.classNameView);
        make.width.equalTo(self.classNameView).multipliedBy(0.26);
        make.top.and.bottom.equalTo(self.classNameView);
    }];
    self.classNameLabel.textColor = [UIColor colorWithRed:0.20f green:0.60f blue:0.86f alpha:1.00f];
    self.classNameLabel.text = @"课名";
    self.classNameLabel.textAlignment = NSTextAlignmentCenter;
    
    self.lineView = [[UIView alloc] init];
    [self.classNameView addSubview:_lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.classNameLabel.mas_right);
        make.top.equalTo(self.classNameView.mas_top).offset(7);
        make.bottom.equalTo(self.classNameView.mas_bottom).offset(-7);
        make.width.mas_equalTo(1);
    }];
    self.lineView.backgroundColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.90f alpha:1.00f];
    
    self.classNameTextField = [[UITextField alloc] init];
    [self.classNameView addSubview:_classNameTextField];
    [self.classNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lineView.mas_right).offset(20);
        make.right.equalTo(self.classNameView.mas_right).offset(10);
        make.top.equalTo(self.classNameView.mas_top).offset(15);
        make.bottom.equalTo(self.classNameView.mas_bottom).offset(-15);
    }];
    self.classNameTextField.placeholder = @"请输入课程名称";
}





@end
