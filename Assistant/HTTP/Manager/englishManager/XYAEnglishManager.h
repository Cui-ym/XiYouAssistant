//
//  XYAEnglishManager.h
//  Assistant
//
//  Created by 崔一鸣 on 2018/8/8.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYAEnglishProtocol.h"

@interface XYAEnglishManager : NSObject <XYAEnglishProtocol>

+ (instancetype)shareEnglishManager;

@end
