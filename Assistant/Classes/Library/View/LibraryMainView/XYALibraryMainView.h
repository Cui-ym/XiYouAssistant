//
//  XYALibraryMainView.h
//  Assistant
//
//  Created by 满脸胡茬的怪蜀黍 on 2018/8/2.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XYALibraryMainViewDelegate<NSObject>

- (void)selectedCellWithType:(NSString *)type;


@end

@interface XYALibraryMainView : UIView

@property(nonatomic, weak) id<XYALibraryMainViewDelegate> delegate;

@end
