//
//  XYAMainLoginView.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/20.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYAMainLoginView.h"
#import "XYALoginButton.h"
#import "Masonry.h"

@interface XYAMainLoginView()

@property (nonatomic, strong) UIImageView *logoImage;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) XYALoginButton *personLogin;
@property (nonatomic, strong) XYALoginButton *weChatLogin;

@end

@implementation XYAMainLoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.logoImage = [[UIImageView alloc] init];
        [self addSubview:_logoImage];
        
        self.titleLabel = [[UILabel alloc] init];
        [self addSubview:_titleLabel];
        
        self.subTitleLabel = [[UILabel alloc] init];
        [self addSubview:_subTitleLabel];
        
        self.personLogin = [[XYALoginButton alloc] init];
        [self addSubview:_personLogin];
        
        self.weChatLogin = [[XYALoginButton alloc] init];
        [self addSubview:_weChatLogin];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor = [UIColor whiteColor];
    
    [self.logoImage setImage:[UIImage imageNamed:@"XUPT"]];
    [self.logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.and.height.equalTo(self.mas_width).multipliedBy(0.45);
        make.top.equalTo(self.mas_top).offset(110);
    }];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:@5 forKey:NSKernAttributeName];
    [dic setValue:[UIFont systemFontOfSize:30] forKey:NSFontAttributeName];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@" 西邮助手" attributes:dic];
    self.titleLabel.attributedText = attributedString;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.equalTo(self.mas_width).multipliedBy(0.5);
        make.top.equalTo(self.logoImage.mas_bottom).offset(30);
    }];
    
    self.subTitleLabel.text = @"爱  国、 求  是、 奋  进";
    self.subTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.subTitleLabel.font = [UIFont systemFontOfSize:11 weight:UIFontWeightRegular];
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(7);
        make.centerX.equalTo(self);
        make.width.equalTo(self.titleLabel);
    }];
    
    [self.weChatLogin setBackgroundColor:[UIColor colorWithRed:0.24 green:0.69 blue:0.20 alpha:1]];
    [self.weChatLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(38);
        make.right.equalTo(self.mas_right).offset(-38);
        make.bottom.equalTo(self.mas_bottom).offset(-58);
        make.height.mas_equalTo(50);
    }];
    [self.weChatLogin setImage:[UIImage imageNamed:@"WeChat"] forState:UIControlStateNormal];
    [self.weChatLogin setTitle:@"微信登陆" forState:UIControlStateNormal];
    self.weChatLogin.layer.masksToBounds = YES;
    self.weChatLogin.layer.cornerRadius = 25;
    
    [self.personLogin setBackgroundColor:[UIColor colorWithRed:0 green:0.51 blue:0.79 alpha:1]];
    [self.personLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(38);
        make.right.equalTo(self.mas_right).offset(-38);
        make.bottom.equalTo(self.weChatLogin.mas_top).offset(-27);
        make.height.mas_equalTo(50);
    }];
    [self.personLogin setImage:[UIImage imageNamed:@"people"] forState:UIControlStateNormal];
    [self.personLogin setTitle:@"学号登陆" forState:UIControlStateNormal];
    self.personLogin.layer.masksToBounds = YES;
    self.personLogin.layer.cornerRadius = 25;
}

@end
