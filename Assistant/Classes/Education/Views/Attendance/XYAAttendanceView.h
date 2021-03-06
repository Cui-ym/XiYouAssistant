//
//  XYAAttendanceView.h
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/25.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XYAAttendanceViewDelegate <NSObject>

- (void)pushAppealViewController:(NSDictionary *)dictionary;

@end

@interface XYAAttendanceView : UIView

@property (nonatomic, weak) id <XYAAttendanceViewDelegate> delegate;

@property (nonatomic, strong) UIButton *beginTimeButton;

@property (nonatomic, strong) UIButton *endTimeButton;

@property (nonatomic, strong) UIButton *classButton;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) NSInteger buttonTag;

- (void)viewAddPickerViewWithType:(NSString *)type buttonTag:(NSInteger)tag;

@end
