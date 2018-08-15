//
//  XYAComputerManager.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/8/3.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYAComputerManager.h"
#import "XYAHttpSessionManager.h"
#import "XYAComputerAPI.h"

@interface XYAComputerManager ()

@property (nonatomic, strong) XYAComputerAPI *computerAPI;

@end

@implementation XYAComputerManager

static XYAComputerManager *_kXYAComputerManagerInstance = nil;

+ (instancetype)shareComputerManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _kXYAComputerManagerInstance = [[super alloc] init];
        
    });
    
    return _kXYAComputerManagerInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)fetchComputerTimeFromNetSuccess:(nullable XYAComputerTimeHandler)successBlock error:(nonnull XYAComputerErrorHandler)errorBlock {
    self.computerAPI = [XYAComputerAPI shareComputerAPI];
    [self.computerAPI getComputerTimeAPI];
    XYAHttpSessionManager *manager = [XYAHttpSessionManager sharedManager];
    [manager doGet:_computerAPI.URL withParam:_computerAPI.param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = nil;
        XYAComputerResultModel *model = [[XYAComputerResultModel alloc] initWithData:responseObject error:&error];
        if (model.status == 1) {
            successBlock(model);
        }
    } error:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
    }];
}

- (void)fetchComputerVercodeFromNetSuccess:(nullable NSDataHandler)successBlock error:(nonnull XYAComputerErrorHandler)errorBlock {
    self.computerAPI = [XYAComputerAPI shareComputerAPI];
    [self.computerAPI getComputerVercodeAPI];
    XYAHttpSessionManager *manager = [XYAHttpSessionManager sharedManager];
    [manager doGet:_computerAPI.URL withParam:_computerAPI.param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSData *imageData = responseObject;
        successBlock(imageData);
        
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSDictionary *dictionary = response.allHeaderFields;
        NSRange range = [[dictionary objectForKey:@"Set-Cookie"] rangeOfString:@";"];
        NSString *cookie = [[dictionary objectForKey:@"Set-Cookie"] substringWithRange:NSMakeRange(0, range.location)];
        if ([dictionary objectForKey:@"Set-Cookie"] != NULL) {
            self.computerAPI = [XYAComputerAPI shareComputerAPI];
            self.computerAPI.cookie = cookie;
        }
        
    } error:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
    }];
}

- (void)fetchComputerResultModelWithTime:(NSString * _Nonnull)time type:(NSInteger)type zjh:(NSString * _Nonnull)zjh name:(NSString * _Nonnull)name vercode:(NSString * _Nonnull)vercode success:(nullable XYAComputerResultHandler)successBlock error:(nonnull XYAComputerErrorHandler)errorBlock {
    self.computerAPI = [XYAComputerAPI shareComputerAPI];
    [self.computerAPI getComputerResultAPIWithTime:time type:type zjh:zjh name:name vercode:vercode];
    XYAHttpSessionManager *manager = [XYAHttpSessionManager sharedManager];
    NSDictionary *header = @{@"Cookie" : _computerAPI.cookie};
    [manager doPost:_computerAPI.URL withParam:_computerAPI.param withHeader:header progress:^(NSProgress * _Nullable progress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = nil;
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        XYAComputerModel *model = [[XYAComputerModel alloc] initWithDictionary:content error:&error];
        NSLog(@"%@", responseObject);
        if (model.status == 1) {
            successBlock(model);
        }
    } error:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error : %@", error);
        errorBlock(error);
    }];
}


@end
