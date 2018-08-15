//
//  XYALessonTableDBManager.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/8/13.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYALessonTableDBManager.h"
#import "XYAUtils.h"
#import "FMDB.h"

@interface XYALessonTableDBManager ()

@property (nonatomic, strong) FMDatabase *db;

@end

@implementation XYALessonTableDBManager

static XYALessonTableDBManager *_manger = nil;

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manger = [[XYALessonTableDBManager alloc] init];
    });
    return _manger;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (BOOL)createLessonTable {
    NSString *docuPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *dbPath = [docuPath stringByAppendingPathComponent:@"lesson.db"];
    NSLog(@"%@", docuPath);
    self.db = [FMDatabase databaseWithPath:dbPath];
    if (![_db open]) {
        NSLog(@"db open fail");
        return NO;
    }
    NSString *lessonSql = @"CREATE TABLE IF NOT EXISTS lesson (JT_NO VARCHAR(255) , \
    S_Name VARCHAR(255),\
    Teach_Name VARCHAR(255) ,\
    RoomNum VARCHAR(255),\
    WEEKNUM int(11), \
    WEEK VARCHAR(255) );";
    BOOL isSuccess = NO;
    isSuccess = [_db executeUpdate:lessonSql];
    [_db close];
    return isSuccess;
}

- (XYAEducationClassTableModel *)getLessonModelWithWeek:(NSInteger)week {
    NSMutableArray *resultArray = [NSMutableArray array];
    if ([_db open]) {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM lesson where WEEK = '%@'", [NSString stringWithFormat:@"%ld", week]];
        FMResultSet *resultSet = [_db executeQuery:sql];
        while ([resultSet next]) {
            [resultArray addObject:[resultSet resultDictionary]];
        }
        [_db close];
    }
    XYAEducationClassTableModel *model = [[XYAEducationClassTableModel alloc] init];
    NSMutableArray <XYAEducationClassTableItemModel> *itemArray = [NSMutableArray<XYAEducationClassTableItemModel> array];
    for (NSInteger i = 0; i < resultArray.count; i++) {
        NSDictionary *dict = resultArray[i];
        XYAEducationClassTableItemModel *item = [[XYAEducationClassTableItemModel alloc] initWithDict:dict];
        [itemArray addObject:item];
    }
    model.Obj = itemArray;
    return model;
}

- (BOOL)insertLessonTableModel:(XYAEducationClassTableItemModel *)model {
    BOOL isSuccess = NO;
    if ([_db open]) {
        isSuccess = [self.db executeUpdate:@"INSERT INTO lesson (WEEKNUM, JT_NO, S_Name, Teach_Name, RoomNum, WEEK) VALUES (?, ?, ?, ?, ?, ?)", [NSNumber numberWithInteger:model.WEEKNUM], [XYAUtils sqliteEscape:model.JT_NO], [XYAUtils sqliteEscape:model.S_Name], [XYAUtils sqliteEscape:model.Teach_Name], [XYAUtils sqliteEscape:model.RoomNum], model.WEEK];
        [_db close];
        isSuccess = YES;
    }
    return isSuccess;
}

- (BOOL)insertLessonTableModels:(XYAEducationClassTableModel *)models {
    NSArray <XYAEducationClassTableItemModel> *lessonList = models.Obj;
    BOOL isSuccess = NO;
    if ([_db open]) {
        for (XYAEducationClassTableItemModel *item in lessonList) {
            isSuccess = [self.db executeUpdate:@"INSERT INTO lesson (WEEKNUM, JT_NO, S_Name, Teach_Name, RoomNum, WEEK) VALUES (?, ?, ?, ?, ?, ?)", [NSNumber numberWithInteger:item.WEEKNUM], [XYAUtils sqliteEscape:item.JT_NO], [XYAUtils sqliteEscape:item.S_Name], [XYAUtils sqliteEscape:item.Teach_Name], [XYAUtils sqliteEscape:item.RoomNum], item.WEEK];
        }
        [_db close];
    }
//    FMResultSet *resultSet = nil;
//    resultSet = [_db executeQuery:@"SELECT * FROM lesson where RoomNum = 'FF207';"];
//    NSMutableDictionary *dict = resultSet.columnNameToIndexMap;
//    NSLog(@"---%@---", dict);
//    while (resultSet.next) {
//
//        NSString *str0 = [resultSet stringForColumnIndex:0];
//        NSString *str1 = [resultSet stringForColumnIndex:1];
//        NSString *str2 = [resultSet stringForColumnIndex:2];
//        NSString *str3 = [resultSet stringForColumnIndex:3];
//        NSString *str4 = [resultSet stringForColumnIndex:4];
//        NSLog(@"%@,%@,%@,%@,%@",str0,str1,str2,str3,str4);
//
//    }
    return isSuccess;
}

- (BOOL)resetAllData {
    BOOL isSuccess = NO;
    
    if ([_db open]) {
        isSuccess = [_db executeUpdate:@"DELETE FROM lesson"];
        [_db close];
    }
    
    return isSuccess;
}

@end
