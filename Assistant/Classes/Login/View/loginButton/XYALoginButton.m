//
//  XYALoginButton.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/20.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYALoginButton.h"
#import "Masonry.h"

@implementation XYALoginButton

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect imageRect = self.imageView.frame;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageRect.size = CGSizeMake(25, 25);
    imageRect.origin.x = 20;
    imageRect.origin.y = 13;
    
    self.titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.imageView.frame = imageRect;
}
@end
