//
//  TDHttpEncoding.m
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/18.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDHttpEncoding.h"

@implementation TDHttpEncoding

+ (AFHTTPRequestSerializer *)getRequestBuildRequest:(id<TDHttpRequestType>)req
{
    
    if (req.reqEncoding == TDHttpRequestJsonEncoding) {
        AFJSONRequestSerializer *request = [AFJSONRequestSerializer serializer];
        request.timeoutInterval = req.timeout;
        return request;
    }
    else if (req.reqEncoding == TDHttpRequestUrlEncoding) {
        AFHTTPRequestSerializer *request = [AFHTTPRequestSerializer serializer];
        request.timeoutInterval = req.timeout;
        return request;
    }
    else {
        return nil;
    }
    
}

+ (AFHTTPResponseSerializer *)getResponseBuildRequest:(id<TDHttpRequestType>)req
{
    if (req.responseEncoding == TDHttpRequestJsonEncoding) {
        AFJSONResponseSerializer *request = [AFJSONResponseSerializer serializer];
        request.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
        return request;
    }
    else if (req.responseEncoding == TDHttpRequestUrlEncoding) {
        AFHTTPResponseSerializer *request = [AFHTTPResponseSerializer serializer];
        request.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/json", @"text/javascript", nil];
        return request;
    }
    else {
        return nil;
    }
}

@end
