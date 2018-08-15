//
//  XYALoginView.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/23.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYALoginView.h"
#import "XYAUnderLinerTextField.h"
#import "Masonry.h"

@interface XYALoginView ()

@property (nonatomic, strong) UIView *backGround;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UIImageView *usernameIcon;

@property (nonatomic, strong) UILabel *usernameLabel;

@property (nonatomic, strong) UIImageView *passwordIcon;

@property (nonatomic, strong) UILabel *passwordLabel;

@property (nonatomic, strong) UIImageView *vercodeIcon;

@property (nonatomic, strong) UILabel *vercodeLabel;

@property (nonatomic, strong) UIFont *font;

@end

@implementation XYALoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self getLabelFontWithLabel];
        
        self.backGround = [[UIView alloc] init];
        [self addSubview:_backGround];
        
        self.titleLabel = [[UILabel alloc] init];
        [self.backGround addSubview:_titleLabel];
        
        self.line = [[UIView alloc] init];
        [self.backGround addSubview:_line];
        
        self.usernameIcon = [[UIImageView alloc] init];
        [self.backGround addSubview:_usernameIcon];
        
        self.usernameLabel = [[UILabel alloc] init];
        [self.backGround addSubview:_usernameLabel];
        
        self.userNameField = [[XYAUnderLinerTextField alloc] init];
        [self.backGround addSubview:_userNameField];
        
        self.passwordIcon = [[UIImageView alloc] init];
        [self.backGround addSubview:_passwordIcon];
        
        self.passwordLabel = [[UILabel alloc] init];
        [self.backGround addSubview:_passwordLabel];
        
        self.passwordField = [[XYAUnderLinerTextField alloc] init];
        [self.backGround addSubview:_passwordField];
        
        self.vercodeIcon = [[UIImageView alloc] init];
        [self.backGround addSubview:_vercodeIcon];
        
        self.vercodeLabel = [[UILabel alloc] init];
        [self.backGround addSubview:_vercodeLabel];
        
        self.vercodeField = [[XYAUnderLinerTextField alloc] init];
        [self.backGround addSubview:_vercodeField];
        
        self.vercodeimageView = [[UIImageView alloc] init];
        [self.backGround addSubview:_vercodeimageView];
        
        self.changeButton = [[UIButton alloc] init];
        [self.backGround addSubview:_changeButton];
        
        self.loginButton = [[UIButton alloc] init];
        [self.backGround addSubview:_loginButton];
    }
    return self;
}

