//
//  XYAPickviewTextField.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/8/6.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYAPickviewTextField.h"

#define kXYAScreenHeight self.frame.size.height
#define kXYAScreenWidth self.frame.size.width

@interface XYAPickviewTextField () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) UIDatePicker *datePickerView;

@end

@implementation XYAPickviewTextField

{
    UIToolbar *inputAccessoryView;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.text = @"";
        [self addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

#pragma mark - UI
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0.50f green:0.50f blue:0.50f alpha:1.00f].CGColor);
    CGContextFillRect(context, CGRectMake(0, CGRectGetHeight(self.frame) - 1, CGRectGetWidth(self.frame), 1));
}

- (void)createPickerViewWithType:(NSString *)type {
    if ([type isEqualToString:@"time"]) {
        _datePickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, kXYAScreenHeight + 30, kXYAScreenWidth, kXYAScreenWidth / 2.0)];
        _datePickerView.backgroundColor = [UIColor whiteColor];
        _datePickerView.datePickerMode = UIDatePickerModeDate;
        _datePickerView.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        // 监听 datePicker 的变化
        [_datePickerView addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];
        self.inputView = _datePickerView;
    } else {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, kXYAScreenHeight + 30, kXYAScreenWidth, kXYAScreenWidth / 2.0)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.backgroundColor = [UIColor whiteColor];
        self.inputView = _pickerView;
    }
}

#pragma mark - KVO

- (void)dateChanged {
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([_pDelegate respondsToSelector:@selector(pickerViewSelecatString:)] && ![[change objectForKey:@"new"] isEqualToString:@""]) {
        [_pDelegate pickerViewSelecatString:[change objectForKey:@"new"]];
    }
}

#pragma mark - pickerView

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.dataArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.text = self.dataArray[row];
}

#pragma mark - inputAccessoryView with toolbar

- (BOOL)canBecomeFirstResponder {
    return YES;
}


- (void)done:(id)sender {
    [self resignFirstResponder];
    [super resignFirstResponder];
}

- (UIView *)inputAccessoryView {
    if (inputAccessoryView == nil) {
        inputAccessoryView = [[UIToolbar alloc] init];
        inputAccessoryView.barStyle = UIBarStyleDefault;
        inputAccessoryView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [inputAccessoryView sizeToFit];
        CGRect frame = inputAccessoryView.frame;
        frame.size.height = 30.0f;
        inputAccessoryView.frame = frame;
        
        UIBarButtonItem *doneBtn =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
        UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        NSArray *array = [NSArray arrayWithObjects:flexibleSpaceLeft, doneBtn, nil];
        [inputAccessoryView setItems:array];
    }
    return inputAccessoryView;
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"text"];
}
@end
