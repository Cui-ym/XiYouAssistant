//
//  XYATimetableTableViewCell.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/20.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYATimetableTableViewCell.h"
#import "XYATimetableLabel.h"
#import "Masonry.h"

@interface XYATimetableTableViewCell ()

@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIView *background;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) XYATimetableLabel *titleLabel;
@property (nonatomic, strong) XYATimetableLabel *morningLabel;
@property (nonatomic, strong) XYATimetableLabel *afternoonLabel;

@end

@implementation XYATimetableTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.frame = [UIScreen mainScreen].bounds;
        [self getLabelFontWithLabel];
        [self initUI];
    }
    return self;
}

// 计算字体大小
- (void)getLabelFontWithLabel {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0.2 * self.contentView.frame.size.width, 1 * self.contentView.frame.size.height)];
    label.text = @"5-6 FZ203";
    float fontSize = label.font.pointSize;
    CGRect labelBounds = [label bounds];
    while (fontSize > label.minimumScaleFactor && fontSize > 0.0f) {
        CGRect rect = CGRectZero;
        rect = [label.text boundingRectWithSize:CGSizeMake(rect.size.width, MAXFLOAT) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
        if (rect.size.width < labelBounds.size.width && rect.size.height <= labelBounds.size.height) {
            break;
        }
        fontSize -= 0.1f;
    }
    if (fontSize < label.minimumScaleFactor) {
        fontSize = label.minimumScaleFactor;
    }
    self.font = label.font;
    self.font = [self.font fontWithSize:fontSize];
    NSLog(@"%@ %lf", self.font, self.contentView.frame.size.width);
}


# pragma mark - init

- (void)layoutSubviews {
    
    self.background.backgroundColor = [UIColor colorWithRed:0.36f green:0.68f blue:0.89f alpha:1.00f];
    self.background.layer.masksToBounds = YES;
    self.background.layer.cornerRadius = 10;
    [self.background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(17);
        make.height.equalTo(self.contentView.mas_height).multipliedBy(0.82);
        make.centerX.equalTo(self.contentView);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.93);
    }];
    
    self.titleLabel.text = @"今日课表";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.background);
        make.width.equalTo(self.background.mas_width);
        make.top.equalTo(self.background.mas_top);
        make.height.equalTo(self.contentView.mas_height).multipliedBy(0.23);
    }];
    
    self.line.backgroundColor = [UIColor whiteColor];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.background);
        make.width.equalTo(self.background.mas_width).multipliedBy(0.8);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(1);
        make.height.mas_equalTo(1);
    }];
    
    self.firstClassroom.text = @"1-2 FZ203";
    self.firstClassroom.font = self.font;
    [self.firstClassroom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.line.mas_centerX);
        make.width.equalTo(self.line.mas_width).multipliedBy(0.27);
        make.top.equalTo(self.line.mas_bottom).offset(12);
        make.height.equalTo(self.contentView.mas_height).multipliedBy(0.12);
    }];
    
    self.morningLabel.text = @"上午：";
    self.morningLabel.font = self.font;
    [self.morningLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.firstClassroom.mas_left).offset(-10);
        make.top.equalTo(self.line.mas_bottom).offset(12);
        make.height.equalTo(self.contentView.mas_height).multipliedBy(0.12);
    }];
    
    self.firstClass.text = @"C语言课程设计";
    self.firstClass.font = self.font;
    [self.firstClass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.line.mas_centerX).offset(5);
        make.top.equalTo(self.morningLabel.mas_top);
        make.height.equalTo(self.contentView.mas_height).multipliedBy(0.12);
    }];
    
    
    self.secondClassroom.text = @"3-4 无";
    self.secondClassroom.font = self.font;
    [self.secondClassroom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.line.mas_centerX);
        make.width.equalTo(self.line.mas_width).multipliedBy(0.27);
        make.top.equalTo(self.firstClassroom.mas_bottom);
        make.height.equalTo(self.contentView.mas_height).multipliedBy(0.12);
    }];
    
    self.secondClass.text = @"";
    self.secondClass.font = self.font;
    [self.secondClass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.line.mas_centerX).offset(5);
        make.top.equalTo(self.secondClassroom.mas_top);
        make.height.equalTo(self.contentView.mas_height).multipliedBy(0.12);
    }];
    
    self.afternoonLabel.text = @"下午：";
    self.afternoonLabel.font = self.font;
    [self.afternoonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.morningLabel.mas_left);
        make.top.equalTo(self.secondClassroom.mas_bottom);
        make.height.equalTo(self.contentView.mas_height).multipliedBy(0.12);
    }];
    
    self.thirdClassroom.text = @"5-6 FZ303";
    self.thirdClassroom.font = self.font;
    [self.thirdClassroom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.line.mas_centerX);
        make.width.equalTo(self.line.mas_width).multipliedBy(0.27);
        make.top.equalTo(self.afternoonLabel.mas_top);
        make.height.equalTo(self.contentView.mas_height).multipliedBy(0.12);
    }];
    
    self.thirdClass.text = @"C语言课程设计";
    self.thirdClass.font = self.font;
    [self.thirdClass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.line.mas_centerX).offset(5);
        make.top.equalTo(self.afternoonLabel.mas_top);
        make.height.equalTo(self.contentView.mas_height).multipliedBy(0.12);
    }];
    
    
    self.fouthClassroom.text = @"7-8 无";
    self.fouthClassroom.font = self.font;
    [self.fouthClassroom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.line.mas_centerX);
        make.width.equalTo(self.line.mas_width).multipliedBy(0.27);
        make.top.equalTo(self.thirdClassroom.mas_bottom);
        make.height.equalTo(self.contentView.mas_height).multipliedBy(0.12);
    }];
    
    self.fouthClass.text = @"";
    self.fouthClass.font = self.font;
    [self.fouthClass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.line.mas_centerX).offset(5);
        make.top.equalTo(self.fouthClassroom.mas_top);
        make.height.equalTo(self.contentView.mas_height).multipliedBy(0.12);
    }];
    
    self.bottomLine.backgroundColor = [UIColor colorWithRed:0.81f green:0.81f blue:0.81f alpha:1.00f];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.width.equalTo(self.contentView.mas_width);
        make.top.equalTo(self.contentView.mas_bottom).offset(-0.5);
        make.height.mas_equalTo(0.5);
    }];
}

