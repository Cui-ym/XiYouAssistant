//
//  XYAComputerView.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/30.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYAComputerView.h"
#import "XYAPickerView.h"
#import "Masonry.h"
#import "XYAPickviewTextField.h"
#import "XYAClipBackgroundView.h"
#import "XYAUnderLinerTextField.h"
#import "XYAComputerVercodeView.h"

@interface XYAComputerView ()<UITableViewDelegate, UITableViewDataSource, XYAPickerViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *timeImageView;

@property (nonatomic, strong) UIImageView *typeImageView;

@property (nonatomic, strong) UIImageView *nameImageView;

@property (nonatomic, strong) UIImageView *numberImageView;

@property (nonatomic, strong) UITableView *scoreTableView;

@property (nonatomic, strong) XYAPickerView *pickerView;

@end

@implementation XYAComputerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backView = [[XYAClipBackgroundView alloc] init];
        [self addSubview:_backView];
        
        self.timeImageView = [[UIImageView alloc] init];
        [self.backView.lineView addSubview:_timeImageView];
        
        self.timeTextField = [[XYAPickviewTextField alloc] init];
        [self.backView.lineView addSubview:_timeTextField];
        
        self.typeImageView = [[UIImageView alloc] init];
        [self.backView.lineView addSubview:_typeImageView];
        
        self.typeTextField = [[XYAPickviewTextField alloc] init];
        [self.backView.lineView addSubview:_typeTextField];
        
        self.nameImageView = [[UIImageView alloc] init];
        [self.backView.lineView addSubview:_nameImageView];
        
        self.nameTextField = [[XYAUnderLinerTextField alloc] init];
        [self.backView.lineView addSubview:_nameTextField];
        
        self.numberImageView = [[UIImageView alloc] init];
        [self.backView.lineView addSubview:_numberImageView];
        
        self.numbertextField = [[XYAUnderLinerTextField alloc] init];
        [self.backView.lineView addSubview:_numbertextField];
        
        self.vercodeView = [[XYAComputerVercodeView alloc] init];
        [self.backView.lineView addSubview:_vercodeView];
        
        self.queryButton = [[UIButton alloc] init];
        [self.backView.lineView addSubview:_queryButton];
    }
    return self;
}

// 显示成绩
- (void)showScoreWithScoreDictionary:(NSDictionary *)dic {
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
        make.height.equalTo(_backView.lineView.mas_height).multipliedBy(0.54);
        make.width.equalTo(_backView.lineView.mas_width).multipliedBy(0.8);
    }];
}

#pragma mark - pickerView

- (void)addPickerViewWithArray:(NSArray *)array {
    self.pickerView = [[XYAPickerView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.pickerView.delegate = self;
    self.pickerView.array = array;
    [self addSubview:_pickerView];
}

- (void)clickPickerViewSureButtonWithString:(NSString *)string {
    if ([string isEqualToString:@"time"]) {
        _timeTextField.text = string;
    } else {
        _typeTextField.text = string;
    }
}

#pragma mark - tableViewdataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return self.frame.size.height * 0.12;
    }
    return self.frame.size.height * 0.054;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        UITableViewCell *titleCell = [tableView dequeueReusableCellWithIdentifier:@"titleCell"];
        if (titleCell == nil) {
            titleCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"titleCell"];
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width * 0.5, self.frame.size.height * 0.06)];
            titleLabel.textColor = [UIColor colorWithRed:0.20f green:0.60f blue:0.86f alpha:1.00f];
            titleLabel.text = @"16以及计算机基础级MS Offic应用";
            titleLabel.numberOfLines = 0;
            titleLabel.font = [UIFont systemFontOfSize:15];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            [titleCell.contentView addSubview:titleLabel];
        }
        return titleCell;
    } else if (indexPath.row == 1) {
        UITableViewCell *firstCell = [tableView dequeueReusableCellWithIdentifier:@"firstCell"];
        if (firstCell == nil) {
            firstCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"firstCell"];
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.frame.size.width * 0.22, self.frame.size.height * 0.054)];
            titleLabel.textColor = [UIColor colorWithRed:0.20f green:0.60f blue:0.86f alpha:1.00f];
            titleLabel.text = @"考试状态：";
            titleLabel.font = [UIFont systemFontOfSize:15];
            [firstCell.contentView addSubview:titleLabel];
            UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width * 0.22 + 15, 0, self.frame.size.width * 0.38, self.frame.size.height * 0.054)];
            detailLabel.textColor = [UIColor blackColor];
            detailLabel.text = self.status;
            detailLabel.font = [UIFont systemFontOfSize:15];
            [firstCell.contentView addSubview:detailLabel];
        }
        return firstCell;
    } else {
        UITableViewCell *secondCell = [tableView dequeueReusableCellWithIdentifier:@"secondCell"];
        if (secondCell == nil) {
            secondCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"secondCell"];
            secondCell.layoutMargins = UIEdgeInsetsMake(0, 0, 0, 0);
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, self.frame.size.width * 0.22, self.frame.size.height * 0.054)];
            titleLabel.textColor = [UIColor colorWithRed:0.20f green:0.60f blue:0.86f alpha:1.00f];
            titleLabel.text = @"证书编号:";
            titleLabel.font = [UIFont systemFontOfSize:15];
            [secondCell.contentView addSubview:titleLabel];
            UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width * 0.22 + 5, 0, self.frame.size.width * 0.38, self.frame.size.height * 0.054)];
            detailLabel.textColor = [UIColor blackColor];
            detailLabel.text = self.zkzh;
            detailLabel.font = [UIFont systemFontOfSize:11];
            [secondCell.contentView addSubview:detailLabel];
        }
        return secondCell;
    }
}

