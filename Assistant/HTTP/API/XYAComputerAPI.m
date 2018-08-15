//
//  XYAComputerAPI.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/8/3.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYAComputerAPI.h"

@implementation XYAComputerAPI
{
    NSString *_prefix;
}

static XYAComputerAPI *_kXYAComputerAPI = nil;

+(instancetype)shareComputerAPI {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _kXYAComputerAPI = [[super alloc] init];
    });
    return _kXYAComputerAPI;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _prefix = @"http://47.95.207.40:8080/xiyou_helper";
        self.URL = @"";
        self.param = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)getComputerVercodeAPI {
    _kXYAComputerAPI.URL = [NSString stringWithFormat:@"%@/cge/validate_code", _prefix];
}

- (void)getComputerTimeAPI {
    _kXYAComputerAPI.URL = [NSString stringWithFormat:@"%@/cge/getTimes", _prefix];
}

- (void)getComputerResultAPIWithTime:(NSString *)time type:(NSInteger)type zjh:(NSString *)zjh name:(NSString *)name vercode:(NSString *)vercode {
    _kXYAComputerAPI.URL = [NSString stringWithFormat:@"%@/cge/query", _prefix];
    _kXYAComputerAPI.param = [NSMutableDictionary dictionary];
    [_kXYAComputerAPI.param setValue:time forKey:@"time"];
    [_kXYAComputerAPI.param setValue:[NSNumber numberWithInteger:type] forKey:@"type"];
    [_kXYAComputerAPI.param setValue:zjh forKey:@"zjh"];
    [_kXYAComputerAPI.param setValue:name forKey:@"name"];
    [_kXYAComputerAPI.param setValue:vercode forKey:@"validateCode"];
}

@end
