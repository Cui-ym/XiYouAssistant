//
//  XYAUtils.h
//  Assistant
//
//  Created by 崔一鸣 on 2018/8/14.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 @class
 @abstract 通用工具类
 */

@interface XYAUtils : NSObject

/**
 格式化数据库字符串

 @param keyWord 传入字符串
 @return 格式化后的字符串
 */
+ (NSString *)sqliteEscape:(NSString *)keyWord;

@end
