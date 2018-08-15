//
//  XYAGradesTotalModel.h
//  Assistant
//
//  Created by 崔一鸣 on 2018/8/10.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "JSONModel.h"

@protocol XYAGradesTotalResuleModel
@end

@protocol XYAGradesTotalDataModel
@end;

@interface XYAGradesTotalResuleModel : JSONModel

@property (nonatomic, copy) NSString *total;
@property (nonatomic, copy) NSString *pass;
@property (nonatomic, copy) NSString *nopass;

@end

@interface XYAGradesTotalDataModel : JSONModel

@property (nonatomic, copy) NSString *averageGPA;

@property (nonatomic, copy) NSString *allGPA;

@property (nonatomic, strong) XYAGradesTotalResuleModel *choice;

@property (nonatomic, strong) XYAGradesTotalResuleModel *essential;

@end

@interface XYAGradesTotalModel : JSONModel

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, strong) XYAGradesTotalDataModel *data;

@property (nonatomic, copy) NSString *msg;

@end
