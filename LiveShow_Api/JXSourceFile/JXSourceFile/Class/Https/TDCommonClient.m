//
//  TDCommonClient.m
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/17.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDCommonClient.h"
#import "TDHttpManager.h"

@interface TDCommonClient ()
// 网络请求管理器
@property (nonatomic, strong) TDHttpManager *manager;

@end

@implementation TDCommonClient

- (instancetype)init
{
    if(self = [super init])
    {
        // 初始化请求管理器
        _manager = [TDHttpManager manager];
    }
    return self;
}

- (void)sendReq:(id<TDHttpRequestType>)request onSuccess:(TDHttpOnSuccess)success onFailure:(TDHttpOnFailure)failure
{
    [_manager sendReq:request onSuccess:success onFailure:failure];
}

@end
