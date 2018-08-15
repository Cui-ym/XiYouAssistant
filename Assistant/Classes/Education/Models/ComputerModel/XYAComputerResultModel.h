//
//  XYAComputerResultModel.h
//  Assistant
//
//  Created by 崔一鸣 on 2018/8/3.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "JSONModel.h"

@interface XYAComputerResultModel : JSONModel

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSDictionary *data;

@end
