//
//  XYALibraryMainView.m
//  Assistant
//
//  Created by 满脸胡茬的怪蜀黍 on 2018/8/2.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYALibraryMainView.h"
#import "XYALibraryShowLevelView.h"
#import "XYALibraryItemView.h"
#import "PCHMarqueeView.h"


@interface XYALibraryMainView ()<UITableViewDelegate, UITableViewDataSource>

//@property(nonatomic, strong) UIView *
@property (nonatomic, strong) UITableView               *mainTableView;
@property (nonatomic, strong) XYALibraryShowLevelView   *showLevelView;
@property (nonatomic, strong) XYALibraryItemView        *itemView;
@property (nonatomic, strong) NSArray                   *textLabelArray;
@property (nonatomic, strong) NSArray                   *imageNameArray;
@property (nonatomic, strong) UILabel                   *marqueeLabel;
@property (nonatomic, strong) PCHMarqueeView            *marqueeView;

@end

@implementation XYALibraryMainView

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textLabelArray = @[@"借阅历史", @"开馆时间", @"馆藏分布"];
        self.marqueeLabel.text = @"您借阅的《人人都是产品经理》离还书期限仅剩 1 天！";
        self.imageNameArray = @[@"BorrowHistory.png", @"OpenTime.png", @"BookDistribution.png"];
        self.mainTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        self.mainTableView.delegate = self;
        self.mainTableView.dataSource = self;
        _mainTableView.tableHeaderView = self.showLevelView;
        [self addSubview:_mainTableView];
    }
    return self;
}



#pragma mark --LazyLoad

- (XYALibraryShowLevelView *)showLevelView {
    if (!_showLevelView) {
        XYALibraryShowLevelView *showLevelView = [[XYALibraryShowLevelView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 180)];
        showLevelView.backgroundColor = [UIColor whiteColor];
        _showLevelView = showLevelView;
    }
    return _showLevelView;
    
}

- (XYALibraryItemView*)itemView {
    if (!_itemView) {
        XYALibraryItemView *itemView = [[XYALibraryItemView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 120.f)];
        
        _itemView = itemView;
    }
    return _itemView;
    
}

#pragma mark --UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"itemCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.contentView addSubview:_itemView];
        }
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.imageView.image = [UIImage imageNamed:_imageNameArray[indexPath.row]];

        cell.textLabel.text = _textLabelArray[indexPath.row];
        return cell;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

#pragma mark --UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"1");
}
//
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 50.f;
        
    }
    return 0.f;

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView * headerView = [[UIView alloc] init];
        headerView.backgroundColor = [UIColor whiteColor];
        UIImageView *noticeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"noticeTitle.png"]];
        [headerView addSubview:noticeImageView];
        
        self.marqueeView = ({
            PCHMarqueeView *marqueeView = [[PCHMarqueeView alloc] init];
            [headerView addSubview:marqueeView];
            UILabel * label = [[UILabel alloc] init];
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:17];
            label.text = @"您借阅的《人人都是产品经理》离还书期限仅剩 1 天！";
            marqueeView.contentView = label;
            marqueeView.pointsPerFrame = 0.5f;
            marqueeView.frameInterVal = 60;
            marqueeView.backgroundColor = [UIColor whiteColor];
            marqueeView.contentMargin = 50;
            marqueeView;
        });
        
        [noticeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerView.mas_left).with.offset(15);
            make.top.equalTo(headerView.mas_top).with.offset(10);
            make.bottom.equalTo(headerView.mas_bottom).with.offset(-10);
            make.width.mas_equalTo(30);
        }];
        
        [_marqueeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(noticeImageView.mas_right).with.offset(10);
            make.right.equalTo(headerView.mas_right);
            make.height.equalTo(headerView.mas_height);
        }];
        return headerView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 110.f;
    } else {
        return 60.f;
    }
}


@end
