//
//  XYAGradesAPI.h
//  Assistant
//
//  Created by 崔一鸣 on 2018/8/10.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYAGradesAPI : NSObject

@property (nonatomic, copy) NSString *URL;
@property (nonatomic, copy) NSString *cookie;
@property (nonatomic, strong) NSMutableDictionary *param;

+ (instancetype)shareGradesAPI;

- (void)getGradesTotalAPI;

- (void)getNewGradesAPi;

/**
 成绩查询

 @param num 学号
 @param year 学年
 @param semester 学期
 */
- (void)getGradesAPIWithNum:(NSString *)num schoolYear:(NSString *)year semester:(NSInteger)semester;

@end
