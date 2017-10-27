//
//  TDSendMessageRequest.m
//  JXSourceFile
//
//  Created by 刘朝龙 on 2017/10/21.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDSendMessageRequest.h"

@implementation TDSendMessageRequest
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
    return TD_HTTP_REQUEST_SEND_MESSAGE;
}

- (TDHttpMethod)method
{
    return TDHttpMethodPost;
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
    NSMutableDictionary *param = @{
                                   @"id":@(_sourceId),
                                   @"send_type":@(_send_type),
                                   @"message":_message
                                   }.mutableCopy;
    if (_parent) {
        [param setValue:_parent forKey:@"parent"];
    }
    
    return param.copy;
    
}

- (instancetype)initWithSourceId:(NSUInteger)sourceId sendType:(NSUInteger)sendType message:(NSString *)message parent:(NSNumber *)parent
{
    if (self = [super init]) {
        _sourceId = sourceId;
        _send_type = sendType;
        _message   = message;
        _parent    = parent;
    }
    return self;
}

+ (instancetype)sendMessageWithSourceId:(NSUInteger)sourceId sendType:(NSUInteger)sendType message:(NSString *)message parent:(NSNumber *)parent
{
    return [[self alloc] initWithSourceId:sourceId sendType:sendType message:message parent:parent];
}

@end
