//
//  XYAPickerView.h
//  Assistant
//
//  Created by 崔一鸣 on 2018/8/6.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XYAPickerViewDelegate <NSObject>

- (void)clickPickerViewSureButtonWithString:(NSString *)string;

@end

@interface XYAPickerView : UIView

@property (nonatomic, weak) id <XYAPickerViewDelegate> delegate;

@property (nonatomic, copy) NSString *string;

@property (nonatomic, copy) NSArray *array;

- (void)setPickerWithType:(NSString *)type;

@end
