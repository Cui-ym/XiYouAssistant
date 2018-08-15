//
//  XYAEducationClassTableModel.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/25.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYAEducationClassTableModel.h"

@implementation XYAEducationClassTableModel

- (instancetype)lessonArraySort {
//    NSLog(@"%@", self);
    NSArray <XYAEducationClassTableItemModel> *array = self.Obj;
    array = (NSArray <XYAEducationClassTableItemModel> *)[array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([obj1 WEEKNUM] < [obj2 WEEKNUM]) {
            return NSOrderedAscending;
        } else {
            return NSOrderedDescending;
        }
    }];
    self.Obj = array;
    return self;
}

@end

@implementation XYAEducationClassTableItemModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.Teach_Name = [dict objectForKey:@"Teach_Name"];
        self.WEEKNUM    = [[dict objectForKey:@"WEEKNUM"] integerValue];
        self.RoomNum    = [dict objectForKey:@"RoomNum"];
        self.S_Name     = [dict objectForKey:@"S_Name"];
        self.JT_NO      = [dict objectForKey:@"JT_NO"];
        self.WEEK       = [dict objectForKey:@"WEEK"];
    }
    return self;

}

@end
