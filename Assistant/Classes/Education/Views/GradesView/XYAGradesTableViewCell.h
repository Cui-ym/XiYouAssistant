//
//  XYAGradesTableViewCell.h
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/31.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYAGradesTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *blueView;

@property (nonatomic, strong) UIView *grayView;

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UILabel *typeLabel;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *creditLabel;

@property (nonatomic, strong) UILabel *otherGradesLabel;

@property (nonatomic, strong) UILabel *gradePointLabel;

@property (nonatomic, strong) UILabel *totalGradesLabel;


@end
