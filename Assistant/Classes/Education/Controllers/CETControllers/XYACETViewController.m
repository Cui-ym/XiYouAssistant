//
//  XYACETViewController.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/27.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYACETViewController.h"
#import "XYAUnderLinerTextField.h"
#import "XYAComputerVercodeView.h"
#import "XYAClipBackgroundView.h"
#import "XYAEnglishManager.h"
#import "XYACETView.h"

@interface XYACETViewController ()

@property (nonatomic, strong) XYACETView *CETView;
@property (nonatomic, strong) XYAEnglishManager *englishManager;
@property (nonatomic, copy) NSString *vercodeURL;
@property (nonatomic, strong) UIAlertController *alert;

@property (nonatomic, assign) NSInteger *flag;

@end

@implementation XYACETViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.CETView = [[XYACETView alloc] initWithFrame:self.view.bounds];
    [self.CETView.queryButton addTarget:self action:@selector(clickQueryButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_CETView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(recycleKeyboard)];
    tapGesture.numberOfTapsRequired = 1;
    [self.CETView addGestureRecognizer:tapGesture];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(transformView:) name:UIKeyboardWillChangeFrameNotification object:nil];
    // Do any additional setup after loading the view.
}

- (void)recycleKeyboard {
    NSLog(@"回收键盘");
    [self.view endEditing:YES];
}

#pragma mark - buttonAction

- (void)clickQueryButton:(UIButton *)sender {
    NSInteger numberLength = self.CETView.numberTextField.text.length;
    if (numberLength != 15) {
        [self initAlertWithMessage:@"请输入15位验证码"];
    } else {
        [self getCetGrades];
    }
}

- (void)initAlertWithMessage:(NSString *)message {
    _alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:_alert animated:YES completion:nil];
    [self performSelector:@selector(deleteAlert) withObject:nil afterDelay:0.5];
}

- (void)deleteAlert {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - HTTP

- (void)getVercodeImage {
    self.englishManager = [XYAEnglishManager shareEnglishManager];
    [_englishManager fetchEnglishVercodeWithUrl:_vercodeURL Success:^(NSData * _Nullable imageData) {
        [self.CETView initVercodeViewWithImageDate:imageData];
    } error:^(NSError * _Nonnull error) {
        NSLog(@"验证码获取失败");
    }];
}

- (void)getCetGrades {
    self.englishManager = [XYAEnglishManager shareEnglishManager];
    [self.englishManager fetchEnglishResultModelWithUsername:self.CETView.userTextField.text number:self.CETView.numberTextField.text vercode:self.CETView.vercodeView.vercodeTextField.text success:^(XYACETModel * _Nullable englishModel) {
        NSLog(@"请求成功  %@", englishModel);
        if (englishModel.code == 0) {               // 请求成功
            self.CETView.gradeDictionary = englishModel.result;
            [self curlUpView];
        } else if (englishModel.code == 80001) {     // 输入验证码
            _vercodeURL = englishModel.img_url;
            [self getVercodeImage];
        } else if (englishModel.code == -1) {
            [self initAlertWithMessage:@"请输入姓名"];
        } else if (englishModel.code == 1011) {
            [self initAlertWithMessage:@"验证码错误"];
        } else if (englishModel.code == 1012) {
            [self initAlertWithMessage:@"请确认准考证号及姓名无误"];
        }
    } error:^(NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];
}

#pragma mark - Animation

// 翻页动画
- (void)curlUpView {
    [UIView beginAnimations:@"curlUp" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.CETView.backView.backView cache:YES];
    
    [self.CETView showScoreWithScoreTableView];
    
    [UIView commitAnimations];
}

// 键盘出现 视图上移
-(void)transformView:(NSNotification *)notification
{
    NSValue *keyBoardBeginBounds=[[notification userInfo]objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect beginRect=[keyBoardBeginBounds CGRectValue];
    
    NSValue *keyBoardEndBounds=[[notification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect  endRect=[keyBoardEndBounds CGRectValue];
    
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
