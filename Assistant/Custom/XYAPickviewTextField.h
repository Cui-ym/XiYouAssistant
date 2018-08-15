//
//  XYAPickviewTextField.h
//  Assistant
//
//  Created by 崔一鸣 on 2018/8/6.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XYAPickerviewTextFieldDelegate <NSObject>

- (void)pickerViewSelecatString:(NSString *)string;

@end

@interface XYAPickviewTextField : UITextField

@property (nonatomic, weak) id <XYAPickerviewTextFieldDelegate> pDelegate;

@property (nonatomic, strong) NSArray *dataArray;

- (void)createPickerViewWithType:(NSString *)type;

@end
