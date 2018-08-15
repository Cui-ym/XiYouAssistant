//
//  XYAComputerAPI.h
//  Assistant
//
//  Created by 崔一鸣 on 2018/8/3.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYAComputerAPI : NSObject

@property (nonatomic, copy) NSString *URL;

@property (nonatomic, copy) NSString *cookie;

@property (nonatomic, strong) NSMutableDictionary *param;

+(instancetype)shareComputerAPI;

- (void)getComputerTimeAPI;

- (void)getComputerVercodeAPI;

- (void)getComputerResultAPIWithTime:(NSString *_Nonnull)time
                                type:(NSInteger)type
                                 zjh:(NSString *_Nonnull)zjh
                                name:(NSString *_Nonnull)name
                             vercode:(NSString *_Nonnull)vercode;

@end
