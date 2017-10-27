//
//  TDHttpManager.h
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/17.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <Reachability/Reachability.h>
#import "TDHttpResponseType.h"
#import "TDHttpRequestType.h"
#import "TDHttpResponseHandler.h"

/**
 网络请求成功回调

 @param statusCode 请求状态
 @param response 请求返回
 @param message 请求返回描述
 */
typedef void(^TDHttpOnSuccess) (TDHttpStatusCode statusCode, id<TDHttpResponseType> response, NSString * message, id json);

/**
 网络请求失败回调

 @param error 失败信息
 */
typedef void(^TDHttpOnFailure) (NSError * error);

@interface TDHttpManager : NSObject

/**
 网络请求管理单例

 @return Self
 */
+ (instancetype)manager;

// 发送网络请求
- (void)sendReq:(id<TDHttpRequestType>)request onSuccess:(TDHttpOnSuccess)success onFailure:(TDHttpOnFailure)failure;

// 上传网络请求

// 取消网络请求

@end
