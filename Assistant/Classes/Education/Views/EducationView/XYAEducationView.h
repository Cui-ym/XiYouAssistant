//
//  XYAEducationView.h
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/20.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XYAEducationViewDelegate <NSObject>

- (void)selectedCellWithtype:(NSString *)type;

@end

@interface XYAEducationView : UIView

@property (nonatomic, weak) id<XYAEducationViewDelegate> delegate;

@end
