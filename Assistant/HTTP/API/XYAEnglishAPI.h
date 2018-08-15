//
//  XYAEnglishAPI.h
//  Assistant
//
//  Created by 崔一鸣 on 2018/8/8.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYAEnglishAPI : NSObject

@property (nonatomic, copy) NSString *URL;

@property (nonatomic, strong) NSMutableDictionary *param;

+ (instancetype)shareEnglishAPI;

- (void)getEnglishTestAPIWithNumber:(NSString *)number name:(NSString *)name vercode:(NSString *)vercode;

@end