#pragma mark - layoutSubviews

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self);
        make.top.and.bottom.equalTo(self);
    }];
    
    [self.timeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView.lineView.mas_left).offset(30);
        make.top.equalTo(_backView.lineView.mas_bottom).multipliedBy(0.09);
        make.width.and.height.equalTo(_backView.lineView.mas_width).multipliedBy(0.08);
    }];
    self.timeImageView.image = [UIImage imageNamed:@"icon_computer_time"];
    self.timeImageView.contentMode = UIViewContentModeScaleToFill;
    
    [self.timeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self.timeImageView);
        make.left.equalTo(self.timeImageView.mas_right).offset(15);
        make.width.equalTo(_backView.lineView).multipliedBy(0.625);
    }];
    [self.timeTextField createPickerViewWithType:@"picker"];
    self.timeTextField.placeholder = @"请选择考试时间";
    self.timeTextField.font = [UIFont systemFontOfSize:14];
    
    [self.typeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView.lineView.mas_left).offset(30);
        make.top.equalTo(_backView.lineView.mas_bottom).multipliedBy(0.22);
        make.width.and.height.equalTo(_backView.lineView.mas_width).multipliedBy(0.08);
    }];
    self.typeImageView.image = [UIImage imageNamed:@"icon_computer_type"];
    self.typeImageView.contentMode = UIViewContentModeScaleToFill;
    
    [self.typeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self.typeImageView);
        make.left.equalTo(self.typeImageView.mas_right).offset(15);
        make.width.equalTo(_backView.lineView).multipliedBy(0.625);
    }];
    self.typeTextField.dataArray = self.typeDictionary.allKeys;
    [self.typeTextField createPickerViewWithType:@"picker"];
    self.typeTextField.placeholder = @"请选择考试种类";
    self.typeTextField.font = [UIFont systemFontOfSize:12];
    
    [self.nameImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView.lineView.mas_left).offset(30);
        make.top.equalTo(_backView.lineView.mas_bottom).multipliedBy(0.34);
        make.width.and.height.equalTo(_backView.lineView.mas_width).multipliedBy(0.08);
    }];
    self.nameImageView.image = [UIImage imageNamed:@"icon_CET_username"];
    self.nameImageView.contentMode = UIViewContentModeScaleToFill;
    
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self.nameImageView);
        make.left.equalTo(self.nameImageView.mas_right).offset(15);
        make.width.equalTo(_backView.lineView).multipliedBy(0.625);
    }];
    self.nameTextField.placeholder = @"请输入考生姓名";
    self.nameTextField.font = [UIFont systemFontOfSize:14];
    
    [self.numberImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView.lineView.mas_left).offset(30);
        make.top.equalTo(_backView.lineView.mas_bottom).multipliedBy(0.47);
        make.width.and.height.equalTo(_backView.lineView.mas_width).multipliedBy(0.08);
    }];
    self.numberImageView.image = [UIImage imageNamed:@"icon_CET_number"];
    self.numberImageView.contentMode = UIViewContentModeScaleToFill;
    
    [self.numbertextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self.numberImageView);
        make.left.equalTo(self.numberImageView.mas_right).offset(15);
        make.width.equalTo(_backView.lineView).multipliedBy(0.625);
    }];
    self.numbertextField.placeholder = @"请输入考生准考证号";
    self.numbertextField.font = [UIFont systemFontOfSize:14];
    
    [self.vercodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.numbertextField.mas_left);
        make.width.equalTo(self.numbertextField.mas_width).multipliedBy(0.867);
        make.top.equalTo(self.backView.lineView.mas_bottom).multipliedBy(0.62);
        make.height.equalTo(self.backView.lineView.mas_height).multipliedBy(0.1);
    }];
    
    [self.queryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView.lineView);
        make.width.equalTo(self.backView.lineView.mas_width).multipliedBy(0.42);
        make.top.equalTo(self.backView.lineView.mas_bottom).multipliedBy(0.8);
        make.height.equalTo(self.backView.lineView.mas_height).multipliedBy(0.1);
    }];
    self.queryButton.layer.masksToBounds = YES;
    self.queryButton.layer.cornerRadius = self.frame.size.height * 0.05 * 0.8 * 0.52;
    self.queryButton.backgroundColor = [UIColor colorWithRed:0.20f green:0.60f blue:0.86f alpha:1.00f];
    [self.queryButton setTitle:@"查    询" forState:UIControlStateNormal];
    [self.queryButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}


//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer

@end
