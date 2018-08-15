//
//  XYAGradesModel.h
//  Assistant
//
//  Created by 崔一鸣 on 2018/8/10.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "JSONModel.h"

@protocol XYAGradesResultModel <NSObject>
@end

@protocol XYAGradesItemModel <NSObject>
@end

@interface XYAGradesResultModel : JSONModel

@property (nonatomic, copy) NSString *num;

@property (nonatomic, copy) NSString *school_year;

@property (nonatomic, copy) NSString *semester;

@property (nonatomic, copy) NSString *classname;

@property (nonatomic, copy) NSString *achievement;

@property (nonatomic, copy) NSString *point;

@property (nonatomic, copy) NSString *nature;

@property (nonatomic, copy) NSString *credit;

@property (nonatomic, copy) NSString *finalexam;

@property (nonatomic, copy) NSString *ordinary;

@end

@interface XYAGradesItemModel : JSONModel

@property (nonatomic, copy) NSArray *year;

@property (nonatomic, copy) NSArray <XYAGradesResultModel>*achievements;

@end

@interface XYAGradesModel : JSONModel

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, strong) XYAGradesItemModel <Optional> *data;

@property (nonatomic, copy) NSString <Optional> *msg;

@end
