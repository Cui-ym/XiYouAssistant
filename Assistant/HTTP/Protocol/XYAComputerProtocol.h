//
//  XYAComputerProtocol.h
//  Assistant
//
//  Created by 崔一鸣 on 2018/8/3.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//


#ifndef XYAEducationProtocol_h
#define XYAEducationProtocol_h

#import "XYAComputerResultModel.h"
#import "XYAComputerModel.h"

/**
 失败回调

 @param error 错误信息
 */
typedef void(^XYAComputerErrorHandler)(NSError * __nonnull error);


/**
 查询验证码

 @param imageData 验证码
 */
typedef void(^NSDataHandler)(NSData * __nullable imageData);

/**
 考试时间
 
 @param computerTime 成功
 */
typedef void(^XYAComputerTimeHandler)(XYAComputerResultModel * __nullable computerTime);

/**
 考试成绩
 
 @param computerResult 成功
 */
typedef void(^XYAComputerResultHandler)(XYAComputerModel * __nullable computerResult);

@protocol XYAEducationProtocol <NSObject>

/**
 请求验证码

 @param successBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)fetchComputerVercodeFromNetSuccess:(nullable NSDataHandler)successBlock
                                     error:(nonnull XYAComputerErrorHandler)errorBlock;
/**
 请求考试时间码

 @param successBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)fetchComputerTimeFromNetSuccess:(nullable XYAComputerTimeHandler)successBlock
                                  error:(nonnull XYAComputerErrorHandler)errorBlock;


/**
 考试成绩

 @param time 考试时间
 @param type 考试类型
 @param zjh 证件号
 @param name 姓名
 @param vercode 验证码
 @param successBlock 成功回调
 @param errorBlock 失败回调 
 */
- (void)fetchComputerResultModelWithTime:(NSString *_Nonnull)time
                                    type:(NSInteger)type
                                     zjh:(NSString *_Nonnull)zjh
                                    name:(NSString *_Nonnull)name
                                 vercode:(NSString *_Nonnull)vercode
                                  success:(nullable XYAComputerResultHandler)successBlock
                                    error:(nonnull XYAComputerErrorHandler)errorBlock;

@end

#endif

