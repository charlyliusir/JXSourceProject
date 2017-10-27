//
//  TDLiveInfoModeView.m
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/20.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDLiveInfoViewModel.h"
#import "TDLiveInfoRequest.h"

@implementation TDLiveInfoViewModel

- (instancetype)initWithModel:(TDLiveInfoModel *)model
{
    if (self = [super init]) {
        _model = model;
    }
    return self;
}

+ (instancetype)liveInfoWithModel:(TDLiveInfoModel *)model
{
    return [[self alloc] initWithModel:model];
}

- (void)getLiveInfo:(TD_Request_Handler)handler withSourceId:(NSUInteger)sourceId
{
    TDLiveInfoRequest *req = [TDLiveInfoRequest liveInfoWithSourceId:sourceId];
    
    [[[TDCommonClient alloc] init] sendReq:req onSuccess:^(TDHttpStatusCode statusCode, id<TDHttpResponseType> response, NSString *message, id json) {
        if (statusCode == TDHttpStatusSuccess && response.model) {
            if ([response.model isKindOfClass:[TDLiveInfoModel class]]) {
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
