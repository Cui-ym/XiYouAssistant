//
//  XYAComputerViewController.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/30.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYAComputerViewController.h"
#import "XYAClipBackgroundView.h"
#import "XYAComputerView.h"
#import "XYAComputerVercodeView.h"

#import "XYAComputerManager.h"
#import "XYAPickviewTextField.h"
#import "XYAUnderLinerTextField.h"

@interface XYAComputerViewController () <XYAPickerviewTextFieldDelegate>

@property (nonatomic, strong) XYAComputerView *computerView;

@property (nonatomic, strong) XYAComputerManager *manager;

@property (nonatomic, copy) NSString *timeCode;

@property (nonatomic, assign) NSNumber *typeCode;
@end

@implementation XYAComputerViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.manager = [XYAComputerManager shareComputerManager];
    
    [self getComputerTime];
    
    self.computerView = [[XYAComputerView alloc] initWithFrame:self.view.bounds];
    self.computerView.timeTextField.pDelegate = self;
    self.computerView.typeTextField.pDelegate = self;
    NSDictionary *dictionary = @{@"二级C语言程序设计" : @24, @"二级MS Office语言程序设计" : @65, @"二级VB语言程序设计" : @26, @"二级JAVA语言程序设计" : @28, @"二级ACCESS数据库程序设计" : @29, @"二级C++语言程序设计" : @61, @"二级MySQL数据程序设计" : @63, @"二级Web程序设计" : @64};
    _typeCode = @24;
    self.computerView.typeDictionary = dictionary;
    [self.computerView.queryButton addTarget:self action:@selector(clickQueryButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_computerView];
    
    [self getVercodeImageView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(recycleKeyboard)];
    tapGesture.numberOfTapsRequired = 1;
    [self.computerView addGestureRecognizer:tapGesture];
    
    UITapGestureRecognizer *verimageGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getVercodeImageView)];
    verimageGesture.numberOfTapsRequired = 1;
    [self.computerView.vercodeView.vercodeImageView addGestureRecognizer:verimageGesture];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(transformView:) name:UIKeyboardWillChangeFrameNotification object:nil];
    // Do any additional setup after loading the view.
}

- (void)recycleKeyboard {
    [self.view endEditing:YES];
}

#pragma mark - pickviewTextFieldDelegate

- (void)pickerViewSelecatString:(NSString *)string {
//    NSLog(@"--%@--", string);
    NSString *temp = [string substringToIndex:1];
    if ([temp isEqualToString:@"2"]) {
        self.timeCode = self.computerView.timeDictionary[string];
    } else {
        self.typeCode = self.computerView.typeDictionary[string];
    }
}

#pragma mark - HTTP

- (void)getComputerTime {
    [self.manager fetchComputerTimeFromNetSuccess:^(XYAComputerResultModel * _Nullable computerTime) {
//        NSLog(@"时间%@", computerTime);
        self.computerView.timeDictionary = computerTime.data;
        self.computerView.timeTextField.dataArray = [computerTime.data allKeys];
        self.timeCode = computerTime.data[[computerTime.data allKeys][0]];
    } error:^(NSError * _Nonnull error) {
        NSLog(@"时间获取失败");
    }];
}

- (void)getVercodeImageView {
    [self.manager fetchComputerVercodeFromNetSuccess:^(NSData * _Nullable imageData) {
        [self.computerView.vercodeView.vercodeImageView setImage:[UIImage imageWithData:imageData]];
        NSLog(@"验证码获取成功");
    } error:^(NSError * _Nonnull error) {
        NSLog(@"验证码获取失败");
    }];
}

- (void)clickQueryButton:(UIButton *)sender {
    NSString *zjh = self.computerView.numbertextField.text;
    NSString *name = self.computerView.nameTextField.text;
    NSString *vercode = self.computerView.vercodeView.vercodeTextField.text;
    [self.manager fetchComputerResultModelWithTime:_timeCode type:[_typeCode integerValue] zjh:zjh name:name vercode:vercode success:^(XYAComputerModel * _Nullable computerResult) {
//        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:computerResult.data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"-----%@", computerResult.data);
        self.computerView.status = computerResult.data[@"status"];
        self.computerView.zkzh = computerResult.data[@"zkzh"];
        [self curlUp];
    } error:^(NSError * _Nonnull error) {
        NSLog(@"请求失败 : %@", error);
    }];
    
}

- (void)curlUp {
    // 翻页动画
    [UIView beginAnimations:@"curlUp" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.computerView.backView.backView cache:YES];
    
    [self.computerView showScoreWithScoreDictionary:nil];
    
    [UIView commitAnimations];
}

-(void)transformView:(NSNotification *)notification {
    NSValue *keyBoardBeginBounds=[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect beginRect = [keyBoardBeginBounds CGRectValue];
    
    NSValue *keyBoardEndBounds=[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect  endRect = [keyBoardEndBounds CGRectValue];
    
    CGFloat deltaY = (endRect.origin.y - beginRect.origin.y) / 2;
    [UIView animateWithDuration:0.25f animations:^{
        [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + deltaY, self.view.frame.size.width, self.view.frame.size.height)];
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
