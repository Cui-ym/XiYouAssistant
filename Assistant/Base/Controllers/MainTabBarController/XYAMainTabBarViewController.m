//
//  XYAMainTabBarViewController.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/20.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYAMainTabBarViewController.h"

static NSString * const TabbarVC = @"VC";
static NSString * const TabbarTitle = @"title";
static NSString * const TabbarImage = @"image";
static NSString * const TabbarSelectedImage = @"selectImage";
static NSString * const TabbarItemBadgeValue = @"badgeValue";

typedef NS_ENUM(NSInteger, XYMainTabType) {
    XYMainTabTypeEducation,     // 教务
    XYMainTabTypeLibrary,       // 图书
    XYMainTabTypeActivity,      // 活动
    XYMainTabTypeMyInfo         // 我的
};

@interface XYAMainTabBarViewController ()

@end

@implementation XYAMainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tabBar.translucent = NO;
    
    [self setUpSubNav];
}

- (NSArray *)tabbars {
    NSMutableArray *items = [NSMutableArray array];
    for (NSInteger tabbar = 0; tabbar < 4; tabbar++) {
        [items addObject:@(tabbar)];
    }
    return items;
}

- (void)setUpSubNav {
    self.tabBar.hidden = NO;
    NSMutableArray *vcArray = [NSMutableArray array];
    [self.tabbars enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSDictionary *item = [self vcConfigForTabType:[obj  integerValue]];
        NSString *vcName = item[TabbarVC];
        NSString *title  = item[TabbarTitle];
        NSString *imageName = item[TabbarImage];
        NSString *imageSelected = item[TabbarSelectedImage];
        Class clazz = NSClassFromString(vcName);
        UIViewController *vc = [[clazz alloc] initWithNibName:nil bundle:nil];
        vc.hidesBottomBarWhenPushed = NO;
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:nil selectedImage:nil];
        nav.tabBarItem.tag = idx;
        [vcArray addObject:nav];
    }];
    self.viewControllers = [NSArray arrayWithArray:vcArray];
}

- (NSDictionary *)vcConfigForTabType:(XYMainTabType)type {
    static NSDictionary *dictionary;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dictionary = @{
                       @(XYMainTabTypeEducation) : @{
                               TabbarVC             :@"XYAEdcationViewController",
                               TabbarTitle          :@"教务",
                               TabbarImage          :@"",
                               TabbarSelectedImage  :@""
                               },
                       @(XYMainTabTypeLibrary) : @{
                               TabbarVC             :@"XYALibraryViewController",
                               TabbarTitle          :@"图书",
                               TabbarImage          :@"",
                               TabbarSelectedImage  :@""
                               },
                       @(XYMainTabTypeActivity) : @{
                               TabbarVC             :@"XYAActivityViewController",
                               TabbarTitle          :@"活动",
                               TabbarImage          :@"",
                               TabbarSelectedImage  :@""
                               },
                       @(XYMainTabTypeMyInfo) : @{
                               TabbarVC             :@"XYAMyInfoViewController",
                               TabbarTitle          :@"我的",
                               TabbarImage          :@"",
                               TabbarSelectedImage  :@""
                               }
                       };
    });
    return dictionary[@(type)];
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
