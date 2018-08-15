//
//  XYAClassTableView.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/31.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYAClassTableView.h"
#import "XYALessonCollectionViewCell.h"
#import "XYAEducationClassTableModel.h"
#import "Masonry.h"

@interface XYAClassTableView () <UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *dayView;
@property (nonatomic, strong) UIView *classView;
@property (nonatomic, strong) UIScrollView *backScrollView;

@property (nonatomic, strong) UICollectionView *lessonCollectionView ;
@property (nonatomic, copy) NSArray <XYAEducationClassTableItemModel> *lessonArray;

@property (nonatomic, strong) UIView *grayBackgroundView;
@property (nonatomic, strong) UIView *addLessonView;


@end

@implementation XYAClassTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backScrollView = [[UIScrollView alloc] init];
        [self addSubview:_backScrollView];
        
        self.classView = [[UIView alloc] init];
        [self.backScrollView addSubview:_classView];
        
        self.dayView = [[UIView alloc] init];
        [self addSubview:_dayView];
        
        [self initDayView];
        
        [self initClassView];
        
    }
    return self;
}

- (void)slideAddLessonView {
    self.grayBackgroundView.hidden = NO;
    
    self.addLessonView.backgroundColor = [UIColor whiteColor];
    [UIView animateWithDuration:.25f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.addLessonView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height * 0.37);
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)removeAddLessonView {
    self.grayBackgroundView.hidden = YES;
    
    [UIView animateWithDuration:.25f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.addLessonView.frame = CGRectMake(0, self.frame.size.height * -0.37, self.frame.size.width, self.frame.size.height * 0.37);
    } completion:^(BOOL finished) {
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor = [UIColor whiteColor];
    
}

#pragma mark - UICollectionView

- (void)showLessonCollectionWithModel:(XYAEducationClassTableModel *)model {
    self.lessonCollectionView.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1.00f];
    [self.lessonCollectionView registerClass:[XYALessonCollectionViewCell class] forCellWithReuseIdentifier:@"collectionViewCell"];
    self.lessonArray = model.Obj;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 5;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *string = [NSString stringWithFormat:@"%ld-%ld", (indexPath.row + 1) * 2 - 1, (indexPath.row + 1) * 2];
    
    NSArray *firstColorArray = [NSArray arrayWithObjects:[UIColor colorWithRed:0.31f green:0.72f blue:0.85f alpha:1.00f], [UIColor colorWithRed:0.98f green:0.79f blue:0.31f alpha:1.00f], [UIColor colorWithRed:0.70f green:0.93f blue:0.81f alpha:1.00f], [UIColor colorWithRed:0.97f green:0.85f blue:0.96f alpha:1.00f], nil];
    NSArray *secondColorArray = [NSArray arrayWithObjects:[UIColor colorWithRed:0.70f green:0.93f blue:0.81f alpha:1.00f], [UIColor colorWithRed:0.97f green:0.85f blue:0.96f alpha:1.00f], [UIColor colorWithRed:0.31f green:0.72f blue:0.85f alpha:1.00f], [UIColor colorWithRed:0.98f green:0.79f blue:0.31f alpha:1.00f], nil];
    
    XYALessonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell" forIndexPath:indexPath];
    cell.backView.backgroundColor = [UIColor clearColor];
    for (int i = 0; i < self.lessonArray.count; i++) {
        XYAEducationClassTableItemModel *item = _lessonArray[i];
        if (item.WEEKNUM == indexPath.section + 1 && [item.JT_NO isEqualToString:string]) {
            // 设置颜色
            if ((indexPath.section + 1) % 2 == 1) {
                cell.backView.backgroundColor = firstColorArray[indexPath.row % 4];
            } else {
                cell.backView.backgroundColor = secondColorArray[indexPath.row % 4];
            }
            // 设置文本
            NSString *lessonString = [NSString stringWithFormat:@"%@\n@\n%@", item.S_Name, item.RoomNum];
            cell.lessonLabel.text = lessonString;
            break;
        }
    }
    
    return cell;
}

#pragma mark - init

- (void)initClassView {
    
    [self.backScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(-64);
    }];
    self.backScrollView.bounces = NO;
    [self.backScrollView setShowsVerticalScrollIndicator:NO];
    self.backScrollView.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1.00f];
    self.backScrollView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height * 1.2);
    
    self.classView.backgroundColor = [UIColor colorWithRed:0.20f green:0.60f blue:0.86f alpha:1.00f];
    self.classView.alpha = 0.5;
    [self.classView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.bottom.equalTo(_backScrollView);
        make.width.equalTo(_backScrollView.mas_width).multipliedBy(0.08);
    }];
    
    NSArray *array = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10"];
    NSMutableArray *labelArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 10; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.text = array[i];
        [labelArray addObject:label];
        [self.classView addSubview:label];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentCenter;
    }
    [labelArray mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0.07 * self.frame.size.height leadSpacing:0.127 * self.frame.size.height tailSpacing:0.05 * self.frame.size.height];
    [labelArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.classView);
    }];
}