- (void)initUI {
    self.background = [[UIView alloc] init];
    [self.contentView addSubview:_background];
    
    self.titleLabel = [[XYATimetableLabel alloc] init];
    [self.background addSubview:_titleLabel];
    
    self.line = [[UIView alloc] init];
    [self.background addSubview:_line];
    
    self.morningLabel = [[XYATimetableLabel alloc] init];
    [self.background addSubview:_morningLabel];
    
    self.firstClassroom = [[XYATimetableLabel alloc] init];
    [self.background addSubview:_firstClassroom];
    
    self.firstClass = [[XYATimetableLabel alloc] init];
    [self.background addSubview:_firstClass];
    
    self.secondClassroom = [[XYATimetableLabel alloc] init];
    [self.background addSubview:_secondClassroom];
    
    self.secondClass = [[XYATimetableLabel alloc] init];
    [self.background addSubview:_secondClass];
    
    self.afternoonLabel = [[XYATimetableLabel alloc] init];
    [self.background addSubview:_afternoonLabel];
    
    self.thirdClassroom = [[XYATimetableLabel alloc] init];
    [self.background addSubview:_thirdClassroom];
    
    self.thirdClass = [[XYATimetableLabel alloc] init];
    [self.background addSubview:_thirdClass];
    
    self.fouthClassroom = [[XYATimetableLabel alloc] init];
    [self.background addSubview:_fouthClassroom];
    
    self.fouthClass = [[XYATimetableLabel alloc] init];
    [self.background addSubview:_fouthClass];
    
    self.bottomLine = [[XYATimetableLabel alloc] init];
    [self.contentView addSubview:_bottomLine];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
