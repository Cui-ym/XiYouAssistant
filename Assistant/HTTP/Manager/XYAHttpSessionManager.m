//
//  XYAHttpSessionManager.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/23.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYAHttpSessionManager.h"
#import "AFNetworking.h"

@interface XYAHttpSessionManager ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation XYAHttpSessionManager

static XYAHttpSessionManager *_kXYAHttpSessionManagerInstance = nil;

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _kXYAHttpSessionManagerInstance = [[super alloc] init];
        _kXYAHttpSessionManagerInstance.manager = [AFHTTPSessionManager manager];
        
        _kXYAHttpSessionManagerInstance.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
        _kXYAHttpSessionManagerInstance.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _kXYAHttpSessionManagerInstance.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    });
    return _kXYAHttpSessionManagerInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - HTTP

- (void)doGet:(NSString *_Nonnull)url
    withParam:(NSDictionary *_Nullable)param
     progress:(void (^_Nullable)(NSProgress * _Nonnull ))downloadProgress
      success:(void (^_Nullable)(NSURLSessionDataTask * _Nonnull task, id  _Nullable ))successBlock
        error:(void (^_Nullable)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull ))errorBlock {
    [_kXYAHttpSessionManagerInstance.manager GET:url parameters:param progress:nil success:successBlock failure:errorBlock];
}

- (void)doPost:(NSString *)url
     withParam:(NSDictionary *)param
    withHeader:(NSDictionary *)header
      progress:(void (^_Nullable)(NSProgress *_Nullable progress))progress
       success:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull, id _Nullable))successBlock
         error:(void (^ _Nullable)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))errorBlock {
    NSArray *keys = [header allKeys];
    for (int i = 0; i < keys.count; i++) {
        [_manager.requestSerializer setValue:header[keys[i]] forHTTPHeaderField:keys[i]];
    }
    
    [_manager POST:url parameters:param progress:progress success:successBlock failure:errorBlock];
    
}
@end
