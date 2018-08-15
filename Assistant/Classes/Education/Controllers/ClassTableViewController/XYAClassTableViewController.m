//
//  XYAClassTableViewController.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/31.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYAClassTableViewController.h"
#import "XYAClassTableView.h"

#import "XYAAddClassViewController.h"

#import "XYALessonTableDBManager.h"
#import "XYAEducationClassTableModel.h"

@interface XYAClassTableViewController ()

@property (nonatomic, strong) XYAClassTableView *classView;
@property (nonatomic, strong) XYAEducationClassTableModel *lessonModel;

@end

@implementation XYAClassTableViewController


- (void)viewWillAppear:(BOOL)animated {
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [button setImage:[UIImage imageNamed:@"icon_lesson_normal"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"icon_lesson_selected"] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(clickAddButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rewardItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rewardItem;
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getLessonTableWithWeek:5];
    self.classView = [[XYAClassTableView alloc] initWithFrame:self.view.bounds];
    [self.classView showLessonCollectionWithModel:_lessonModel];
    [self.view addSubview:_classView];
    // Do any additional setup after loading the view.
}

#pragma mark - lessonDB

- (void)getLessonTableWithWeek:(NSInteger)week {
    self.lessonModel = [[XYAEducationClassTableModel alloc] init];
    _lessonModel = [[XYALessonTableDBManager sharedManager] getLessonModelWithWeek:week];
    
}

#pragma mark - buttonAction

- (void)clickAddClassButton:(UIButton *)sender {
    XYAAddClassViewController *addClassViewController = [[XYAAddClassViewController alloc] init];
    [self.navigationController pushViewController:addClassViewController animated:YES];
}

- (void)clickAddButton:(UIButton *)sender {
    if (sender.selected == NO) {
        [self.classView slideAddLessonView];
        [self.classView.addButton addTarget:self action:@selector(clickAddClassButton:) forControlEvents:UIControlEventTouchUpInside];
        sender.selected = YES;
    } else {
        [self.classView removeAddLessonView];
        sender.selected = NO;
    }
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
