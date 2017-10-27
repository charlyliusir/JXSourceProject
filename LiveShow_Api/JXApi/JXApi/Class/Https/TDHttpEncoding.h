//
//  TDHttpEncoding.h
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/18.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "TDHttpRequestType.h"

@interface TDHttpEncoding : NSObject

+ (AFHTTPRequestSerializer *)getRequestBuildRequest:(id<TDHttpRequestType>)req;
+ (AFHTTPResponseSerializer *)getResponseBuildRequest:(id<TDHttpRequestType>)req;

@end
