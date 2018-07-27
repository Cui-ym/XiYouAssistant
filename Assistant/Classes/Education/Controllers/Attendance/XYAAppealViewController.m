//
//  XYAAppealViewController.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/27.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYAAppealViewController.h"
#import "XYAAppealView.h"

@interface XYAAppealViewController ()

@property (nonatomic, strong) XYAAppealView *appealView;

@end

@implementation XYAAppealViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.appealView = [[XYAAppealView alloc] initWithFrame:self.view.bounds];
    [self.appealView.confirmButton addTarget:self action:@selector(appealAttendance:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_appealView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(recycleKeyboard)];
    tapGesture.numberOfTapsRequired = 1;
    [self.appealView addGestureRecognizer:tapGesture];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(transformView:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark - clickAction

- (void)recycleKeyboard {
    NSLog(@"回收键sa盘");
    [self.view endEditing:YES];
}

- (void)appealAttendance:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

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
