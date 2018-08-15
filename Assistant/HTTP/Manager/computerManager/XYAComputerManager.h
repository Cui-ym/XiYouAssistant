//
//  XYAComputerManager.h
//  Assistant
//
//  Created by 崔一鸣 on 2018/8/3.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYAComputerProtocol.h"

@interface XYAComputerManager : NSObject <XYAEducationProtocol>

+(instancetype)shareComputerManager;

@end
