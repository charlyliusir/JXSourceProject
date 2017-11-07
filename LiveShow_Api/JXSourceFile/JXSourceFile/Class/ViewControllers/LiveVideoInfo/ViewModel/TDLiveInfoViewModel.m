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
        handler(NO, @"网络请求失败!");
    }];
}

/**
 在线人数

 @return 在线人数
 */
- (NSString *)onLinePeople
{
    if (_model && _model.online) {
        return [NSString stringWithFormat:@"%@", _model.online];
    }
    else {
        return @"0";
    }
}

/**
 直播状态

 @return 直播状态
 */
- (BOOL)living
{
    if (_model && _model.state) {
        return [_model.state isEqualToNumber:@(1)];
    }
    else {
        return NO;
    }
}

@end
