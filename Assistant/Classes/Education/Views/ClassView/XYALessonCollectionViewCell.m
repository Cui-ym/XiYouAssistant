//
//  XYALessonCollectionViewCell.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/8/1.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYALessonCollectionViewCell.h"
#import "Masonry.h"

@interface XYALessonCollectionViewCell ()


@end

@implementation XYALessonCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backView = [[UIView alloc] init];
        [self addSubview:_backView];
        
        self.lessonLabel = [[UILabel alloc] init];
        [self.backView addSubview:_lessonLabel];
        
        self.classLabel = [[UILabel alloc] init];
        [self.backView addSubview:_classLabel];
    }
    
    \
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    self.backView.layer.shadowRadius = 2;
    self.backView.layer.cornerRadius = 5;
    self.backView.layer.shadowOpacity = 0.5;
    self.backView.layer.shadowOffset = CGSizeMake(0,0);
    self.backView.layer.shadowColor = [UIColor blackColor].CGColor;
    
    [self.lessonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView.mas_top).offset(5);
        make.left.and.right.equalTo(self.backView);
    }];
    self.lessonLabel.numberOfLines = 0;
    self.lessonLabel.textColor = [UIColor whiteColor];
    self.lessonLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
    self.lessonLabel.textAlignment = NSTextAlignmentCenter;
}

@end
