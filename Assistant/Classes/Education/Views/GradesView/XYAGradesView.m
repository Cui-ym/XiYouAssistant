//
//  XYAGradesView.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/31.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYAGradesView.h"
#import "XYAGradesTableViewCell.h"
#import "Masonry.h"

@interface XYAGradesView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *gradesTableView;

@property (nonatomic, strong) UIButton *termButton;

@end

@implementation XYAGradesView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.termButton = [[UIButton alloc] init];
        [self addSubview:_termButton];
        
        self.gradesTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.gradesTableView.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1.00f];
        [self.gradesTableView registerClass:[XYAGradesTableViewCell class] forCellReuseIdentifier:@"gradesCell"];
        [self addSubview:_gradesTableView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1.00f];
    
    [self.termButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_top).offset(10);
        make.height.mas_equalTo(25);
        make.width.equalTo(self.mas_width).multipliedBy(0.55);
    }];
    self.termButton.backgroundColor = [UIColor whiteColor];
    self.termButton.layer.masksToBounds = YES;
    self.termButton.layer.cornerRadius = 10;
    self.termButton.layer.borderWidth = 2;
    self.termButton.layer.borderColor = [UIColor colorWithRed:0.20f green:0.60f blue:0.86f alpha:1.00f].CGColor;
    [self.termButton setTitleColor:[UIColor colorWithRed:0.20f green:0.60f blue:0.86f alpha:1.00f] forState:UIControlStateNormal];
    self.termButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.termButton setTitle:@"2017-2018 第一学期" forState:UIControlStateNormal];
    
    [self.gradesTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(45);
        make.bottom.equalTo(self.mas_bottom).offset(-64);
        make.left.and.right.equalTo(self);
    }];
    self.gradesTableView.delegate = self;
    self.gradesTableView.dataSource = self;
}

