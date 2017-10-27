//
//  TDHttpResponseType.h
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/18.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TDHttpResponseType <NSObject>

@optional
@property (nonatomic, assign) id model;
/**
 解析网络请求数据

 @param result 网络请求响应数据
 */
- (instancetype)parseWithResult:(NSDictionary *)result;

@end
