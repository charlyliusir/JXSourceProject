//
//  TDActivityResponse.m
//  JXSourceFile
//
//  Created by 刘朝龙 on 2017/10/21.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDActivityResponse.h"
#import "TDHttpResponseHandler.h"

@implementation TDActivityResponse

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
            TDActivityInfoModel *model = [[TDActivityInfoModel alloc] init];
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
