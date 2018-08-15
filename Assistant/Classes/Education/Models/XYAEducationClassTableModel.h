//
//  XYAEducationClassTableModel.h
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/25.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYAEducationResultModel.h"
#import "JSONModel.h"

@class XYAEducationClassTableItemModel;

@protocol XYAEducationClassTableItemModel

@end

@interface XYAEducationClassTableItemModel : JSONModel

///课程时间
@property (nonatomic, copy) NSString *JT_NO;
///课程名称
@property (nonatomic, copy) NSString *S_Name;
///教师名称
@property (nonatomic, copy) NSString *Teach_Name;
///教室名称
@property (nonatomic, copy) NSString *RoomNum;
///课程在周几
@property (nonatomic, assign) NSInteger WEEKNUM;
// 课程在第几周  数据库存储
@property (nonatomic, copy) NSString <Optional>*WEEK;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end

@interface XYAEducationClassTableModel : JSONModel

@property (nonatomic, assign) BOOL IsSucceed;

@property (nonatomic, copy) NSString <Optional>*Msg;

@property (nonatomic, copy) NSArray <XYAEducationClassTableItemModel,  Optional> *Obj;

- (instancetype)lessonArraySort;

@end
