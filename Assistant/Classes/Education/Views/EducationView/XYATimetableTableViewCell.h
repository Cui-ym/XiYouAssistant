//
//  XYATimetableTableViewCell.h
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/20.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYATimetableLabel;

@interface XYATimetableTableViewCell : UITableViewCell

@property (nonatomic, strong) XYATimetableLabel *firstClassroom;
@property (nonatomic, strong) XYATimetableLabel *firstClass;
@property (nonatomic, strong) XYATimetableLabel *secondClassroom;
@property (nonatomic, strong) XYATimetableLabel *secondClass;
@property (nonatomic, strong) XYATimetableLabel *thirdClassroom;
@property (nonatomic, strong) XYATimetableLabel *thirdClass;
@property (nonatomic, strong) XYATimetableLabel *fouthClassroom;
@property (nonatomic, strong) XYATimetableLabel *fouthClass;

@end
