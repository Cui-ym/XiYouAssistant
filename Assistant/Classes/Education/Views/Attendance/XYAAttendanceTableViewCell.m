//
//  XYAAttendanceTableViewCell.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/25.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYAAttendanceTableViewCell.h"
#import "Masonry.h"

@interface XYAAttendanceTableViewCell ()

@property (nonatomic, strong) UIFont *font;

@end

@implementation XYAAttendanceTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self gitFont];
        
        self.timeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_timeLabel];
        
        self.weekLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_weekLabel];
        
        self.tagLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_tagLabel];
        
        self.classLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_classLabel];
        
        self.detailLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_detailLabel];
        
        self.appealButton = [[UIButton alloc] init];
        [self.contentView addSubview:_appealButton];
    }
    return self;
}

-(void)gitFont {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0.2 * self.frame.size.width, self.frame.size.height)];
    label.text = @"201806.06";
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
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.23);
    }];
    self.timeLabel.font = self.font;
    
    [self.weekLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLabel.mas_right);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.16);
        make.top.and.bottom.equalTo(self.timeLabel);
    }];
    self.weekLabel.font = self.font;
    
    [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.weekLabel.mas_right);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.11);
        make.top.and.bottom.equalTo(self.timeLabel);
    }];
    self.tagLabel.font = self.font;
    
    [self.classLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tagLabel.mas_right);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.16);
        make.top.and.bottom.equalTo(self.timeLabel);
    }];
    self.classLabel.font = self.font;
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.classLabel.mas_right);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.1);
        make.top.and.bottom.equalTo(self.timeLabel);
    }];
    self.detailLabel.font = self.font;
    
    [self.appealButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.detailLabel.mas_right);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.15);
        make.height.equalTo(self.contentView.mas_height).multipliedBy(0.5);
        make.centerY.equalTo(self.contentView);
    }];
    self.appealButton.layer.masksToBounds = YES;
    self.appealButton.layer.cornerRadius = self.contentView.frame.size.height / 4;
    [self.appealButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.appealButton setTitle:@"申诉" forState:UIControlStateNormal];
    self.appealButton.titleLabel.font = self.font;
    
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