- (void)getLabelFontWithLabel {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0.12 * self.frame.size.width, self.frame.size.height)];
    label.text = @"用户名:";
    float fontSize = label.font.pointSize;
    CGRect labelBounds = [label bounds];
    while (fontSize > label.minimumScaleFactor && fontSize > 0.0f) {
        CGRect rect = CGRectZero;
        rect = [label.text boundingRectWithSize:CGSizeMake(rect.size.width, MAXFLOAT) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
        if (rect.size.width < labelBounds.size.width && rect.size.height <= labelBounds.size.height) {
            break;
        }
        fontSize -= 0.1f;
    }
    if (fontSize < label.minimumScaleFactor) {
        fontSize = label.minimumScaleFactor;
    }
    self.font = label.font;
    self.font = [self.font fontWithSize:fontSize];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.userNameField.text = @"04161029";
    self.passwordField.text = @"030173";
    [self.backGround mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(self.mas_width).multipliedBy(0.8);
        make.height.equalTo(self.mas_height).multipliedBy(0.52);
    }];
    self.backGround.backgroundColor = [UIColor whiteColor];
    self.backGround.layer.borderWidth = 3;
    self.backGround.layer.borderColor = [UIColor colorWithRed:0.58f green:0.78f blue:0.91f alpha:1.00f].CGColor;
    self.backGround.layer.shadowColor = [UIColor blackColor].CGColor;
    self.backGround.layer.shadowOpacity = 0.8f;
    self.backGround.layer.shadowRadius = 10.0f;
    self.backGround.layer.shadowOffset = CGSizeMake(0,0);
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backGround);
        make.width.equalTo(self.backGround).multipliedBy(0.75);
        make.top.equalTo(self.backGround.mas_bottom).multipliedBy(0.13);
    }];
    self.titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    self.titleLabel.textColor = [UIColor colorWithRed:0.20f green:0.60f blue:0.85f alpha:1.00f];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backGround);
        make.width.equalTo(self.backGround).multipliedBy(0.75);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(1);
    }];
    self.line.backgroundColor = [UIColor colorWithRed:0.50f green:0.50f blue:0.50f alpha:1.00f];
    
    [self.usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.line.mas_left).offset(30);
        make.bottom.equalTo(self.backGround.mas_bottom).multipliedBy(0.37);
    }];
    self.usernameLabel.font = [UIFont systemFontOfSize:self.font.pointSize weight:UIFontWeightMedium];
    self.usernameLabel.textColor = [UIColor colorWithRed:0.20f green:0.60f blue:0.85f alpha:1.00f];
    self.usernameLabel.text = @"用户名:";
    
    [self.usernameIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.line.mas_left).offset(5);
        make.centerY.equalTo(self.usernameLabel.mas_centerY);
        make.width.equalTo(self.line.mas_width).multipliedBy(0.06);
        make.height.equalTo(self.line.mas_width).multipliedBy(0.07);
    }];
    [self.usernameIcon setImage:[UIImage imageNamed:@"username"]];

    [self.userNameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.line.mas_right);
        make.width.equalTo(self.line.mas_width).multipliedBy(0.6);
        make.bottom.and.top.equalTo(self.usernameLabel);
    }];
    self.userNameField.font = self.font;

    [self.passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.usernameLabel.mas_left);
        make.bottom.equalTo(self.backGround.mas_bottom).multipliedBy(0.5);
    }];
    self.passwordLabel.font = [UIFont systemFontOfSize:self.font.pointSize weight:UIFontWeightMedium];
    self.passwordLabel.textColor = [UIColor colorWithRed:0.20f green:0.60f blue:0.85f alpha:1.00f];
    self.passwordLabel.text = @"密    码:";

    [self.passwordIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.usernameIcon.mas_left);
        make.centerY.equalTo(self.passwordLabel.mas_centerY);
        make.width.equalTo(self.line.mas_width).multipliedBy(0.06);
        make.height.equalTo(self.line.mas_width).multipliedBy(0.07);
    }];
    [self.passwordIcon setImage:[UIImage imageNamed:@"password"]];

    [self.passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userNameField.mas_left);
        make.width.equalTo(self.line.mas_width).multipliedBy(0.6);
        make.bottom.and.top.equalTo(self.passwordLabel);
    }];
    self.passwordField.font = self.font;

    [self.vercodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.passwordLabel.mas_left);
        make.bottom.equalTo(self.backGround.mas_bottom).multipliedBy(0.63);
    }];
    self.vercodeLabel.font = [UIFont systemFontOfSize:self.font.pointSize weight:UIFontWeightMedium];
    self.vercodeLabel.textColor = [UIColor colorWithRed:0.20f green:0.60f blue:0.85f alpha:1.00f];
    self.vercodeLabel.text = @"验证码:";

    [self.vercodeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.usernameIcon.mas_left);
        make.centerY.equalTo(self.vercodeLabel.mas_centerY);
        make.width.equalTo(self.line.mas_width).multipliedBy(0.06);
        make.height.equalTo(self.line.mas_width).multipliedBy(0.06);
    }];
    [self.vercodeIcon setImage:[UIImage imageNamed:@"vercode"]];

    [self.vercodeimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.line.mas_right);
        make.bottom.equalTo(self.vercodeLabel.mas_bottom);
        make.height.equalTo(self.line.mas_width).multipliedBy(0.15);
        make.width.equalTo(self.line.mas_width).multipliedBy(0.3);
    }];
    self.vercodeimageView.backgroundColor = [UIColor colorWithRed:0.57f green:0.57f blue:0.57f alpha:1.00f];

    [self.vercodeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userNameField.mas_left);
        make.right.equalTo(self.vercodeimageView.mas_left).offset(-6);
        make.bottom.and.top.equalTo(self.vercodeLabel);
    }];
    self.vercodeField.font = self.font;

    [self.changeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.vercodeimageView);
        make.top.equalTo(self.vercodeimageView.mas_bottom).offset(5);
        make.height.mas_equalTo(20);
    }];
    [self.changeButton setTitle:@"看不清，换一张" forState:UIControlStateNormal];
    self.changeButton.titleLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightSemibold];
    self.changeButton.titleLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    [self.changeButton setTitleColor:[UIColor colorWithRed:0.57f green:0.57f blue:0.57f alpha:1.00f] forState:UIControlStateNormal];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backGround.mas_bottom).multipliedBy(0.88);
        make.height.equalTo(self.backGround.mas_height).multipliedBy(0.1);
        make.centerX.equalTo(self.backGround);
        make.width.equalTo(self.backGround).multipliedBy(0.5);
    }];
    self.loginButton.layer.masksToBounds = YES;
    self.loginButton.layer.cornerRadius = self.frame.size.height * 0.025;
    self.loginButton.backgroundColor = [UIColor colorWithRed:0.20f green:0.60f blue:0.85f alpha:1.00f];
    self.loginButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.loginButton.titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    [self.loginButton setTitle:@"授权登录" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.loginButton.userInteractionEnabled = NO;//交互关闭
    self.loginButton.alpha = 0.4;//透明度
}



@end
