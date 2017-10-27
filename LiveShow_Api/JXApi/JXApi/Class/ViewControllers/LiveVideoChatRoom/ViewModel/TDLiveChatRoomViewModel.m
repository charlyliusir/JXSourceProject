//
//  TDLiveChatRoomViewModel.m
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/20.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDLiveChatRoomViewModel.h"
#import "TDGetChatListRequest.h"

@interface TDLiveChatRoomViewModel()
@property (nonatomic, assign)NSUInteger sourceId; /// 资源 id
@property (nonatomic, assign)NSUInteger type;     /// 资源类型
@property (nonatomic, strong)NSNumber *min_id;  /// 最小id数
@property (nonatomic, strong)NSNumber *numUnLoaded; /// 未加载个数
@property (nonatomic, strong)NSNumber *last_id; /// 获取新消息
@end

@implementation TDLiveChatRoomViewModel

- (NSArray *)listModels {
    return [_model.chatList.reverseObjectEnumerator allObjects];
}

- (NSArray *)topListModels {
    return [_model.topList.reverseObjectEnumerator allObjects];
}

- (BOOL)hasMoreData {
    return (![self.numUnLoaded isEqualToNumber:@(0)] && _model) || (!_model);
}

- (NSNumber *)min_id
{
    if (!_model) {
        return @(0);
    }
    return _model.min_id;
}

- (NSNumber *)numUnLoaded
{
    if (!_model) {
        return @(0);
    }
    return _model.num1;
}

- (NSNumber *)last_id
{
    if (!_model) {
        return @(0);
    }
    return @(_model.min_id.intValue + _model.num1.intValue);
}

- (instancetype)initWithChatRoomModel:(TDLiveChatRoomModel *)model
{
    if (self = [super init]) {
        _model = model;
    }
    return self;
}

+ (instancetype)chatRoomWithChatRoomModel:(TDLiveChatRoomModel *)model
{
    return [[self alloc] initWithChatRoomModel:model];
}

- (instancetype)initWithSourceId:(NSUInteger)sourceId type:(NSUInteger)type
{
    if (self = [super init]) {
        _sourceId = sourceId;
        _type     = type;
    }
    return self;
}

+ (instancetype)chatRoomWithSourceId:(NSUInteger)sourceId type:(NSUInteger)type
{
    return [[self alloc] initWithSourceId:sourceId type:type];
}

- (instancetype)init
{
    if (self = [super init]) {
        self.min_id      = 0;
        self.numUnLoaded = 0;
        self.last_id     = 0;
    }
    return self;
}

- (void)getNewChatList:(TD_Request_Handler)handler
{
    TDGetChatListRequest *req = [TDGetChatListRequest chatListWithSourceId:_sourceId withSourceType:_type getNewMessage:self.last_id];
    [[[TDCommonClient alloc] init] sendReq:req onSuccess:^(TDHttpStatusCode statusCode, id<TDHttpResponseType> response, NSString *message, id json) {
        if (self.model) {
            TDLiveChatRoomModel *chatRoomModel = response.model;
            [chatRoomModel.chatList addObjectsFromArray:self.model.chatList.copy];
            [chatRoomModel.topList addObjectsFromArray:self.model.topList.copy];
            _model = chatRoomModel;
        }
        else {
            _model = response.model;
        }
    } onFailure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)getChatList:(TD_Request_Handler)handler
{
    TDGetChatListRequest *req = [TDGetChatListRequest chatListWithSourceId:_sourceId withSourceType:_type getNextPageMessage:self.min_id];
    [[[TDCommonClient alloc] init] sendReq:req onSuccess:^(TDHttpStatusCode statusCode, id<TDHttpResponseType> response, NSString *message, id json) {
        if (statusCode == TDHttpStatusSuccess && response.model) {
            if ([response.model isKindOfClass:[TDLiveChatRoomModel class]]) {
                TDLiveChatRoomModel *chatRoomModel = response.model;
                if (self.model) {
                    
                    [self.model.chatList addObjectsFromArray:chatRoomModel.chatList.copy];
                    [self.model.topList addObjectsFromArray:chatRoomModel.topList.copy];
                    
                    NSArray *oldChatList = self.model.chatList.copy;
                    NSArray *oldTopList  = self.model.topList.copy;
                    
                    _model = chatRoomModel;
                    _model.chatList = oldChatList.mutableCopy;
                    _model.topList  = oldTopList.mutableCopy;
                }
                else {
                    _model = response.model;
                }
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
