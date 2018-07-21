//
//  XYALoginButton.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/20.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYALoginButton.h"

@implementation XYALoginButton

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect imageRect = self.imageView.frame;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageRect.size = CGSizeMake(25, 25);
    imageRect.origin.x = 20;
    imageRect.origin.y = 13;
    
    CGRect titleRect = self.titleLabel.frame;
    self.titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
    titleRect.origin.x = 120;
    titleRect.origin.y = 15;
    self.imageView.frame = imageRect;
    self.titleLabel.frame = titleRect;
}
@end
