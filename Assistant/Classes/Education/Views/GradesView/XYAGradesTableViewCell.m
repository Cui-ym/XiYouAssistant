//
//  XYAGradesTableViewCell.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/31.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYAGradesTableViewCell.h"
#import "Masonry.h"

@interface XYAGradesTableViewCell ()

@property (nonatomic, strong) UIView *backView;

@end

@implementation XYAGradesTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1.00f];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backView = [[UIView alloc] init];
        [self.contentView addSubview:_backView];
        
        self.blueView = [[UIView alloc] init];
        [self.backView addSubview:_blueView];
        
        self.grayView = [[UIView alloc] init];
        [self.backView addSubview:_grayView];
        
        self.whiteView = [[UIView alloc] init];
        [self.backView addSubview:_whiteView];
        
        self.typeLabel = [[UILabel alloc] init];
        [self.blueView addSubview:_typeLabel];
        
        self.nameLabel = [[UILabel alloc] init];
        [self.blueView addSubview:_nameLabel];
        
        self.creditLabel = [[UILabel alloc] init];
        [self.grayView addSubview:_creditLabel];
        
        self.gradePointLabel = [[UILabel alloc] init];
        [self.grayView addSubview:_gradePointLabel];
        
        self.otherGradesLabel = [[UILabel alloc] init];
        [self.whiteView addSubview:_otherGradesLabel];
        
        self.totalGradesLabel = [[UILabel alloc] init];
        [self.whiteView addSubview:_totalGradesLabel];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
    }];
    self.backView.layer.masksToBounds = YES;
    self.backView.layer.cornerRadius = 8;
    
    [self.blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self.backView);
        make.height.equalTo(self.backView.mas_height).multipliedBy(0.333);
    }];
    self.blueView.backgroundColor = [UIColor colorWithRed:0.30f green:0.72f blue:1.00f alpha:1.00f];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.blueView.mas_left).offset(5);
        make.centerY.equalTo(self.blueView);
        make.width.and.height.equalTo(self.blueView.mas_height).multipliedBy(0.66);
    }];
    self.typeLabel.layer.masksToBounds = YES;
    self.typeLabel.font = [UIFont systemFontOfSize:14];
    self.typeLabel.textAlignment = NSTextAlignmentCenter;
    self.typeLabel.backgroundColor = [UIColor whiteColor];
    self.typeLabel.layer.cornerRadius = self.contentView.frame.size.height * 0.33 * 0.33;
    self.typeLabel.textColor = [UIColor colorWithRed:0.30f green:0.72f blue:1.00f alpha:1.00f];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.typeLabel.mas_right).offset(8);
        make.right.equalTo(self.blueView.mas_right);
        make.top.and.bottom.equalTo(self.typeLabel);
    }];
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.font = [UIFont systemFontOfSize:14];
    
    [self.grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.blueView.mas_bottom);
        make.right.and.left.equalTo(self.backView);
        make.height.equalTo(self.backView.mas_height).multipliedBy(0.333);
    }];
    self.grayView.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.00f];
    
    [self.creditLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.grayView.mas_left).offset(5);
        make.width.equalTo(self.grayView.mas_width).multipliedBy(0.5);
        make.centerY.equalTo(self.grayView);
        make.height.equalTo(self.grayView.mas_height).multipliedBy(0.8);
    }];
    self.creditLabel.textColor = [UIColor blackColor];
    self.creditLabel.font = [UIFont systemFontOfSize:14];
    
    [self.gradePointLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.grayView.mas_right).offset(-100);
        make.right.equalTo(self.grayView.mas_right);
        make.centerY.equalTo(self.grayView);
        make.height.equalTo(self.grayView.mas_height).multipliedBy(0.8);
    }];
    self.gradePointLabel.textColor = [UIColor blackColor];
    self.gradePointLabel.font = [UIFont systemFontOfSize:14];
    
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.grayView.mas_bottom);
        make.right.and.left.equalTo(self.backView);
        make.bottom.equalTo(self.backView.mas_bottom);
    }];
    self.whiteView.backgroundColor = [UIColor whiteColor];
    
    [self.otherGradesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.left.equalTo(self.creditLabel);
        make.centerY.equalTo(self.whiteView);
        make.height.equalTo(self.whiteView.mas_height).multipliedBy(0.8);
    }];
    self.otherGradesLabel.textColor = [UIColor blackColor];
    self.otherGradesLabel.font = [UIFont systemFontOfSize:14];
    
    [self.totalGradesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.left.equalTo(self.gradePointLabel);
        make.centerY.equalTo(self.whiteView);
        make.height.equalTo(self.whiteView.mas_height).multipliedBy(0.8);
    }];
    self.totalGradesLabel.textColor = [UIColor blackColor];
    self.totalGradesLabel.font = [UIFont systemFontOfSize:14];
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

