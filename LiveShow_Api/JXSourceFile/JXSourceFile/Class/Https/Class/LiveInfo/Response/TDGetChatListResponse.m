//
//  TDGetChatListResponse.m
//  JXSourceFile
//
//  Created by 刘朝龙 on 2017/10/21.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDGetChatListResponse.h"

@implementation TDGetChatListResponse

- (id)model
{
    return _chatRoomModel;
}

- (instancetype)initWithResult:(NSDictionary *)result
{
    if (self = [super init]) {
        TDHttpResponseHandler *handler = [[TDHttpResponseHandler alloc] init];
        [handler handleResponse:result];
        
        if (handler.statusCode == TDHttpStatusSuccess) {
            TDLiveChatRoomModel *model = [[TDLiveChatRoomModel alloc] init];
            [model setValuesForKeysWithDictionary:handler.result];
            self.chatRoomModel = model;
        }
        else {
            self.chatRoomModel = nil;
        }
    }
    return self;
}

- (instancetype)parseWithResult:(NSDictionary *)result
{
    return [self initWithResult:result];
}

@end
