//
//  XYACETView.h
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/27.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYACETView : UIView

@property (nonatomic, strong) UIImageView *vercodeImageView;

@property (nonatomic, strong) UIButton *queryButton;

@property (nonatomic, strong) UIView *backView;

- (void)showScoreWithScoreDictionary:(NSDictionary *)dic;

@end
