//
//  TDLiveVideoViewModel.m
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/27.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDLiveVideoViewModel.h"
#import "TDLiveVideoClipsRequest.h"


@implementation TDLiveVideoViewModel

- (instancetype)init
{
    if (self = [super init]) {
        _videoInfoViewModel = [[TDLiveInfoViewModel alloc] init];
    }
    return self;
}

- (NSMutableArray *)videoClips
{
    if (!_videoClips) {
        _videoClips = [NSMutableArray array];
    }
    return _videoClips;
}

- (void)getVideoInfo:(TD_Request_Handler)handler withSourceId:(NSUInteger)sourceId
{
    /// 请求视频详情信息
    [_videoInfoViewModel getLiveInfo:handler withSourceId:sourceId];
    /// 请求片段详情信息
    [self videoClips:handler withSourceId:sourceId];
}

- (void)videoClips:(TD_Request_Handler)handler withSourceId:(NSUInteger)sourceId
{
    TDLiveVideoClipsRequest *req = [TDLiveVideoClipsRequest liveVideoClipsWithSourceId:sourceId];
    
    [[[TDCommonClient alloc] init] sendReq:req onSuccess:^(TDHttpStatusCode statusCode, id<TDHttpResponseType> response, NSString *message, id json) {
        if (statusCode == TDHttpStatusSuccess && response.model) {
            if ([response.model isKindOfClass:[NSArray class]]) {
                [self.videoClips addObjectsFromArray:response.model];
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
