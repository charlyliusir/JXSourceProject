//
//  TDLiveChatRoomModel.m
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/20.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDLiveChatRoomModel.h"

@implementation TDLiveChatRoomModel

- (NSMutableArray<TDLiveChatRoomChatListModel *> *)chatList
{
    if (!_chatList) {
        _chatList = [NSMutableArray array];
    }
    return _chatList;
}

- (NSMutableArray<TDLiveChatRoomChatListModel *> *)topList
{
    if (!_topList) {
        _topList = [NSMutableArray array];
    }
    return _topList;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _chatId = value;
    }
    else if ([key isEqualToString:@"list"]) {
        if (value && [value isKindOfClass:[NSDictionary class]]) {
            id result = value[@"result"];
            id top    = value[@"top"];
            
            if (result && [result isKindOfClass:[NSArray class]]) {
                for (NSDictionary *chatValue in result) {
                    [self addChatListModel:chatValue];
                }
            }
            else if (result && [result isKindOfClass:[NSDictionary class]]) {
                [self addChatListModel:value];
            }
            
            if (top && [top isKindOfClass:[NSArray class]]) {
                for (NSDictionary *chatValue in top) {
                    [self addChatTopModel:chatValue];
                }
            }
            else if (value && [value isKindOfClass:[NSDictionary class]]) {
                [self addChatTopModel:value];
            }
        }
    }
    
}

- (void)addChatListModel:(NSDictionary *)value
{
    TDLiveChatRoomChatListModel *model = [[TDLiveChatRoomChatListModel alloc] init];
    [model setValuesForKeysWithDictionary:value];
    [self.chatList addObject:model];
}

- (void)addChatTopModel:(NSDictionary *)value
{
    TDLiveChatRoomChatListModel *model = [[TDLiveChatRoomChatListModel alloc] init];
    [model setValuesForKeysWithDictionary:value];
    [self.topList addObject:model];
}

@end
