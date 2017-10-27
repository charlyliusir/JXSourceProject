//
//  TDHttpRequestType.h
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/17.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "TDHttpCommonHeader.h"
#import "TDHttpResponseType.h"

/**
 网络请求方式
 
 - TDHttpMethodGet: Get 请求
 - TDHttpMethodPost: Post 请求
 - TDHttpMethodOptions: Options 请求
 - TDHttpMethodHead: Head 请求
 - TDHttpMethodPut: Put 请求
 - TDHttpMethodPatch: Patch 请求
 - TDHttpMethodDelete: Delete 请求
 - TDHttpMethodTrace: Trace 请求
 - TDHttpMethodConnect: Connect 请求
 */
typedef NS_ENUM(NSUInteger, TDHttpMethod) {
    TDHttpMethodGet,
    TDHttpMethodPost,
    TDHttpMethodOptions,
    TDHttpMethodHead,
    TDHttpMethodPut,
    TDHttpMethodPatch,
    TDHttpMethodDelete,
    TDHttpMethodTrace,
    TDHttpMethodConnect
};

/**
 网络请求编码格式

 - TDHttpRequestUrlEncoding: http 编码
 - TDHttpRequestJsonEncoding: json 编码
 */
typedef NS_ENUM(NSUInteger, TDHttpRequestEncoding) {
    TDHttpRequestUrlEncoding,
    TDHttpRequestJsonEncoding
};

/**
 网络请求编码格式
 
 - TDHttpRequestUrlEncoding: http 编码
 - TDHttpRequestJsonEncoding: json 编码
 */
typedef NS_ENUM(NSUInteger, TDHttpResponseEncoding) {
    TDHttpResponseUrlEncoding,
    TDHttpResponseJsonEncoding
};

@protocol TDHttpRequestType <NSObject>

// host
@property (nonatomic, copy) NSString *host;
// 编码格式
@property (nonatomic, assign) TDHttpRequestEncoding reqEncoding;
// 编码格式
@property (nonatomic, assign) TDHttpResponseEncoding responseEncoding;
// 超时请求
@property (nonatomic, assign) NSTimeInterval timeout;

@optional
// 请求方法
@property (nonatomic, assign) TDHttpMethod method;
// 解析
@property (nonatomic, weak) id <TDHttpResponseType> Response;
// url
@property (nonatomic, copy) NSString *path;
// 参数
@property (nonatomic, strong) NSDictionary *parameters;


@end
