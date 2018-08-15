//
//  XYAEducationSystemAPI.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/8/10.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYAEducationSystemAPI.h"

@implementation XYAEducationSystemAPI

static XYAEducationSystemAPI *_kXYAEducationSystemAPI = nil;

+ (instancetype)shareGradesAPI {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _kXYAEducationSystemAPI = [[XYAEducationSystemAPI alloc] init];
    });
    return _kXYAEducationSystemAPI;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.URL = @"";
        self.param = [NSMutableDictionary dictionary];
        self.cookie = @"";
    }
    return self;
}

- (void)getGradesTotalAPI {
    _kXYAEducationSystemAPI.URL = @"http://47.95.207.40:8080/xiyou_helper/achievement/get_total";
}

@end
