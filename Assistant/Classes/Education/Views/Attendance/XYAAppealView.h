//
//  XYAAppealView.h
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/27.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYAAppealView : UIView

@property (nonatomic, strong) UILabel *classLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIButton *confirmButton;

@property (nonatomic, copy) NSString *reason;

@end
