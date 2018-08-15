//
//  XYAEnglishManager.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/8/8.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYAEnglishManager.h"
#import "XYAHttpSessionManager.h"
#import "XYAEnglishAPI.h"

@interface XYAEnglishManager ()

@property (nonatomic, strong) XYAEnglishAPI *englishAPI;

@end

@implementation XYAEnglishManager

static XYAEnglishManager *_kXYAEnglishManager = nil;

+ (instancetype)shareEnglishManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _kXYAEnglishManager = [[XYAEnglishManager alloc] init];
    });
    return _kXYAEnglishManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)fetchEnglishVercodeWithUrl:(NSString *_Nonnull)url Success:(NSDataHandler)successBlock error:(XYAEnglishErrorHandler)errorBlock {
    XYAHttpSessionManager *manager = [XYAHttpSessionManager sharedManager];
    [manager doGet:url withParam:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSData *imageData = responseObject;
        successBlock(imageData);
    } error:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
    }];
    
}

- (void)fetchEnglishResultModelWithUsername:(NSString *)name number:(NSString *)number vercode:(NSString *)vercode success:(XYAEnglishResultHandler)successBlock error:(XYAEnglishErrorHandler)errorBlock {
    self.englishAPI = [XYAEnglishAPI shareEnglishAPI];
    [self.englishAPI getEnglishTestAPIWithNumber:number name:name vercode:vercode];
    XYAHttpSessionManager *manager = [XYAHttpSessionManager sharedManager];
    [manager doPost:self.englishAPI.URL withParam:_englishAPI.param withHeader:nil progress:^(NSProgress * _Nullable progress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = nil;
        XYACETModel *model = [[XYACETModel alloc] initWithData:responseObject error:&error];
        successBlock(model);
    } error:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

@end
