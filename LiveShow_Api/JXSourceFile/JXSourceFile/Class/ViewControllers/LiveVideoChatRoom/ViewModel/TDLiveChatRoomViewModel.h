//
//  TDLiveChatRoomViewModel.h
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/20.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDLiveChatRoomModel.h"

@interface TDLiveChatRoomViewModel : NSObject

@property (nonatomic, readonly, strong) TDLiveChatRoomModel *model;
@property (nonatomic, readonly, strong) NSArray *listModels;
@property (nonatomic, readonly, strong) NSArray  *topListModels;
@property (nonatomic, readonly, assign) BOOL hasMoreData;

- (instancetype)initWithChatRoomModel:(TDLiveChatRoomModel *)model;
+ (instancetype)chatRoomWithChatRoomModel:(TDLiveChatRoomModel *)model;

- (instancetype)initWithSourceId:(NSUInteger)sourceId type:(NSUInteger)type;
+ (instancetype)chatRoomWithSourceId:(NSUInteger)sourceId type:(NSUInteger)type;

- (void)getNewChatList:(TD_Request_Handler)handler;
- (void)getChatList:(TD_Request_Handler)handler;
/// 聊天信息数量
- (NSUInteger)messageNumber;


@end
