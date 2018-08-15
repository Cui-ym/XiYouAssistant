//
//  XYACETView.h
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/27.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYAUnderLinerTextField;
@class XYAClipBackgroundView;
@class XYAComputerVercodeView;

@interface XYACETView : UIView

@property (nonatomic, strong) UIButton *queryButton;

@property (nonatomic, strong) XYAComputerVercodeView *vercodeView;

@property (nonatomic, strong) XYAClipBackgroundView *backView;

@property (nonatomic, strong) XYAUnderLinerTextField *userTextField;

@property (nonatomic, strong) XYAUnderLinerTextField *numberTextField;

@property (nonatomic, copy) NSDictionary *gradeDictionary;

- (void)showScoreWithScoreTableView;

- (void)initVercodeViewWithImageDate:(NSData *)imageData;

@end
