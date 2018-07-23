//
//  XYAHttpSessionManager.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/23.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYAHttpSessionManager.h"
#import "XYAEducationAPI.h"

@interface XYAHttpSessionManager ()

@property (nonatomic, strong) XYAEducationAPI *educationApi;

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@property (nonatomic, strong) AFJSONResponseSerializer *jsonResponseSerializer;

@property (nonatomic, strong) AFHTTPResponseSerializer *httpResponseSerializer;

@property (nonatomic, strong) AFHTTPRequestSerializer *requestSerializer;

@end

@implementation XYAHttpSessionManager

+ (instancetype)sharedManager {
    static XYAHttpSessionManager *kXYAHttpSessionManagerInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        kXYAHttpSessionManagerInstance = [[self alloc] init];
    });
    return kXYAHttpSessionManagerInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        self.educationApi = [[XYAEducationAPI alloc] init];
        self.manager = [AFHTTPSessionManager manager];
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _manager.requestSerializer = _requestSerializer;
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/javascript",@"text/html",@"text/plain",@"application/json",@"text/plain", nil];
    }
    return self;
}

- (AFJSONResponseSerializer *)jsonResponseSerializer {
    if (!_jsonResponseSerializer) {
        _jsonResponseSerializer = [AFJSONResponseSerializer serializer];
        _jsonResponseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"text/javascript",@"application/json",@"text/html",nil];
    }
    return _jsonResponseSerializer;
}

- (AFHTTPResponseSerializer *)httpResponseSerializer {
    if (!_httpResponseSerializer) {
        _httpResponseSerializer = [AFHTTPResponseSerializer serializer];
        _httpResponseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"text/javascript",@"text/html",@"text/plain",@"application/json", nil];
    }
    return _httpResponseSerializer;
}

- (void)doGet:(NSString *_Nonnull)url
    withParam:(NSDictionary *_Nullable)param
   withHeader:(NSDictionary *_Nullable)header
      success:(void (^_Nullable)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject))successBlock
        error:(void (^_Nullable)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))errorBlock {
    [self.manager GET:url parameters:param progress:nil success:successBlock failure:errorBlock];
}

- (void)doPost:(NSString *)url
     withParam:(NSDictionary *)param
    withHeader:(NSDictionary *)header
       success:(XYAEducationHandle)successBlock
         error:(ErrorHandle)errorBlock {
    NSArray *keys = [header allKeys];
    for (int i = 0; i < keys.count; i++) {
        [_manager.requestSerializer setValue:header[keys[i]] forHTTPHeaderField:keys[i]];
    }
    
    [self.manager POST:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error;
        XYAEducationResultModel *result = [[XYAEducationResultModel alloc] initWithDictionary:responseObject error:&error];
        if (result.IsSucceed == 1) {
            successBlock(result);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:result.Msg code:(NSInteger)result.IsSucceed userInfo:nil];
            errorBlock(error);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        errorBlock(error);
    }];
    
}
@end
