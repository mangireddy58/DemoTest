//
//  ClassForServerComm.m
//  Prasyst
//
//  Created by Sai on 15/07/17.
//  Copyright © 2017 Simplicity. All rights reserved.
//

#import "ClassForServerComm.h"
#import "AFHTTPSessionManager.h"

@implementation ClassForServerComm

- (void)sendHttpGetRequestWithParam:(NSString *)parametersString andServiceName:(NSString *)serviceName {
    
    NSString *serviceUrl = [NSString stringWithFormat:@"%@%@", BASE_URL, serviceName];
    NSData* data = [parametersString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *parametersDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:serviceUrl parameters:parametersDictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.delegate) {
            [self.delegate onServiceSuccess:(NSDictionary *)responseObject];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.delegate) {
            [self.delegate onServiceFailed];
        }
    }];
}

- (void)sendHttpPostRequestWithParam:(NSString *)parametersString andServiceName:(NSString *)serviceName {
    NSString *serviceUrl = [NSString stringWithFormat:@"%@%@", BASE_URL,serviceName];
    NSString *paramString = [NSString stringWithFormat:SERVICE_PARAMS, parametersString, DB_NAME];
    NSData* data = [paramString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *parametersDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSString *postLength = [NSString stringWithFormat:@"%ld", (unsigned long)[data length]];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [manager.requestSerializer setTimeoutInterval:SERVICE_TIMEOUT];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@" Content-Type"];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:serviceUrl parameters:parametersDictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.delegate) {
            [self.delegate onServiceSuccess:responseObject];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.delegate) {
            [self.delegate onServiceFailed];
        }
    }];
}

- (void)sendHttpRequestWithParam:(NSString *)parametersString andServiceName:(NSString *)serviceName {
    NSString *serviceUrl = [NSString stringWithFormat:@"%@%@", BASE_URL, serviceName];
    NSString *paramString = [NSString stringWithFormat:SERVICE_PARAMS, parametersString, DB_NAME];
    NSData *data = [paramString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *parametersDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSString *postLength = [NSString stringWithFormat:@"%ld", (unsigned long)[data length]];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [manager.requestSerializer setTimeoutInterval:SERVICE_TIMEOUT];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:serviceUrl parameters:parametersDictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"Success:%@", str);
        if (self.delegate) {
            [self.delegate onWebViewServiceSuccess:str];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Failure:%@", error);
        if (self.delegate) {
            [self.delegate onServiceFailed];
        }
    }];
}
@end
