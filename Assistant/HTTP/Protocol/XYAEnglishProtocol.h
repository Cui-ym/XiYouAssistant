//
//  XYAEnglishProtocol.h
//  Assistant
//
//  Created by 崔一鸣 on 2018/8/8.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#ifndef XYAEnglishProtocol_h
#define XYAEnglishProtocol_h

#import "XYACETModel.h"


/**
 失败回调

 @param error 错误信息
 */
typedef void(^XYAEnglishErrorHandler)(NSError * __nonnull error);


/**
 获取验证码

 @param imageData 验证码
 */
typedef void(^NSDataHandler)(NSData * __nullable imageData);


/**
 请求成功

 @param englishModel 成功回调
 */
typedef void(^XYAEnglishResultHandler)(XYACETModel * __nullable englishModel);

@protocol XYAEnglishProtocol <NSObject>

/**
 验证码

 @param successBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)fetchEnglishVercodeWithUrl:(NSString *_Nonnull)url
                           Success:(nullable NSDataHandler)successBlock
                             error:(nonnull XYAEnglishErrorHandler)errorBlock;


/**
 获取四六级成绩

 @param name 考生姓名
 @param number 考生考号
 @param vercode 验证码
 @param successBlock 成功回调
 @param errorBlock 失败回调
 */
- (void)fetchEnglishResultModelWithUsername:(NSString *_Nonnull)name
                                     number:(NSString *_Nonnull)number
                                    vercode:(NSString *_Nullable)vercode
                                    success:(XYAEnglishResultHandler _Nullable )successBlock
                                      error:(XYAEnglishErrorHandler _Nonnull )errorBlock;

@end

#endif
