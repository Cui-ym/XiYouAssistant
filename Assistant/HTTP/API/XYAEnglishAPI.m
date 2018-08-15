
//
//  XYAEnglishAPI.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/8/8.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYAEnglishAPI.h"

@implementation XYAEnglishAPI

static XYAEnglishAPI *_kXYAEnglishAPI = nil;

+ (instancetype)shareEnglishAPI {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _kXYAEnglishAPI = [[XYAEnglishAPI alloc] init];
    });
    return _kXYAEnglishAPI;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.URL = @"";
        self.param = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)getEnglishTestAPIWithNumber:(NSString *)number name:(NSString *)name vercode:(NSString *)vercode {
    self.URL = @"http://www.wexcampus.com/cet/result?token=a8d29bc2d6aca74f65028632e4e869ae";
    [self.param setObject:number forKey:@"number"];
    [self.param setObject:name forKey:@"name"];
    if (![vercode isEqualToString:@""] && vercode != nil) {
        [self.param setObject:vercode forKey:@"img_code"];
    }
    [self.param setObject:@1 forKey:@"type"];
}

@end
