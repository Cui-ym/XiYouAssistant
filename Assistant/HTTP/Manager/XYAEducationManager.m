//
//  XYAEducationManager.m
//  Assistant
//
//  Created by 崔一鸣 on 2018/7/24.
//  Copyright © 2018年 崔一鸣. All rights reserved.
//

#import "XYAEducationManager.h"
#import "XYAHttpSessionManager.h"
#import "XYAURLSessionManager.h"
#import "XYAEducationAPI.h"

@interface XYAEducationManager()

@property (nonatomic, strong) XYAEducationAPI *educationAPI;

@end

@implementation XYAEducationManager

- (void)fetchEducationResultWithParam:(NSDictionary *)param success:(XYAEducationResultHandler)successBlock error:(XYAEducationErrorHandler)errorBlock {
    self.educationAPI = [XYAEducationAPI shareEducationAPI];
    
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

- (void)fetchEducationClassTableWithTermNumber:(NSInteger)term week:(NSInteger)week success:(nullable XYAEducationClassTableHandler)successBlock error:(nonnull XYAEducationErrorHandler)errorBlock {
    self.educationAPI = [XYAEducationAPI shareEducationAPI];
    [self.educationAPI getLessionWithWeek:[NSNumber numberWithInteger:week] term:[NSNumber numberWithInteger:term]];
    XYAHttpSessionManager *manager = [XYAHttpSessionManager sharedManager];
    NSDictionary *header = @{@"Cookie" : _educationAPI.cookie};
    [manager doPost:_educationAPI.URL withParam:_educationAPI.param withHeader:header success:^(XYAEducationResultModel * _Nullable resultModel) {
        NSLog(@"%@", resultModel);
    } error:^(NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}


@end

