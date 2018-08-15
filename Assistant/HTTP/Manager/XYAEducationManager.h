//
//  XYAEducationManager.h
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/24.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYAEducationProtocol.h"

@interface XYAEducationManager : NSObject<XYAEducationProtocol>

+ (instancetype)educationManager;

@end
