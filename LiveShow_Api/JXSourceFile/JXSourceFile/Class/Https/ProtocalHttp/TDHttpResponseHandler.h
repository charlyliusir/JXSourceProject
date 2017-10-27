//
//  TDHttpResponseHandler.h
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/18.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, TDHttpStatusCode) {
    TDHttpStatusFailure = 0,
    TDHttpStatusSuccess,
};

#define TD_HTTP_RESPONSE_RESULT  @"result"

@interface TDHttpResponseHandler : NSObject

@property (nonatomic, readonly, assign) TDHttpStatusCode statusCode;
@property (nonatomic, readonly, copy)   NSString * message;
@property (nonatomic, readonly, copy)   NSDictionary * result;

- (void)parse:(id)data;
- (void)handleResponse:(NSDictionary *)response;

@end
