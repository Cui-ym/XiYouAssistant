//
//  XYAAttendanceView.h
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/25.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYAAttendanceView : UIView

@property (nonatomic, strong) UIButton *beginTimeButton;

@property (nonatomic, strong) UIButton *endTimeButton;

@property (nonatomic, strong) UIButton *classButton;

@property (nonatomic, strong) UITableView *tableView;

- (void)viewAddPickerView:(NSString *)type;

@end
