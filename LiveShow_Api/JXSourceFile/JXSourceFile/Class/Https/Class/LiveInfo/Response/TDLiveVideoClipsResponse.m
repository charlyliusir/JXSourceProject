//
//  TDGetChatListResponse.m
//  JXSourceFile
//
//  Created by 刘朝龙 on 2017/10/21.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDLiveVideoClipsResponse.h"
#import "TDLiveClipsViewModel.h"
#import "TDLiveClipsModel.h"

@implementation TDLiveVideoClipsResponse

- (id)model
{
    return _models;
}

- (instancetype)initWithResult:(NSDictionary *)result
{
    if (self = [super init]) {
        TDHttpResponseHandler *handler = [[TDHttpResponseHandler alloc] init];
        [handler handleResponse:result];
        NSDictionary *result = handler.result[TD_HTTP_RESPONSE_RESULT];
        if (handler.statusCode == TDHttpStatusSuccess && result) {
            NSArray *list = result[@"list"];
            NSMutableArray *videoClips = [NSMutableArray array];
            if (list && [list isKindOfClass:[NSArray class]]) {
                for (NSDictionary *item in list) {
                    TDLiveClipsModel *model = [[TDLiveClipsModel alloc] init];
                    [model setValuesForKeysWithDictionary:item];
                    TDLiveClipsViewModel *cViewModel = [TDLiveClipsViewModel liveClipsWithModel:model];
                    [videoClips addObject:cViewModel];
                }
            }
            self.models = videoClips.copy;
        }
        else {
            self.models = nil;
        }
    }
    return self;
}

- (instancetype)parseWithResult:(NSDictionary *)result
{
    return [self initWithResult:result];
}

@end
