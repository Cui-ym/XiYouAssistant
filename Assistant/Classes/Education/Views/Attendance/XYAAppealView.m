//
//  XYAAppealView.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/27.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYAAppealView.h"
#import "Masonry.h"

@interface XYAAppealView ()

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UITextView *reasonTextView;

@end

@implementation XYAAppealView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backView = [[UIView alloc] init];
        [self addSubview:_backView];
        
        self.classLabel = [[UILabel alloc] init];
        [_backView addSubview:_classLabel];
        
        self.timeLabel = [[UILabel alloc] init];
        [_backView addSubview:_timeLabel];
        
        self.titleLabel = [[UILabel alloc] init];
        [_backView addSubview:_titleLabel];
        
        self.reasonTextView = [[UITextView alloc] init];
        [_backView addSubview:_reasonTextView];
        
        self.confirmButton = [[UIButton alloc] init];
        [self addSubview:_confirmButton];
    }
    return self;
}

- (void)layoutSubviews {
    
    self.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.00f];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(self.mas_width).multipliedBy(0.8);
        make.top.equalTo(self.mas_bottom).multipliedBy(0.1);
        make.height.equalTo(self.mas_height).multipliedBy(0.6);
    }];
    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.layer.cornerRadius = 15;
    self.backView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.backView.layer.shadowOpacity = 0.5f;
    self.backView.layer.shadowRadius = 10.0f;
    self.backView.layer.shadowOffset = CGSizeMake(0,0);
    
    [self.classLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView);
        make.top.equalTo(self.backView.mas_bottom).multipliedBy(0.096);
        make.height.equalTo(self.backView.mas_height).multipliedBy(0.075);
        make.width.equalTo(self.backView.mas_width).multipliedBy(0.67);
    }];
    self.classLabel.layer.cornerRadius = self.frame.size.height * 0.015;
    self.classLabel.layer.borderColor = [UIColor colorWithRed:0.36f green:0.68f blue:0.89f alpha:1.00f].CGColor;
    self.classLabel.layer.borderWidth = 3;
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView);
        make.top.equalTo(self.backView.mas_bottom).multipliedBy(0.24);
        make.height.equalTo(self.backView.mas_height).multipliedBy(0.075);
        make.width.equalTo(self.backView.mas_width).multipliedBy(0.67);
    }];
    self.timeLabel.layer.borderColor = [UIColor colorWithRed:0.36f green:0.68f blue:0.89f alpha:1.00f].CGColor;
    self.timeLabel.layer.cornerRadius = self.frame.size.height * 0.015;
    self.timeLabel.layer.borderWidth = 3;
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView.mas_bottom).multipliedBy(0.4);
        make.left.equalTo(self.timeLabel.mas_left).offset(10);
    }];
    self.titleLabel.text = @"申诉原因";
    self.titleLabel.textColor = [UIColor colorWithRed:0.36f green:0.68f blue:0.89f alpha:1.00f];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [self.reasonTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.classLabel);
        make.bottom.equalTo(self.backView.mas_bottom).multipliedBy(0.9);
        make.height.equalTo(self.backView.mas_height).multipliedBy(0.43);
    }];
    self.reasonTextView.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.00f];
    self.reasonTextView.layer.masksToBounds = YES;
    self.reasonTextView.layer.cornerRadius = 10;
    self.reasonTextView.layer.borderColor = [UIColor colorWithRed:0.36f green:0.68f blue:0.89f alpha:1.00f].CGColor;
    self.reasonTextView.layer.borderWidth = 4;
    self.reasonTextView.font = [UIFont systemFontOfSize:14];
    [self.reasonTextView setContentInset:UIEdgeInsetsMake(12, 15, 12, 15)];
    self.reasonTextView.textAlignment = NSTextAlignmentLeft;
    
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.equalTo(self.mas_width).multipliedBy(0.53);
        make.bottom.equalTo(self.mas_bottom).multipliedBy(0.83);
        make.height.equalTo(self.mas_height).multipliedBy(0.067);
    }];
    self.confirmButton.backgroundColor = [UIColor colorWithRed:0.36f green:0.68f blue:0.89f alpha:1.00f];
    self.confirmButton.layer.cornerRadius = self.frame.size.height * 0.0335;
    self.confirmButton.layer.masksToBounds = YES;
    [self.confirmButton setTitle:@"确认申诉" forState:UIControlStateNormal];
    [self.confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

@end
