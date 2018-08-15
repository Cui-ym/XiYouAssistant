//
//  XYAPickerView.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/8/6.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYAPickerView.h"

#define kXYAScreenHeight self.frame.size.height
#define kXYAScreenWidth self.frame.size.width

@interface XYAPickerView () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, copy) NSString *type;

@property (nonatomic, strong) UIDatePicker *datePickerView;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) NSDate *date;

@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) UIView *grayBackground;
@property (nonatomic, strong) UIView *buttonView;

@end

@implementation XYAPickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"YY-MM-dd";
    }
    return self;
}

- (void)setPickerWithType:(NSString *)type {
    _type = type;
    [self createCaverView];
    [self createAnimation];
}

#pragma mark - pickerView

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.array.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.array[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _string = self.array[row];
    
}

#pragma mark - animation
- (void)createAnimation {
    [UIView animateWithDuration:0.3 animations:^{
        _grayBackground.alpha = 0.3;
        if ([_type isEqualToString:@"time"]) {
            _datePickerView.frame = CGRectMake(0, kXYAScreenHeight - kXYAScreenWidth / 2.0 - 64, kXYAScreenWidth, kXYAScreenWidth / 2.0);
        } else {
            _pickerView.frame = CGRectMake(0, kXYAScreenHeight - kXYAScreenWidth / 2.0 - 64, kXYAScreenWidth, kXYAScreenWidth / 2.0);
        }
        _buttonView.frame = CGRectMake(0, kXYAScreenHeight - kXYAScreenWidth / 2.0 - 64, kXYAScreenWidth - 30, 30);
    }];
}

#pragma mark - UI

- (void)createCaverView {
    self.grayBackground = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _grayBackground.backgroundColor = [UIColor blackColor];
    _grayBackground.alpha = 0;
    [self addSubview:_grayBackground];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelPicker)];
    tap.numberOfTapsRequired = 1;
    [_grayBackground addGestureRecognizer:tap];
    
    [self createPickerView];
    [self createButtonView];
}

- (void)createPickerView {
    if ([_type isEqualToString:@"time"]) {
        _datePickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, kXYAScreenHeight + 30, kXYAScreenWidth, kXYAScreenWidth / 2.0)];
        _datePickerView.backgroundColor = [UIColor whiteColor];
        _datePickerView.datePickerMode = UIDatePickerModeDate;
        _datePickerView.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        _date = _datePickerView.date;
        
        // 监听 datePicker 的变化
        [_datePickerView addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_datePickerView];
    } else {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, kXYAScreenHeight + 30, kXYAScreenWidth, kXYAScreenWidth / 2.0)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_pickerView];
    }
}

- (void)createButtonView {
    self.buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, kXYAScreenWidth, kXYAScreenWidth, 30)];
    _buttonView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_buttonView];
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 80, 20)];
    [leftButton setTitle:@"取消" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(cancelPicker) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonView addSubview:leftButton];
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(kXYAScreenWidth - 30 - 60, 10, 80, 20)];
    [rightButton setTitle:@"确定" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor colorWithRed:20/255.0 green:124/255.0 blue:235/255.0 alpha:1] forState:UIControlStateNormal];
    [_buttonView addSubview:rightButton];
    [rightButton addTarget:self action:@selector(clickSureButton:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - action

- (void)dateChanged {
    _date = _datePickerView.date;
}

- (void)cancelPicker {
    [UIView animateWithDuration:0.3 animations:^{
        _grayBackground.alpha = 0;
        if ([_type isEqualToString:@"time"]) {
            _datePickerView.frame = CGRectMake(0, kXYAScreenHeight + 30, kXYAScreenWidth, kXYAScreenWidth / 2.);
        } else {
            _pickerView.frame = CGRectMake(0, kXYAScreenHeight + 30, kXYAScreenWidth, kXYAScreenWidth / 2.);
        }
        _buttonView.frame = CGRectMake(0, kXYAScreenHeight, kXYAScreenWidth, 30);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)clickSureButton:(UIButton *)sender {
    if (!_string) {
        if ([_type isEqualToString:@"time"]) {
            _string = [_dateFormatter stringFromDate:_date];
        } else {
            _string = self.array[0];
        }
    }
    
    if ([_delegate respondsToSelector:@selector(clickPickerViewSureButtonWithString:)]) {
        [_delegate clickPickerViewSureButtonWithString:_string];
    }
    
    [self cancelPicker];
}


@end
