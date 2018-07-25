//
//  XYAEducationClassTableModel.h
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/25.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYAEducationResultModel.h"
#import "JSONModel.h"

@protocol XYAEducationClassTableItemModel

@end

@interface XYAEducationClassTableItemModel : JSONModel

///课程时间
@property (nonatomic, copy) NSString *Timetable;
///课程名称
@property (nonatomic, copy) NSString *S_Name;
///教师名称
@property (nonatomic, copy) NSString *Teach_Name;
///教室名称
@property (nonatomic, copy) NSString *RoomNum;
///课程在周几
@property (nonatomic, assign) NSInteger WEEKNUM;

@end

@interface XYAEducationClassTableModel : XYAEducationResultModel

@property (nonatomic, copy) NSArray <Optional, XYAEducationClassTableItemModel> *Obj;

@end
