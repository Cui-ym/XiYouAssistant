//
//  XYAClassTableView.h
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/31.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYAEducationClassTableModel;

@interface XYAClassTableView : UIView

@property (nonatomic, strong) UIButton *addButton;

- (void)slideAddLessonView;

- (void)removeAddLessonView;

- (void)showLessonCollectionWithModel:(XYAEducationClassTableModel *)model;

@end
