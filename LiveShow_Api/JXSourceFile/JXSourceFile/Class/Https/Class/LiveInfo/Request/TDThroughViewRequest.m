//
//  TDThroughViewRequest.m
//  JXSourceFile
//
//  Created by 刘朝龙 on 2017/10/21.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDThroughViewRequest.h"

@implementation TDThroughViewRequest
@synthesize Response, host, path, method, responseEncoding, reqEncoding, timeout, parameters;

- (id<TDHttpResponseType>)Response
{
    return nil;
}

- (NSString *)host
{
    return TD_JX_BASEURL;
}

- (NSString *)path
{
    return TD_HTTP_REQUEST_THROUGH_VIEW;
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
             @"id":@(_sourceId),
             @"type":@(_type)
             };
}

- (instancetype)initWithSourceId:(NSUInteger)sourceId type:(NSUInteger)type
{
    if (self = [super init]) {
        _sourceId = sourceId;
        _type     = type;
    }
    return self;
}
+ (instancetype)throughViewWithSourceId:(NSUInteger)sourceId type:(NSUInteger)type
{
    return [[self alloc] initWithSourceId:sourceId type:type];
}
@end