- (void)initDayView {
    
    [self.dayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.height.equalTo(self.mas_height).multipliedBy(0.07);
        make.left.and.right.equalTo(self);
    }];
    self.dayView.backgroundColor = [UIColor colorWithRed:0.20f green:0.60f blue:0.86f alpha:1.00f];
    self.dayView.alpha = 0.5;
    
    UILabel *monthLabel = [[UILabel alloc] init];
    [self.dayView addSubview:monthLabel];
    [monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.and.top.equalTo(self.dayView);
        make.left.equalTo(self.dayView.mas_left);
        make.width.equalTo(self.dayView.mas_width).multipliedBy(0.08);
    }];
    monthLabel.text = @"7\n月";
    monthLabel.numberOfLines = 2;
    monthLabel.textColor = [UIColor whiteColor];
    monthLabel.font = [UIFont systemFontOfSize:15];
    monthLabel.textAlignment = NSTextAlignmentCenter;
    
    NSArray *array = @[@"周一\n23日", @"周二\n24日", @"周三\n25日", @"周四\n26日", @"周五\n27日"];
    NSMutableArray *weekMutbaleArray = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 5; i++) {
        UILabel *Label = [[UILabel alloc] init];
        Label.text = array[i];
        Label.numberOfLines = 2;
        [self.dayView addSubview:Label];
        [weekMutbaleArray addObject:Label];
        Label.textColor = [UIColor whiteColor];
        Label.font = [UIFont systemFontOfSize:14];
        Label.textAlignment = NSTextAlignmentCenter;
    }
    
    [weekMutbaleArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0.09 * self.frame.size.width leadSpacing:0.146 * self.frame.size.width tailSpacing:0.046 * self.frame.size.width];
    [weekMutbaleArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self.dayView);
    }];
}

#pragma mark - tableViewDelegate && datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.addLessonView.frame.size.height * 0.2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"tableViewCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSArray *titleArray = @[@"当前学期", @"当前周数"];
    NSArray *detailArray = @[@"大一第一学期", @"第1周"];
    cell.textLabel.text = titleArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.text = detailArray[indexPath.row];
    return cell;
}

#pragma mark - 懒加载
- (UIView *)addLessonView {
    if (_addLessonView == nil) {
        _addLessonView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height * -0.37, self.frame.size.width, self.frame.size.height * 0.37)];
        _addLessonView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_addLessonView];
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.08 * self.frame.size.width, 0.18 * _addLessonView.frame.size.height, 0.91 * self.frame.size.width, 0.4 * _addLessonView.frame.size.height) style:UITableViewStylePlain];
        [_addLessonView addSubview:tableView];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.userInteractionEnabled = NO;
        
        _addButton = [[UIButton alloc] init];
        [_addLessonView addSubview:_addButton];
        [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_addLessonView);
            make.width.equalTo(_addLessonView.mas_width).multipliedBy(0.53);
            make.top.equalTo(_addLessonView.mas_bottom).multipliedBy(0.7);
            make.height.equalTo(_addLessonView.mas_height).multipliedBy(0.16);
        }];
        [_addButton setTitle:@"手动添加课程" forState:UIControlStateNormal];
        _addButton.backgroundColor = [UIColor colorWithRed:0.20f green:0.60f blue:0.86f alpha:1.00f];
        _addButton.layer.masksToBounds = YES;
        _addButton.layer.cornerRadius = _addLessonView.frame.size.height * 0.08;
    }
    return _addLessonView;
}

- (UIView *)grayBackgroundView {
    if (_grayBackgroundView == nil) {
        _grayBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
        _grayBackgroundView.backgroundColor = [UIColor blackColor];
        _grayBackgroundView.alpha = 0.2;
        [self addSubview:_grayBackgroundView];
    }
    return _grayBackgroundView;
}

- (UICollectionView *)lessonCollectionView {
    if (_lessonCollectionView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        flowLayout.minimumLineSpacing = 0.04 * self.frame.size.height;
        flowLayout.minimumInteritemSpacing = 0.013 * self.frame.size.width;
        flowLayout.itemSize = CGSizeMake(self.frame.size.width * 0.92 * 0.165, self.frame.size.height * 0.18);
        flowLayout.sectionInset = UIEdgeInsetsMake(0.04 * self.frame.size.height / 2.0, 5, 0.04 * self.frame.size.height / 2.0, 5);
        
        _lessonCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _lessonCollectionView.scrollEnabled = NO;
        [_backScrollView addSubview:_lessonCollectionView];
        [_lessonCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.classView.mas_right).offset(4);
            make.top.equalTo(self.backScrollView.mas_bottom).multipliedBy(0.075);
            make.right.equalTo(self).offset(-4);
            make.bottom.equalTo(self.backScrollView).offset(0);
        }];
        _lessonCollectionView.delegate = self;
        _lessonCollectionView.dataSource = self;
    }
    return _lessonCollectionView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
