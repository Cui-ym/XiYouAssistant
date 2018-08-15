//
//  XYAComputerModel.h
//  Assistant
//
//  Created by 崔一鸣 on 2018/8/3.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "JSONModel.h"

@protocol XYAComputerItemModel <NSObject>

@end

@interface XYAComputerItemModel : JSONModel

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *zkzh;

@property (nonatomic, copy) NSString *zjh;

@property (nonatomic, copy) NSString *year;

@property (nonatomic, copy) NSString *month;

@property (nonatomic, copy) NSString *status;

@end

@interface XYAComputerModel : JSONModel

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) id <XYAComputerItemModel> data;

@end

