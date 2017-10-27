//
//  TDHttpManager.m
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/17.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDHttpManager.h"
#import "TDHttpEncoding.h"

@interface TDHttpManager ()
@property (nonatomic, strong) NSMutableDictionary * requestData;
@end

@implementation TDHttpManager

- (NSMutableDictionary *)requestData
{
    if (!_requestData) {
        _requestData = [NSMutableDictionary dictionary];
    }
    
    return _requestData;
}

+ (instancetype)manager
{
    static TDHttpManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[TDHttpManager alloc] init];
    });
    return manager;
}

// 发送网络请求
- (void)sendReq:(id<TDHttpRequestType>)request onSuccess:(TDHttpOnSuccess)success onFailure:(TDHttpOnFailure)failure
{
    NSString *requestUrl = [request.host stringByAppendingPathComponent:request.path];
    
    NSLog(@"request url: %@", requestUrl);
    NSAssert([NSURL URLWithString:requestUrl], @"请求网址不存在!");
    NSLog(@"para: %@", request.parameters);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer     = [TDHttpEncoding getRequestBuildRequest:request];
    manager.responseSerializer    = [TDHttpEncoding getResponseBuildRequest:request];
    
    if (request.method == TDHttpMethodGet) {
        [self GET:requestUrl req:request parameters:request.parameters withManager:manager onSuccess:success onFailure:failure];
    }
    else if (request.method == TDHttpMethodPost) {
        [self POST:requestUrl req:request parameters:request.parameters withManager:manager onSuccess:success onFailure:failure];
    }
}

- (void)GET:(NSString *)url req:(id<TDHttpRequestType>)request parameters:(id)parameters withManager:(AFHTTPSessionManager *)manager onSuccess:(TDHttpOnSuccess)success onFailure:(TDHttpOnFailure)failure
{
    NSURLSessionDataTask *task = [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.requestData removeObjectForKey:url];
        [self parseResponseHandlerWithData:responseObject req:request onSuccess:success];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.requestData removeObjectForKey:url];
        NSLog(@"request error : %@", error.localizedDescription);
        failure(error);
    }];
    
    [self.requestData setValue:task forKey:url];
}

- (void)POST:(NSString *)url req:(id<TDHttpRequestType>)request parameters:(id)parameters withManager:(AFHTTPSessionManager *)manager onSuccess:(TDHttpOnSuccess)success onFailure:(TDHttpOnFailure)failure
{
    NSURLSessionDataTask *task = [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.requestData removeObjectForKey:url];
        [self parseResponseHandlerWithData:responseObject req:request onSuccess:success];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.requestData removeObjectForKey:url];
        failure(error);
    }];
    
    [self.requestData setValue:task forKey:url];
    
}

- (void)parseResponseHandlerWithData:(id)responseObject req:(id<TDHttpRequestType>)request onSuccess:(TDHttpOnSuccess)success
{
    TDHttpResponseHandler *handler = [[TDHttpResponseHandler alloc] init];
    [handler parse:responseObject];
    NSLog(@"statuse--%lu--message--%@--result--%@", (unsigned long)handler.statusCode, handler.message, handler.result);
    if (handler.statusCode == TDHttpStatusSuccess) {
        NSLog(@"response: %@", request.Response);
        success(handler.statusCode,  [request.Response parseWithResult:handler.result], handler.message, handler.result);
    }
    else {
        success(handler.statusCode, nil, handler.message, handler.result);
    }
    
}

@end
