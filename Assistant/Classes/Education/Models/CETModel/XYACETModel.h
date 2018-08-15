//
//  XYACETModel.h
//  Assistant
//
//  Created by 崔一鸣 on 2018/8/8.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "JSONModel.h"

@interface XYACETModel : JSONModel

@property (nonatomic, assign) NSInteger code;

@property (nonatomic, copy) NSString <Optional> *message;

@property (nonatomic, copy) NSString <Optional> *img_url;

@property (nonatomic, copy) NSDictionary <Optional> *result;

@end
