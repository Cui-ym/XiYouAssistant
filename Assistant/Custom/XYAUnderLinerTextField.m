//
//  XYAUnderLinerTextField.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/24.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYAUnderLinerTextField.h"

@implementation XYAUnderLinerTextField

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0.50f green:0.50f blue:0.50f alpha:1.00f].CGColor);
    CGContextFillRect(context, CGRectMake(0, CGRectGetHeight(self.frame) - 1, CGRectGetWidth(self.frame), 1));
}

@end
