//
//  TDHttpResponseHandler.m
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/18.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDHttpResponseHandler.h"

#define TD_HTTP_RESPONSE_MESSAGE @"message"
#define TD_HTTP_RESPONSE_STATIS  @"status"
#define TD_HTTP_RESPONSE_CODE    @"code"

@implementation TDHttpResponseHandler

- (void)parse:(id)data
{
    if ([data isKindOfClass:[NSData class]]) {
        NSError *error;
        id responseData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        if (error || ![responseData isKindOfClass:[NSDictionary class]]) {
            [self setFailureStatus];
        }
    }
    else if ([data isKindOfClass:[NSDictionary class]]) {
        [self parseDictionary:((NSDictionary *)data)];
    }
    else {
        [self setFailureStatus];
    }
}

- (void)handleResponse:(NSDictionary *)response
{
    [self parseDictionary:response];
}

- (void)parseDictionary:(NSDictionary *)dict
{
    _statusCode = [dict[TD_HTTP_RESPONSE_CODE] integerValue] == 200;
    _statusCode = [dict[TD_HTTP_RESPONSE_STATIS] integerValue] == 200;
    _message    = dict[TD_HTTP_RESPONSE_MESSAGE];
    _result     = dict;
}

- (void)setFailureStatus
{
    _statusCode = TDHttpStatusFailure;
    _message    = @"网络请求失败!";
    _result     = nil;
}

@end
