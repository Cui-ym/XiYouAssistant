//
//  XYAEducationManager.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/24.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYAEducationResultModel.h"
#import "XYALessonTableDBManager.h"
#import "XYAHttpSessionManager.h"
#import "XYAURLSessionManager.h"
#import "XYAEducationManager.h"
#import "XYAEducationAPI.h"

@interface XYAEducationManager()

@property (nonatomic, strong) XYAEducationAPI *educationAPI;

@property (nonatomic, assign) BOOL lessonDBIsExist;

@end

@implementation XYAEducationManager

static XYAEducationManager *_kXYAEducationManagerInstance = nil;

+ (instancetype)educationManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _kXYAEducationManagerInstance = [[super alloc] init];
        [_kXYAEducationManagerInstance initializeXYALessonTableDataBase];
    });
    
    return _kXYAEducationManagerInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)initializeXYALessonTableDataBase {
    //    NSMutableArray *array = [NSMutableArray array];
    //    for (NSInteger i = 0; i < 20 ; i++) {
    //        [array addObject:@0];
    //    }
    //    if ([userDefault objectForKey:@"lessonDBIsExist"] == nil) {
    //        [array addObject:@0];
    //    }
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *isExist = [userDefault objectForKey:@"lessonDBIsExist"];
    BOOL result = [[XYALessonTableDBManager sharedManager] createLessonTable];
    if (isExist == nil || [isExist isEqualToString:@"NO"]) {
        if (result) {
            [userDefault setObject:@"YES" forKey:@"lessonDBIsExist"];
            _lessonDBIsExist = YES;
        } else {
            
            [userDefault setObject:@"NO" forKey:@"lessonDBIsExist"];
        }
        [userDefault synchronize];
    } else {
        _lessonDBIsExist = YES;
    }
}

- (void)fetchEducationVercodeFromNetSuccess:(nullable NSDataHandler)successBlock error:(nonnull XYAEducationErrorHandler)errorBlock {
    self.educationAPI = [XYAEducationAPI shareEducationAPI];
    [self.educationAPI getCookieAndVerCodeApi];
    XYAHttpSessionManager *manager = [XYAHttpSessionManager sharedManager];
    [manager doGet:_educationAPI.URL withParam:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSData *imageData = responseObject;
        successBlock(imageData);
        
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSDictionary *dictionary = response.allHeaderFields;
        NSRange range = [[dictionary objectForKey:@"Set-Cookie"] rangeOfString:@";"];
        NSString *cookie = [[dictionary objectForKey:@"Set-Cookie"] substringWithRange:NSMakeRange(0, range.location)];
        if ([dictionary objectForKey:@"Set-Cookie"] != NULL) {
            self.educationAPI = [XYAEducationAPI shareEducationAPI];
            self.educationAPI.cookie = cookie;
            NSLog(@"%@", cookie);
        }
        
    } error:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
    }];
}

- (void)fetchEducationLoginWithUsername:(NSString *)username password:(NSString *)password vercode:(NSString *)vercode success:(nullable XYAEducationResultHandler)successBlock error:(nonnull XYAEducationErrorHandler)errorBlock {
    self.educationAPI = [XYAEducationAPI shareEducationAPI];
    [self.educationAPI GetLoginApiWithUserName:username password:password vercode:vercode];
    NSDictionary *header = @{@"Cookie" : _educationAPI.cookie};
    XYAURLSessionManager *manager = [XYAURLSessionManager sharedManager];
    [manager doPost:_educationAPI.URL withParam:_educationAPI.param withHeader:header success:^(XYAEducationResultModel * _Nullable resultModel) {
        successBlock(resultModel);
    } error:^(NSError * _Nonnull error) {
        errorBlock(error);
    }];
    
}

- (void)fetchEducationResultWithEducationAPI:(XYAEducationAPI *_Nonnull)educationAPI success:(XYAEducationResultHandler)successBlock error:(XYAEducationErrorHandler)errorBlock {
    
    NSMutableDictionary *header = [NSMutableDictionary dictionary];
    if (educationAPI.cookie != nil) {
        [header setValue:educationAPI.cookie forKey:@"Cookie"];
    }
    
    XYAHttpSessionManager *manager = [XYAHttpSessionManager sharedManager];
    [manager doPost:educationAPI.URL withParam:educationAPI.param withHeader:nil progress:^(NSProgress * _Nullable progress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = nil;
//        NSLog(@"%@", responseObject);
        XYAEducationResultModel *model = [[XYAEducationResultModel alloc] initWithData:responseObject error:&error];
        if (model.IsSucceed == 1) {
            successBlock(model);
        }
    } error:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
    }];
   
}

- (void)fetchEducationClassTableWithTermNumber:(NSString *)term week:(NSInteger)week success:(nullable XYAEducationClassTableHandler)successBlock error:(nonnull XYAEducationErrorHandler)errorBlock {
    self.educationAPI = [XYAEducationAPI shareEducationAPI];
    [self.educationAPI getLessionWithWeek:[NSNumber numberWithInteger:5] term:term];
    XYAHttpSessionManager *manager = [XYAHttpSessionManager sharedManager];
    NSDictionary *header = @{@"Cookie" : _educationAPI.cookie};
    [manager doPost:_educationAPI.URL withParam:_educationAPI.param withHeader:header progress:^(NSProgress * _Nullable progress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@", [[NSString alloc] initWithData:responseObject encoding:kCFStringEncodingUTF8]);
        NSError *error = nil;
        XYAEducationClassTableModel *model = [[XYAEducationClassTableModel alloc] initWithData:responseObject error:&error];
        model = [model lessonArraySort];
        for (XYAEducationClassTableItemModel *obj in model.Obj) {
            obj.WEEK = [NSString stringWithFormat:@"%ld", week];
        }
        NSLog(@"%@", model);
        if (model.IsSucceed == true) {
            if (_lessonDBIsExist == YES) {
                if (week == 1) {        // 第一周清空数据库 全部重新添加
                    [[XYALessonTableDBManager sharedManager] resetAllData];
                }
                [[XYALessonTableDBManager sharedManager] insertLessonTableModels:model];
            }
            successBlock(model);
        } else {
            if (_lessonDBIsExist == YES) {
                successBlock([[XYALessonTableDBManager sharedManager] getLessonModelWithWeek:week]);
            } else {
                NSError *error = [[NSError alloc] initWithDomain:model.Msg code:(NSInteger)model.IsSucceed userInfo:nil];
                errorBlock(error);
            }
        }
        
    } error:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (_lessonDBIsExist == YES) {
            successBlock([[XYALessonTableDBManager sharedManager] getLessonModelWithWeek:week]);
        } else {
            errorBlock(error);
        }
    }];
}


@end

