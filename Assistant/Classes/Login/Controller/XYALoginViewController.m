//
//  XYALoginViewController.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/23.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYALoginViewController.h"
#import "XYAUnderLinerTextField.h"
#import "XYAEducationManager.h"
#import "XYAEducationAPI.h"
#import "XYALoginView.h"


#import "AFNetworking.h"

@interface XYALoginViewController ()

@property (nonatomic, strong) XYALoginView *loginView;

@property (nonatomic, strong) XYAEducationAPI *educationApi;

@end

@implementation XYALoginViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.20f green:0.60f blue:0.86f alpha:1.00f];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],
                                                NSFontAttributeName            : [UIFont systemFontOfSize:20]}];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = [NSString stringWithFormat:@"绑定%@", self.type];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.educationApi = [[XYAEducationAPI alloc] init];
    [self getVercode];
    
    self.loginView = [[XYALoginView alloc] initWithFrame:self.view.bounds];
    self.loginView.titleLabel.text = [NSString stringWithFormat:@"%@登陆", self.type];
    [self.view addSubview:_loginView];
    
    [self.loginView.loginButton addTarget:self action:@selector(clickLoginButton:) forControlEvents:UIControlEventTouchUpInside];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChange) name:UITextFieldTextDidChangeNotification object:nil];
    // Do any additional setup after loading the view.
}

#pragma mark - KVO

- (void)textFieldChange {
    if ([self.loginView.userNameField.text  isEqual: @""] || [self.loginView.passwordField.text  isEqual: @""] || [self.loginView.vercodeField.text  isEqual: @""]) {
        self.loginView.loginButton.userInteractionEnabled = NO;
        self.loginView.loginButton.alpha = 0.4;
    } else {
        self.loginView.loginButton.userInteractionEnabled = YES;
        self.loginView.loginButton.alpha = 1;
    }
}

#pragma mark - ClickAction

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)clickLoginButton:(UIButton *)button {
    [self educationLogin];
}

#pragma mark - HTTP

- (void)getVercode {
    [self.educationApi getCookieAndVerCodeApi];
    XYAEducationManager *manager = [[XYAEducationManager alloc] init];
    [manager fetchEducationVercodeFromNetSuccess:^(NSData * _Nullable imageData) {
        [self.loginView.vercodeimageView setImage:[UIImage imageWithData:imageData]];
    } error:^(NSError * _Nonnull error) {
        NSLog(@"error %@", error);
    }];
}

- (void)educationLogin {
    XYAEducationManager *manager = [[XYAEducationManager alloc] init];
    [manager fetchEducationLoginWithUsername:_loginView.userNameField.text password:_loginView.passwordField.text vercode:_loginView.vercodeField.text success:^(XYAEducationResultModel * _Nullable educationResult) {
        NSLog(@"%@", educationResult);
    } error:^(NSError * _Nonnull error) {
        NSLog(@"error  %@", error);
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
