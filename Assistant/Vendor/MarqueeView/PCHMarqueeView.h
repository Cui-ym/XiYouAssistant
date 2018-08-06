//
//  PCHMarqueeView.h
//  PCHMarqueeView
//
//  Created by 满脸胡茬的怪蜀黍 on 2018/5/5.
//  Copyright © 2018年 Puqin.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PCHMarqueeStyle) {
    PCHMarqueeStyleLeft,
    PCHMarqueeStyleRight,
    PCHMarqueeStyleReverse
};

@interface PCHMarqueeView : UIView

@property(nonatomic, assign) PCHMarqueeStyle style;
@property(nonatomic, assign) CGFloat contentMargin; // 两个视图之间的间隔
@property(nonatomic, assign) NSUInteger frameInterVal;  // 多少帧回调一次，一帧时间 1/60秒
@property(nonatomic, assign) CGFloat pointsPerFrame;    // 每次回调移动多少点
@property(nonatomic, strong) UIView *contentView;
@property(nonatomic, strong) UIView *containerView;


@end
