//
//  XYAUtils.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/8/14.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYAUtils.h"

@implementation XYAUtils

+ (NSString *)sqliteEscape:(NSString *)keyWord {
    // keyWord = [keyWord stringByReplacingOccurrencesOfString: @"/" withString:@"//"];
    keyWord = [keyWord stringByReplacingOccurrencesOfString: @"'" withString:@"''"];
    keyWord = [keyWord stringByReplacingOccurrencesOfString: @"[" withString:@"/["];
    keyWord = [keyWord stringByReplacingOccurrencesOfString: @"]" withString:@"/]"];
    keyWord = [keyWord stringByReplacingOccurrencesOfString: @"%" withString:@"/%"];
    keyWord = [keyWord stringByReplacingOccurrencesOfString: @"&" withString:@"/&"];
    keyWord = [keyWord stringByReplacingOccurrencesOfString: @"_" withString:@"/_"];
    keyWord = [keyWord stringByReplacingOccurrencesOfString: @"(" withString:@"/("];
    keyWord = [keyWord stringByReplacingOccurrencesOfString: @")" withString:@"/)"];
    return keyWord;
}

@end
