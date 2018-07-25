//
//  XYAEducationAPI.h
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/23.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYAEducationAPI : NSObject

@property (nonatomic, copy) NSString *URL;

@property (nonatomic, copy) NSString *cookie;

@property (nonatomic, strong) NSMutableDictionary *param;

+(instancetype)shareEducationAPI;

// 获取验证码
- (void)getCookieAndVerCodeApi;

// 登陆
- (void)GetLoginApiWithUserName:(NSString *)userName password:(NSString *)password vercode:(NSString *)vercode;

// 学期段
- (void)getTermList;

// 每学期课程
- (void)getLessionWithTerm:(NSNumber *)term;

// 每星期课程
- (void)getLessionWithWeek:(NSNumber *)week term:(NSNumber *)term;

// 考勤信息
- (void)getAttendListWithTimeDate:(NSString *)timeDate status:(NSString *)status flagArray:(NSArray *)flagArray page:(NSInteger)page Row:(NSInteger)row;

@end
