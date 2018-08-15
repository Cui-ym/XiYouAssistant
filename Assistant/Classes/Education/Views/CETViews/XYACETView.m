//
//  XYACETView.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/27.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYACETView.h"
#import "Masonry.h"
#import "XYAClipBackgroundView.h"
#import "XYAComputerVercodeView.h"
#import "XYAUnderLinerTextField.h"

@interface XYACETView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIImageView *userImageView;

@property (nonatomic, strong) UIImageView *numberImageView;

@property (nonatomic, strong) UITableView *scoreTableView;


@end

@implementation XYACETView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backView = [[XYAClipBackgroundView alloc] init];
        [self addSubview:_backView];
        
        self.userImageView = [[UIImageView alloc] init];
        [_backView.lineView addSubview:_userImageView];
        
        self.userTextField = [[XYAUnderLinerTextField alloc] init];
        [_backView.lineView addSubview:_userTextField];
        
        self.numberImageView = [[UIImageView alloc] init];
        [_backView.lineView addSubview:_numberImageView];
        
        self.numberTextField = [[XYAUnderLinerTextField alloc] init];
        [_backView.lineView addSubview:_numberTextField];
        
        self.queryButton = [[UIButton alloc] init];
        [_backView.lineView addSubview:_queryButton];
    }
    return self;
}

// 初始化验证码
- (void)initVercodeViewWithImageDate:(NSData *)imageData {
    self.vercodeView = [[XYAComputerVercodeView alloc] init];
    [_backView.lineView addSubview:_vercodeView];
    [self.vercodeView.vercodeImageView setImage:[UIImage imageWithData:imageData]];
    
    [self.vercodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.numberTextField.mas_left);
        make.width.equalTo(self.numberTextField.mas_width).multipliedBy(0.867);
        make.top.equalTo(self.backView.lineView.mas_bottom).multipliedBy(0.52);
        make.height.equalTo(self.backView.lineView.mas_height).multipliedBy(0.1);
    }];
    
}

// 显示成绩视图
- (void)showScoreWithScoreTableView {
    // 数组中每个元素都执行这个方法
    [_backView.lineView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.scoreTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.scoreTableView.delegate = self;
    self.scoreTableView.dataSource = self;
    [_backView.lineView addSubview:_scoreTableView];
    self.scoreTableView.userInteractionEnabled = NO;
    self.scoreTableView.backgroundColor = [UIColor whiteColor];
    
    [self.scoreTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backView.lineView.mas_bottom).multipliedBy(0.13);
        make.centerX.equalTo(_backView.lineView);
        make.height.equalTo(_backView.lineView.mas_height).multipliedBy(0.8);
        make.width.equalTo(_backView.lineView.mas_width).multipliedBy(0.7);
    }];
}

#pragma mark - layoutSubviews

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.00f];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self);
        make.top.and.bottom.equalTo(self);
    }];
    
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView.lineView.mas_left).offset(23);
        make.height.and.width.equalTo(_backView.lineView.mas_height).multipliedBy(0.08);
        make.top.equalTo(_backView.lineView.mas_bottom).multipliedBy(0.176);
    }];
    self.userImageView.image = [UIImage imageNamed:@"icon_CET_username"];
    self.userImageView.contentMode = UIViewContentModeScaleToFill;
    
    [self.userTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self.userImageView);
        make.left.equalTo(self.userImageView.mas_right).offset(15);
        make.width.equalTo(_backView.lineView).multipliedBy(0.55);
    }];
    self.userTextField.placeholder = @"请输入考生姓名";
    self.userTextField.font = [UIFont systemFontOfSize:14];
    
    [self.numberImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userImageView);
        make.height.and.width.equalTo(self.userImageView);
        make.top.equalTo(_backView.lineView.mas_bottom).multipliedBy(0.35);
    }];
    self.numberImageView.image = [UIImage imageNamed:@"icon_CET_number"];
    self.numberImageView.contentMode = UIViewContentModeScaleToFill;
    
    [self.numberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self.numberImageView);
        make.left.equalTo(self.numberImageView.mas_right).offset(15);
        make.width.equalTo(_backView.lineView).multipliedBy(0.55);
    }];
    self.numberTextField.placeholder = @"请输入准考证号";
    self.numberTextField.font = [UIFont systemFontOfSize:14];
    
    [self.queryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_backView.lineView);
        make.width.equalTo(_backView.lineView.mas_width).multipliedBy(0.42);
        make.height.equalTo(_backView.lineView.mas_height).multipliedBy(0.1);
        make.top.equalTo(_backView.lineView.mas_bottom).multipliedBy(0.7);
    }];
    self.queryButton.layer.masksToBounds = YES;
    self.queryButton.layer.cornerRadius = self.frame.size.height * 0.05 * 0.82 * 0.52;
    self.queryButton.backgroundColor = [UIColor colorWithRed:0.20f green:0.60f blue:0.86f alpha:1.00f];
    [self.queryButton setTitle:@"确    认" forState:UIControlStateNormal];
    [self.queryButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

#pragma mark - tableViewdataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.frame.size.height * 0.054;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *titleCell = nil;
    UITableViewCell *scoreCell = nil;
    
    if (indexPath.row == 0) {
        titleCell = [tableView dequeueReusableCellWithIdentifier:@"titleCell"];
        if (titleCell == nil) {
            titleCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"titleCell"];
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width * 0.47, self.frame.size.height * 0.054)];
            titleLabel.textColor = [UIColor colorWithRed:0.20f green:0.60f blue:0.86f alpha:1.00f];
            titleLabel.text = @"国家CET-4考试成绩";
            titleLabel.font = [UIFont systemFontOfSize:14];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            [titleCell.contentView addSubview:titleLabel];
        }
        return titleCell;
    } else {
        scoreCell = [tableView dequeueReusableCellWithIdentifier:@"scoreCell"];
        if (scoreCell == nil) {
            scoreCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"scoreCell"];
        }
        NSArray *array = [NSArray arrayWithObjects:@"听力", @"阅读", @"作文", @"总分", @"口语", nil];
        NSMutableArray *gradeMutableArray = [NSMutableArray array];
        [gradeMutableArray addObject:_gradeDictionary[@"hearing"]];
        [gradeMutableArray addObject:_gradeDictionary[@"reading"]];
        [gradeMutableArray addObject:_gradeDictionary[@"writing"]];
        [gradeMutableArray addObject:_gradeDictionary[@"total"]];
        if (_gradeDictionary[@"abc"] != nil) {
            [gradeMutableArray addObject:_gradeDictionary[@"total"]];
        } else {
            [gradeMutableArray addObject:@"无"];
        }
        scoreCell.textLabel.textColor = [UIColor colorWithRed:0.20f green:0.60f blue:0.86f alpha:1.00f];
        scoreCell.textLabel.font = [UIFont systemFontOfSize:14];
        scoreCell.textLabel.text = array[indexPath.row - 1];
        
        scoreCell.detailTextLabel.textColor = [UIColor blackColor];
        scoreCell.detailTextLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        scoreCell.detailTextLabel.text = gradeMutableArray[indexPath.row - 1];
        scoreCell.detailTextLabel.textAlignment = NSTextAlignmentCenter;
        return scoreCell;
    }
}

@end
