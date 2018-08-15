//
//  XYALessonTableDBManager.h
//  Assistant
//
//  Created by 崔一鸣 on 2018/8/13.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYAEducationClassTableModel.h"

//@class XYAEducationClassTableModel;

@interface XYALessonTableDBManager : NSObject

+ (instancetype)sharedManager;

- (BOOL)createLessonTable;

- (BOOL)insertLessonTableModels:(XYAEducationClassTableModel *)models;

- (BOOL)insertLessonTableModel:(XYAEducationClassTableItemModel *)model;

//- (BOOL)updateLessonTableModels:(XYAEducationClassTableModel *)models;
//
//- (BOOL)updateLessonTableModel:(XYAEducationClassTableItemModel *)model;

- (BOOL)resetAllData;

- (XYAEducationClassTableModel *)getLessonModelWithWeek:(NSInteger)week;
@end
