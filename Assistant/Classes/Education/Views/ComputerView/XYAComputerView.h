//
//  XYAComputerView.h
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/30.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYAPickviewTextField;

@class XYAClipBackgroundView;

@class XYAUnderLinerTextField;

@class XYAComputerVercodeView;

@interface XYAComputerView : UIView

@property (nonatomic, strong) XYAClipBackgroundView *backView;

@property (nonatomic, strong) XYAPickviewTextField *timeTextField;
@property (nonatomic, strong) XYAPickviewTextField *typeTextField;
@property (nonatomic, strong) XYAUnderLinerTextField *nameTextField;
@property (nonatomic, strong) XYAUnderLinerTextField *numbertextField;
@property (nonatomic, strong) XYAComputerVercodeView *vercodeView;

@property (nonatomic, strong) UIButton *queryButton;

@property (nonatomic, copy) NSDictionary *timeDictionary;
@property (nonatomic, copy) NSDictionary *typeDictionary;

@property (nonatomic, copy) NSString *string;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *zkzh;

- (void)showScoreWithScoreDictionary:(NSDictionary *)dic;

- (void)addPickerViewWithArray:(NSArray *)array;

@end
