//
//  XYALoginView.h
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/23.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYAUnderLinerTextField;

@interface XYALoginView : UIView

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *vercodeimageView;

@property (nonatomic, strong) UIButton *changeButton;

@property (nonatomic, strong) UIButton *loginButton;

@property (nonatomic, strong) XYAUnderLinerTextField *vercodeField;

@property (nonatomic, strong) XYAUnderLinerTextField *passwordField;

@property (nonatomic, strong) XYAUnderLinerTextField *userNameField;

@end
