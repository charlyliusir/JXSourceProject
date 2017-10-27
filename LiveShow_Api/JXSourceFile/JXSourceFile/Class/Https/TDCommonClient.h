//
//  TDCommonClient.h
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/17.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDHttpManager.h"

@interface TDCommonClient : NSObject

- (void)sendReq:(id<TDHttpRequestType>)request onSuccess:(TDHttpOnSuccess)success onFailure:(TDHttpOnFailure)failure;

@end
