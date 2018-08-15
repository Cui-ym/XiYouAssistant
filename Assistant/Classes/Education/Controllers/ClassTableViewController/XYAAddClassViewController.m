//
//  XYAAddClassViewController.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/8/1.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYAAddClassViewController.h"
#import "XYAAddClassView.h"

@interface XYAAddClassViewController ()

@property (nonatomic, strong) XYAAddClassView *addClassView;

@end

@implementation XYAAddClassViewController

- (void)viewWillAppear:(BOOL)animated {
    self.navigationItem.title = @"添加课程";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.addClassView = [[XYAAddClassView alloc] initWithFrame:self.view.bounds];
    [self.addClassView.saveButton addTarget:self action:@selector(clickSaveButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addClassView];
    // Do any additional setup after loading the view.
}

#pragma mark - buttonAction
- (void)clickSaveButton:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
