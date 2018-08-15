//
//  XYAComputerVercodeView.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/30.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYAComputerVercodeView.h"
#import "Masonry.h"

@implementation XYAComputerVercodeView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.vercodeTextField = [[UITextField alloc] init];
        [self addSubview:_vercodeTextField];
        
        self.vercodeImageView = [[UIImageView alloc] init];
        [self addSubview:_vercodeImageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor colorWithRed:0.80f green:0.80f blue:0.80f alpha:1.00f].CGColor;
    
    [self.vercodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0.5);
        make.top.equalTo(self.mas_top).offset(0.5);
        make.bottom.equalTo(self.mas_bottom).offset(-0.5);
        make.width.equalTo(self.mas_width).multipliedBy(0.54);
    }];
    
    [self.vercodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vercodeTextField.mas_right);
        make.top.and.bottom.equalTo(self);
        make.right.equalTo(self);
    }];
    self.vercodeImageView.userInteractionEnabled = YES;
    self.vercodeImageView.backgroundColor = [UIColor colorWithRed:0.80f green:0.80f blue:0.80f alpha:1.00f];
}

@end
