//
//  XYAEducationAPI.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/23.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYAEducationAPI.h"

@implementation XYAEducationAPI

static XYAEducationAPI *_kXYAEducationAPI = nil;

+ (instancetype)shareEducationAPI {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _kXYAEducationAPI = [[super alloc] init];
    });
    
    return _kXYAEducationAPI;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.param = [NSMutableDictionary dictionary];
        self.URL = @"";
        self.cookie = @"";
    }
    return self;
}

- (void)getCookieAndVerCodeApi {
    self.URL = @"http://jwkq.xupt.edu.cn:8080/Common/GetValidateCode";
}

- (void)GetLoginApiWithUserName:(NSString *)userName password:(NSString *)password vercode:(NSString *)vercode {
    self.URL = @"http://jwkq.xupt.edu.cn:8080/Account/Login";
    self.param = [NSMutableDictionary dictionary];
    [self.param setValue:userName forKey:@"UserName"];
    [self.param setValue:password forKey:@"UserPassword"];
    [self.param setValue:vercode forKey:@"ValiCode"];
}

- (void)getTermList {
    self.URL = @"http://jwkq.xupt.edu.cn:8080/Common/GetTermList";
    self.param = [NSMutableDictionary dictionary];
    [self.param setValue:@true forKey:@"json"];
}

- (void)getLessionWithTerm:(NSNumber *)term {
    self.URL = @"http://jwkq.xupt.edu.cn:8080/User/GetLessionByTerm";
    self.param = [NSMutableDictionary dictionary];
    [self.param setValue:@true forKey:@"json"];
    [self.param setValue:term forKey:@"term_no"];
}

- (void)getLessionWithWeek:(NSNumber *)week term:(NSNumber *)term {
    self.URL = @"http://jwkq.xupt.edu.cn:8080/User/GetStuClass";
    self.param = [NSMutableDictionary dictionary];
    [self.param setValue:@true forKey:@"json"];
    [self.param setValue:term forKey:@"term_no"];
    [self.param setValue:week forKey:@"week"];
}

- (void)getAttendListWithTimeDate:(NSString *)timeDate status:(NSString *)status flagArray:(NSArray *)flagArray page:(NSInteger)page Row:(NSInteger)row {
    self.URL = @"http://jwkq.xupt.edu.cn:8080/User/GetAttendList";
    self.param = [NSMutableDictionary dictionary];
    [self.param setValue:timeDate forKey:@"WaterDate"];
    [self.param setValue:status forKey:@"Status"];
    NSMutableString *flag = [NSMutableString string];
    NSInteger count = flagArray.count;
    for (NSInteger i = 0; i < count; i++) {
        if (i == 0) {
            [flag stringByAppendingString:[NSString stringWithFormat:@"%@", flagArray[i]]];
        } else {
            [flag stringByAppendingString:[NSString stringWithFormat:@"a%@", flagArray[i]]];
        }
    }
    [self.param setValue:flag forKey:@"Flag"];
    [self.param setValue:[NSNumber numberWithInteger:page] forKey:@"page"];
    [self.param setValue:[NSNumber numberWithInteger:row] forKey:@"rows"];
    
}

@end
