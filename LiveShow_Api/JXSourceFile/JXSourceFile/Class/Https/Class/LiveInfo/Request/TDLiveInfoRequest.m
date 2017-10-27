//
//  TDLiveInfoRequest.m
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/20.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDLiveInfoRequest.h"
#import "TDLiveInfoResponse.h"

@implementation TDLiveInfoRequest
@synthesize Response, host, path, method, responseEncoding, reqEncoding, timeout, parameters;

- (id<TDHttpResponseType>)Response
{
    return [[TDLiveInfoResponse alloc] init];
}

- (NSString *)host
{
    return TD_JX_BASEURL;
}

- (NSString *)path
{
    return TD_HTTP_REQUEST_LIVE_INFO;
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

+ (instancetype)liveInfoWithSourceId:(NSUInteger)sourceId
{
    return [[self alloc] initWithSourceId:sourceId];
}

@end
