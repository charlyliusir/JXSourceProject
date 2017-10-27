//
//  TDLiveInfoResponse.m
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/20.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDLiveInfoResponse.h"
#import "TDHttpResponseHandler.h"

@implementation TDLiveInfoResponse

- (id)model
{
    return self.infoModel;
}

- (instancetype)initWithResult:(NSDictionary *)result
{
    if (self = [super init]) {
        TDHttpResponseHandler *handler = [[TDHttpResponseHandler alloc] init];
        [handler handleResponse:result];
        
        if (handler.statusCode == TDHttpStatusSuccess) {
            TDLiveInfoModel *model = [[TDLiveInfoModel alloc] init];
            [model setValuesForKeysWithDictionary:handler.result];
            self.infoModel = model;
        }
        else {
            self.infoModel = nil;
        }
    }
    
    return self;
}

- (instancetype)parseWithResult:(NSDictionary *)result
{
    return [self initWithResult:result];
}

@end
