//
//  XYAAttendanceTableViewCell.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/25.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYAAttendanceTableViewCell.h"
#import "Masonry.h"

@implementation XYAAttendanceTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
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
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.2);
    }];
    self.tagLabel.adjustsFontSizeToFitWidth = YES;
    
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
