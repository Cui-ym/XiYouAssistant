//
//  XYAMainLoginViewController.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/20.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYAMainLoginViewController.h"
#import "XYALoginViewController.h"
#import "XYAMainLoginView.h"
#import "XYALoginButton.h"

@interface XYAMainLoginViewController ()

@property (nonatomic, strong) XYAMainLoginView *loginView;

@end

@implementation XYAMainLoginViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginView = [[XYAMainLoginView alloc] initWithFrame:self.view.frame];
    [_loginView.personLogin addTarget:self action:@selector(clickLogin:) forControlEvents:UIControlEventTouchUpInside];
    [_loginView.weChatLogin addTarget:self action:@selector(clickLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginView];
}

- (void)clickLogin:(UIButton *)sender {
    XYALoginViewController *loginViewController = [[XYALoginViewController alloc] init];
    if ([sender.titleLabel.text  isEqual: @"学号登陆"]) {
        loginViewController.type = @"智慧教室";
    }
    loginViewController.type = @"教务系统";
    [self.navigationController pushViewController:loginViewController animated:YES];
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
