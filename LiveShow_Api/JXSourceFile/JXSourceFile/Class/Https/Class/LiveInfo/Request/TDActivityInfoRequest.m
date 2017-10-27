//
//  TDActivityInfoRequest.m
//  JXSourceFile
//
//  Created by 刘朝龙 on 2017/10/21.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDActivityInfoRequest.h"
#import "TDActivityResponse.h"

@implementation TDActivityInfoRequest
@synthesize Response, host, path, method, responseEncoding, reqEncoding, timeout, parameters;

- (id<TDHttpResponseType>)Response
{
    return [[TDActivityResponse alloc] init];
}

- (NSString *)host
{
    return TD_JX_BASEURL;
}

- (NSString *)path
{
    return TD_HTTP_REQUEST_INFO;
}

- (TDHttpMethod)method
{
    return TDHttpMethodGet;
}

- (TDHttpRequestEncoding)reqEncoding
{
    return TDHttpRequestUrlEncoding;
}

- (TDHttpResponseEncoding)responseEncoding
{
    return TDHttpResponseJsonEncoding;
}

- (NSTimeInterval)timeout
{
    return 15.0;
}

- (NSDictionary *)parameters
{
    /// 拼接参数
    return @{
             @"id":@(_sourceId)
             };
}

- (instancetype)initWithSourceId:(NSUInteger)sourceId
{
    if (self = [super init]) {
        _sourceId = sourceId;
    }
    return self;
}

+ (instancetype)activityInfoWithSourceId:(NSUInteger)sourceId
{
    return [[self alloc] initWithSourceId:sourceId];
}
@end
