//
//  XYAURLSessionManager.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/25.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYAURLSessionManager.h"
#import "AFNetworking.h"

@interface XYAURLSessionManager ()

@property (nonatomic, strong) AFURLSessionManager *manager;
@property (nonatomic, strong) NSMutableURLRequest *request;

@end

@implementation XYAURLSessionManager

static XYAURLSessionManager *_kXYAURLSessionManager = nil;

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _kXYAURLSessionManager = [[super alloc] init];
        _kXYAURLSessionManager.manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        
    });
    return _kXYAURLSessionManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (void)doPost:(NSString *_Nonnull)url
     withParam:(NSDictionary *_Nullable)param
    withHeader:(NSDictionary *_Nullable)header
       success:(XYAEducationHandle _Nullable )successBlock
         error:(ErrorHandle _Nonnull)errorBlock {
    NSString *cookie = [param objectForKey:@"Cookie"];
    
    _kXYAURLSessionManager.request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:param error:nil];
    [_kXYAURLSessionManager.request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [_kXYAURLSessionManager.request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [_kXYAURLSessionManager.request setValue:cookie forHTTPHeaderField:@"Cookie"];
    
    NSURLSessionDataTask *task = [_kXYAURLSessionManager.manager dataTaskWithRequest:_kXYAURLSessionManager.request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            // 请求成功数据处理
            NSError *error;
            XYAEducationResultModel *result = [[XYAEducationResultModel alloc] initWithDictionary:responseObject error:&error];
//            NSLog(@"%@  %@", responseObject, result);
            if (result.IsSucceed == 1) {
                successBlock(result);
            } else {
                NSError *error = [[NSError alloc] initWithDomain:result.Msg code:(NSInteger)result.IsSucceed userInfo:nil];
                errorBlock(error);
            }
        } else {
            errorBlock(error);
        }
        
    }];
    
    [task resume];
}

@end
