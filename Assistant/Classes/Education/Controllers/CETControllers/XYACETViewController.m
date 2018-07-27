//
//  XYACETViewController.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/27.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYACETViewController.h"
#import "XYACETView.h"

@interface XYACETViewController ()

@property (nonatomic, strong) XYACETView *CETView;

@end

@implementation XYACETViewController

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

- (void)clickQueryButton:(UIButton *)sender {
    // 翻页动画
    [UIView beginAnimations:@"curlUp" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.CETView.backView cache:YES];
    
    [self.CETView showScoreWithScoreDictionary:nil];
    
    [UIView commitAnimations];
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
