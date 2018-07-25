//
//  XYAURLSessionManager.h
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/25.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYAEducationResultModel.h"

// 请求成功的回调 block
typedef void(^XYAEducationHandle)(XYAEducationResultModel * _Nullable resultModel);

// 请求失败的回调 block
typedef void(^ErrorHandle)(NSError * _Nonnull error);

@interface XYAURLSessionManager : NSObject


+ (instancetype _Nonnull)sharedManager;

/**
 发送 POST 请求
 
 @param url URL
 @param param 参数字典
 @param header 请求头字典
 @param successBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)doPost:(NSString *_Nonnull)url
     withParam:(NSDictionary *_Nullable)param
    withHeader:(NSDictionary *_Nullable)header
       success:(XYAEducationHandle _Nullable )successBlock
         error:(ErrorHandle _Nonnull)errorBlock;

@end
