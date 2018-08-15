//
//  XYAEducationResultModel.h
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/23.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "JSONModel.h"

@interface XYAEducationResultModel : JSONModel

@property (nonatomic, assign) NSInteger IsSucceed;

@property (nonatomic, copy) NSString <Optional>*Msg;

@property (nonatomic, copy) id <Optional> Obj;

@end