#pragma mark - UITbaleViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 7) {
        return 0.06 * self.frame.size.height;
    }
    if (indexPath.section == 8) {
        return 0.37 * self.frame.size.width;
    }
    return 0.134 * self.frame.size.height + 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 20)];
    view.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1.00f];
    return view;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 9;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < 7) {
        XYAGradesTableViewCell *gradesCell = [tableView dequeueReusableCellWithIdentifier:@"gradesCell" forIndexPath:indexPath];
        gradesCell.typeLabel.text = @"必";
        gradesCell.nameLabel.text = @"毛泽东思想和中国特色社会理论体系概论";
        gradesCell.creditLabel.text = [NSString stringWithFormat:@"学分：%.1f", 4.0];
        gradesCell.gradePointLabel.text = [NSString stringWithFormat:@"绩点：%.1f", 5.0];
        gradesCell.otherGradesLabel.text = [NSString stringWithFormat:@"平时/试卷：%d/%d", 30, 70];
        gradesCell.totalGradesLabel.text = [NSString stringWithFormat:@"总评：%d", 100];
        return gradesCell;
    } else if (indexPath.section == 7) { 
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1.00f];
            
            UIView *backView = [[UIView alloc] init];
            [cell.contentView addSubview:backView];
            [backView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.and.bottom.equalTo(cell.contentView);
                make.left.equalTo(cell.contentView.mas_left).offset(15);
                make.right.equalTo(cell.contentView.mas_right).offset(-15);
            }];
            backView.backgroundColor = [UIColor whiteColor];
            backView.layer.masksToBounds = YES;
            backView.layer.cornerRadius = 8;
            
            UILabel *averLabel = [[UILabel alloc] init];
            [backView addSubview:averLabel];
            [averLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(backView.mas_left);
                make.right.equalTo(backView.mas_centerX);
                make.centerY.equalTo(backView);
                make.height.equalTo(backView.mas_height).multipliedBy(0.7);
            }];
            averLabel.text = @"平均绩点：5.0";
            averLabel.textColor = [UIColor blackColor];
            averLabel.font = [UIFont systemFontOfSize:14];
            averLabel.textAlignment = NSTextAlignmentCenter;
            
            UILabel *totalLabel = [[UILabel alloc] init];
            [backView addSubview:totalLabel];
            [totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(backView.mas_centerX);
                make.right.equalTo(backView.mas_right);
                make.top.and.bottom.equalTo(averLabel);
            }];
            totalLabel.textAlignment = NSTextAlignmentCenter;
            totalLabel.font = [UIFont systemFontOfSize:14];
            totalLabel.textColor = [UIColor blackColor];
            totalLabel.text = @"总绩点：30.0";
        }
        return cell;
    } else {
        UITableViewCell *lastCell = [tableView dequeueReusableCellWithIdentifier:@"lastCell"];
        if (lastCell == nil) {
            lastCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"lastCell"];
            lastCell.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1.00f];
            
            UIView *essentialView = [[UIView alloc] init];
            [lastCell addSubview:essentialView];
            [essentialView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lastCell.mas_left).offset(15);
                make.right.equalTo(lastCell.mas_centerX).offset(-7);
                make.top.and.bottom.equalTo(lastCell);
            }];
            essentialView.backgroundColor = [UIColor whiteColor];
            essentialView.layer.masksToBounds = YES;
            essentialView.layer.cornerRadius = 7;
            
            NSMutableArray *essentialArray = [NSMutableArray array];
            
            UILabel *essentialLabel = [[UILabel alloc] init];
            essentialLabel.textColor = [UIColor colorWithRed:0.20f green:0.60f blue:0.86f alpha:1.00f];
            [essentialArray addObject:essentialLabel];
            [essentialView addSubview:essentialLabel];
            essentialLabel.text = @"必修";
            UILabel *essentialTotalLabel = [[UILabel alloc] init];
            essentialTotalLabel.font = [UIFont systemFontOfSize:14];
            [essentialArray addObject:essentialTotalLabel];
            [essentialView addSubview:essentialTotalLabel];
            essentialTotalLabel.text = @"学分共需：";
            UILabel *essentialGetLabel = [[UILabel alloc] init];
            essentialGetLabel.font = [UIFont systemFontOfSize:14];
            [essentialArray addObject:essentialGetLabel];
            [essentialView addSubview:essentialGetLabel];
            essentialGetLabel.text = @"所获学分：";
            UILabel *essentialLackLabel = [[UILabel alloc] init];
            essentialLackLabel.font = [UIFont systemFontOfSize:14];
            [essentialArray addObject:essentialLackLabel];
            [essentialView addSubview:essentialLackLabel];
            essentialLackLabel.text = @"未通过学分：";
            
            [essentialArray mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:35 leadSpacing:10 tailSpacing:10];
            [essentialArray mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(essentialView.mas_left).offset(30);
                make.right.equalTo(essentialView.mas_right);
            }];
            
            UIView *choiceView = [[UIView alloc] init];
            [lastCell addSubview:choiceView];
            [choiceView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lastCell.mas_centerX).offset(8);
                make.right.equalTo(lastCell.mas_right).offset(-15);
                make.top.and.bottom.equalTo(lastCell);
            }];
            choiceView.backgroundColor = [UIColor whiteColor];
            choiceView.layer.masksToBounds = YES;
            choiceView.layer.cornerRadius = 7;
            NSMutableArray *choiceArray = [NSMutableArray array];
            
            UILabel *choiceLabel = [[UILabel alloc] init];
            choiceLabel.textColor = [UIColor colorWithRed:0.20f green:0.60f blue:0.86f alpha:1.00f];
            [choiceArray addObject:choiceLabel];
            [choiceView addSubview:choiceLabel];
            choiceLabel.text = @"选修";
            UILabel *choiceTotalLabel = [[UILabel alloc] init];
            choiceTotalLabel.font = [UIFont systemFontOfSize:14];
            [choiceArray addObject:choiceTotalLabel];
            [choiceView addSubview:choiceTotalLabel];
            choiceTotalLabel.text = @"学分共需：";
            UILabel *choiceGetLabel = [[UILabel alloc] init];
            choiceGetLabel.font = [UIFont systemFontOfSize:14];
            [choiceArray addObject:choiceGetLabel];
            [choiceView addSubview:choiceGetLabel];
            choiceGetLabel.text = @"所获学分：";
            UILabel *choiceLackLabel = [[UILabel alloc] init];
            choiceLackLabel.font = [UIFont systemFontOfSize:14];
            [choiceArray addObject:choiceLackLabel];
            [choiceView addSubview:choiceLackLabel];
            choiceLackLabel.text = @"未通过学分：";
            
            [choiceArray mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:35 leadSpacing:10 tailSpacing:10];
            [choiceArray mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(choiceView.mas_left).offset(30);
                make.right.equalTo(choiceView.mas_right);
            }];
        }
        return lastCell;
    }
    
}

@end
