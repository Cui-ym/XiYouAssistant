//
//  XYAAddClassTableViewCell.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/8/2.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYAAddClassTableViewCell.h"
#import "Masonry.h"

@interface XYAAddClassTableViewCell ()

@property (nonatomic, strong) UIView *underLineView;

@end

@implementation XYAAddClassTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.iconImageview = [[UIImageView alloc] init];
        [self.contentView addSubview:_iconImageview];
        
        self.underLineView = [[UIView alloc] init];
        [self.contentView addSubview:_underLineView];
        
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLabel];
        
        self.detailTextField = [[UITextField alloc] init];
        [self.contentView addSubview:_detailTextField];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.iconImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(35);
        make.top.equalTo(self.contentView.mas_top).offset(20);
        make.width.and.height.mas_equalTo(20);
    }];
    self.iconImageview.contentMode = UIViewContentModeScaleToFill;
    self.iconImageview.backgroundColor = [UIColor clearColor];
    
    [self.underLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-1);
        make.height.mas_equalTo(1);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.6);
        make.left.equalTo(self.iconImageview.mas_right).offset(25);
    }];
    self.underLineView.backgroundColor = [UIColor colorWithRed:0.80f green:0.80f blue:0.80f alpha:1.00f];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.underLineView.mas_left).offset(5);
        make.centerY.equalTo(self.iconImageview);
        make.width.equalTo(self.underLineView.mas_width).multipliedBy(0.25);
    }];
    self.titleLabel.textColor = [UIColor colorWithRed:0.20f green:0.60f blue:0.86f alpha:1.00f];
    self.titleLabel.text = @"地点";
    
    [self.detailTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right);
        make.right.equalTo(self.contentView.mas_right);
        make.centerY.equalTo(self.titleLabel);
        make.height.equalTo(self.contentView).multipliedBy(0.25);
    }];
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
