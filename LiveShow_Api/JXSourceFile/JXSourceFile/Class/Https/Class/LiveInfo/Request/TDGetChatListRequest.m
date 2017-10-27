//
//  TDGetChatListRequest.m
//  JXSourceFile
//
//  Created by 刘朝龙 on 2017/10/21.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDGetChatListRequest.h"
#import "TDGetChatListResponse.h"

@implementation TDGetChatListRequest

@synthesize Response, host, path, method, responseEncoding, reqEncoding, timeout, parameters;

- (id<TDHttpResponseType>)Response
{
    return [[TDGetChatListResponse alloc] init];
}

- (NSString *)host
{
    return TD_JX_BASEURL;
}

- (NSString *)path
{
    return TD_HTTP_REQUEST_LIST_MESSAGE;
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
    NSMutableDictionary *param = @{
                                   @"id":@(_sourceId),
                                   @"list_type":@(_sourceType)
                                   }.mutableCopy;
    if (_minId) {
        [param setValue:_minId forKey:@"min_id"];
    }
    if (_lastId) {
        [param setValue:_lastId forKey:@"last_id"];
    }
    return param.copy;
}

- (instancetype)initWithSourceId:(NSUInteger)sourceId withSourceType:(NSUInteger)sourceType
                   getNewMessage:(NSNumber *)lastId
              getNextPageMessage:(NSNumber *)minId
{
    if (self = [super init]) {
        _sourceId   = sourceId;
        _sourceType = sourceType;
        _lastId = lastId;
        _minId  = minId;
    }
    return self;
}
+ (instancetype)chatListWithSourceId:(NSUInteger)sourceId withSourceType:(NSUInteger)sourceType
                       getNewMessage:(NSNumber *)lastId
{
    return [[self alloc] initWithSourceId:sourceId withSourceType:sourceType getNewMessage:lastId getNextPageMessage:nil];
}
+ (instancetype)chatListWithSourceId:(NSUInteger)sourceId withSourceType:(NSUInteger)sourceType
                  getNextPageMessage:(NSNumber *)minId
{
    return [[self alloc] initWithSourceId:sourceId withSourceType:sourceType getNewMessage:nil getNextPageMessage:minId];
}

@end
