//
//  PCHMarqueeView.m
//  PCHMarqueeView
//
//  Created by 满脸胡茬的怪蜀黍 on 2018/5/5.
//  Copyright © 2018年 Puqin.Chen. All rights reserved.
//

#import "PCHMarqueeView.h"

@implementation PCHMarqueeView {
    CADisplayLink *_marqueeDisplayLink;
    BOOL isReserveing;
};

#pragma mark - init Method

- (instancetype)init{
    self = [super initWithFrame:CGRectZero];
    if (!self) {
        return nil;
    }
    [self commonInit];
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    [self commonInit];
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (!self) {
        return nil;
    }
    [self commonInit];
    return self;
}

- (void)commonInit {
    self.backgroundColor = [UIColor redColor];
    self.clipsToBounds = YES; // 当设置为YES，内容和子视图被剪切到视图的边界。
    
    _containerView = [[UIView alloc] init];
    _containerView.backgroundColor = [UIColor clearColor];
    [self addSubview:_containerView];
}

#pragma mark - system Method


- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview == nil) {
        [self startMarquee];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    UIView * validContenView = [[UIView alloc] init];
    validContenView = _contentView;
    
    if (!validContenView) {
        return;
    }
    for (UIView * view in _containerView.subviews) {
        [view removeFromSuperview];
    }
    
    // 对于复杂视图，需要自己重写 contentView 的 sizeThatFits 方法，返回正确的 size
    [validContenView sizeToFit];
    validContenView.frame = CGRectMake(0, 0, validContenView.bounds.size.width, self.bounds.size.height);
    [_containerView addSubview:validContenView];

    
    if (self.style == PCHMarqueeStyleReverse) {
        _containerView.frame = CGRectMake(0, 0, validContenView.bounds.size.width, self.bounds.size.height);
        
    } else {
        _containerView.frame = CGRectMake(0, 0, validContenView.bounds.size.width * 2, self.bounds.size.height);
        
    }
   
    
    if (validContenView.bounds.size.width > self.bounds.size.width) {
        if (_style != PCHMarqueeStyleReverse) {
            NSData *otherContentViewData = [NSKeyedArchiver archivedDataWithRootObject:validContenView];
            UIView *otherContentView = [NSKeyedUnarchiver unarchiveObjectWithData:otherContentViewData];
            otherContentView.frame = CGRectMake(validContenView.bounds.size.width + _contentMargin, 0, validContenView.bounds.size.width, self.bounds.size.height);
            [_containerView addSubview:otherContentView];
        }
        [self startMarquee];
    }
    
}

// 如果你的 contentView 的内容在初始化的时候，无法确定，需通过网络等延迟获取，那么在内容赋值之后，调用一下方法
- (void)reloadData {
    [self setNeedsLayout];
}

#pragma mark - private Method

- (void)startMarquee {
    
    [self stopMarquee];
    if (self.style == PCHMarqueeStyleRight) {
        CGRect frame = _containerView.frame;
        frame.origin.x = self.bounds.size.width - frame.size.width;
        _containerView.frame = frame;
    }

    _marqueeDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(processMarquee)];
    // frameInterVal :iOS 10 被弃用，标识间隔多少帧调用一次 selector 方法。默认是1
    // preferredFramesPerSecond：iOS 10 之后调用这个方法，标识每秒钟调用几次
    _marqueeDisplayLink.preferredFramesPerSecond = self.frameInterVal;
//    _marqueeDisplayLink.frameInterval = self.frameInterVal;
    [_marqueeDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)stopMarquee {
    [_marqueeDisplayLink invalidate];
    _marqueeDisplayLink = nil;
}

- (void)processMarquee {
    CGRect frame = _containerView.frame;
    switch (self.style) {
        case PCHMarqueeStyleLeft: {
            CGFloat targetX = -(_contentView.bounds.size.width + self.contentMargin);
            if (frame.origin.x <= targetX) {
                frame.origin.x = 0;
                _containerView.frame = frame;
            } else {
                frame.origin.x -= _pointsPerFrame;
                if (frame.origin.x < targetX) {
                    frame.origin.x = targetX;
                }
                _containerView.frame = frame;
            }
        }
            break;
        case PCHMarqueeStyleRight: {
            CGFloat targetX = self.bounds.size.width - self.contentView.bounds.size.width;
            if (frame.origin.x >= targetX) {
                frame.origin.x = self.bounds.size.width - _containerView.bounds.size.width;
                _containerView.frame = frame;
            } else {
                frame.origin.x += _pointsPerFrame;
                if (frame.origin.x > targetX) {
                    frame.origin.x = targetX;
                }
                _containerView.frame = frame;
            }
        }
            break;
        case PCHMarqueeStyleReverse: {
            if (isReserveing) {
                CGFloat targetX = 0;
                if (frame.origin.x > targetX) {
                    frame.origin.x = 0;
                    _containerView.frame = frame;
                    isReserveing = false;
                } else {
                    frame.origin.x += _pointsPerFrame;
                    if (frame.origin.x > 0) {
                        frame.origin.x = 0;
                        isReserveing = false;
                    }
                    _containerView.frame = frame;
                }
            } else {
                CGFloat targetX = self.bounds.size.width - _containerView.frame.size.width;
                if (frame.origin.x <= targetX) {
                    isReserveing = true;
                } else {
                    frame.origin.x -= _pointsPerFrame;
                    if (frame.origin.x < targetX) {
                        frame.origin.x = targetX;
                        isReserveing = true;
                    }
                    _containerView.frame = frame;
                }
            }
        }
        default:
            break;
    }
}

@end
