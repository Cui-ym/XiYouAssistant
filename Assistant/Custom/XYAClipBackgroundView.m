//
//  XYAClipBackgroundView.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/30.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYAClipBackgroundView.h"
#import "Masonry.h"


@implementation XYAClipBackgroundView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backView = [[UIView alloc] init];
        [self addSubview:_backView];
        
        self.clipImageView = [[UIImageView alloc] init];
        [self addSubview:_clipImageView];
        
        self.lineView = [[UIView alloc] init];
        [self.backView addSubview:_lineView];
    }
    return self;
}

- (void)layoutSubviews {
    self.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.00f];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_bottom).multipliedBy(0.22);
        make.height.equalTo(self.mas_height).multipliedBy(0.52);
        make.width.equalTo(self.mas_width).multipliedBy(0.9);
    }];
    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.layer.cornerRadius = 5;
    self.backView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.backView.layer.shadowOpacity  = 0.5;
    self.backView.layer.shadowRadius = 10;
    self.backView.layer.shadowOffset = CGSizeMake(0,0);
    
    [self.clipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.equalTo(self.mas_width).multipliedBy(0.64);
        make.top.equalTo(self.mas_bottom).multipliedBy(0.125);
        make.height.equalTo(self.mas_height).multipliedBy(0.13);
    }];
    _clipImageView.image = [UIImage imageNamed:@"clip"];
    _clipImageView.backgroundColor = [UIColor clearColor];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.backView);
        make.height.equalTo(self.backView.mas_height).multipliedBy(0.82);
        make.width.equalTo(self.backView.mas_width).multipliedBy(0.7);
    }];
    self.lineView.backgroundColor = [UIColor whiteColor];
    self.lineView.layer.masksToBounds = YES;
    self.lineView.layer.cornerRadius = 5;
    self.lineView.layer.borderWidth = 1;
    self.lineView.layer.borderColor = [UIColor colorWithRed:0.50f green:0.50f blue:0.50f alpha:1.00f].CGColor;
}

@end
