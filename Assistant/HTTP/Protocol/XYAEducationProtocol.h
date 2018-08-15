//
//  XYAEducationProtocol.h
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/24.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#ifndef XYAEducationProtocol_h
#define XYAEducationProtocol_h
#import "XYAEducationAPI.h"
#import "XYAEducationResultModel.h"
#import "XYAEducationClassTableModel.h"


typedef void(^XYAEducationErrorHandler)(NSError * __nonnull error);

/**
 智慧教室通用回调

 @param educationResult 回调结果
 */
typedef void(^XYAEducationResultHandler)(XYAEducationResultModel * __nullable educationResult);


/**
 智慧教室登陆验证码

 @param imageData 验证码
 */
typedef void(^NSDataHandler)(NSData * __nullable imageData);


/**
 智慧教室课表回调

 @param educationClassTable 课表
 */
typedef void(^XYAEducationClassTableHandler)(XYAEducationClassTableModel * __nullable educationClassTable);

@protocol XYAEducationProtocol <NSObject>


/**
 获取智慧教室信息

 @param educationAPI api
 @param successBlock 成功回调
 @param errorBlock 错误回调
 */
- (void)fetchEducationResultWithEducationAPI:(XYAEducationAPI *_Nonnull)educationAPI
                              success:(nullable XYAEducationResultHandler)successBlock
                                error:(nonnull XYAEducationErrorHandler)errorBlock;


/**
 获取验证码

 @param successBlock 成功回调
 @param errorBlock 错误回调
 */
- (void)fetchEducationVercodeFromNetSuccess:(nullable NSDataHandler)successBlock
                                      error:(nonnull XYAEducationErrorHandler)errorBlock;

/**
 登陆智慧教室

 @param username 用户名
 @param password 密码
 @param vercode 验证码
 @param successBlock 成功回调
 @param errorBlock 错误回调
 */
- (void)fetchEducationLoginWithUsername:(NSString *_Nonnull)username
                               password:(NSString *_Nonnull)password
                                vercode:(NSString *_Nonnull)vercode
                                success:(nullable XYAEducationResultHandler)successBlock
                                  error:(nonnull XYAEducationErrorHandler)errorBlock;

/**
 获取智慧教室课表

 @param term 学期段
 @param week 第几周
 @param successBlock 成功回调
 @param errorBlock 错误回调
 */
- (void)fetchEducationClassTableWithTermNumber:(NSString *_Nonnull)term
                                          week:(NSInteger)week
                                       success:(nullable XYAEducationClassTableHandler)successBlock
                                         error:(nonnull XYAEducationErrorHandler)errorBlock;
@end

#endif
