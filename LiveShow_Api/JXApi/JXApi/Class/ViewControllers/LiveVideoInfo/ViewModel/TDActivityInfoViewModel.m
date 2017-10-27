//
//  TDActivityInfoViewModel.m
//  JXSourceFile
//
//  Created by 刘朝龙 on 2017/10/21.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDActivityInfoViewModel.h"
#import "TDActivityInfoRequest.h"

@implementation TDActivityInfoViewModel

- (instancetype)initWithModel:(TDActivityInfoModel *)model
{
    if (self = [super init]) {
        _model = model;
    }
    return self;
}

+ (instancetype)liveInfoWithModel:(TDActivityInfoModel *)model
{
    return [[self alloc] initWithModel:model];
}

- (void)getActivityInfo:(TD_Request_Handler)handler withSourceId:(NSUInteger)sourceId
{
    TDActivityInfoRequest *req = [TDActivityInfoRequest activityInfoWithSourceId:sourceId];
    
    [[[TDCommonClient alloc] init] sendReq:req onSuccess:^(TDHttpStatusCode statusCode, id<TDHttpResponseType> response, NSString *message, id json) {
        if (statusCode == TDHttpStatusSuccess && response.model) {
            if ([response.model isKindOfClass:[TDActivityInfoModel class]]) {
                _model = response.model;
                handler(YES, @"");
            }
            else {
                handler(NO, message);
            }
        }
    } onFailure:^(NSError *error) {
        handler(NO, TDLocalizedStringWithComment(@"td_http_net_error", @"网络请求失败!"));
    }];
}

@end
