//
//  XYAHttpSessionManager.h
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/23.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface XYAHttpSessionManager : NSObject

+ (instancetype _Nonnull)sharedManager;

/**
 发送 GET 请求
 
 @param url URL
 @param param 参数字典
 @param successBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)doGet:(NSString *_Nonnull)url
     withParam:(NSDictionary *_Nullable)param
      progress:(void (^_Nullable)(NSProgress * _Nonnull downloadProgress))downloadProgress
       success:(void (^_Nullable)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject))successBlock
         error:(void (^_Nullable)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))errorBlock;

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
      progress:(void (^_Nullable)(NSProgress *_Nullable progress))progress
       success:(void (^_Nullable)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject))successBlock
         error:(void (^_Nullable)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))errorBlock;

@end
