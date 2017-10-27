//
//  TDLiveChatRoomModel.h
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/20.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDLiveChatRoomChatListModel.h"

@interface TDLiveChatRoomModel : NSObject
// 评论数量
@property (nonatomic,   copy) NSString *num;
// 当前数据中最小的id
@property (nonatomic, strong) NSNumber *min_id;
// 剩余未加载数量
@property (nonatomic, strong) NSNumber *num1;
// 评论id
@property (nonatomic, strong) NSNumber *chatId;
// 是否主持人消息 0-不是 1-是
@property (nonatomic, strong) NSNumber *host;
// 主持人头衔
@property (nonatomic,   copy) NSString *host_name;
// 用户头像
@property (nonatomic,   copy) NSString *user_logo;
// 用户昵称
@property (nonatomic,   copy) NSString *user_name;
// 评论时间10-17 09:27
@property (nonatomic,   copy) NSString *date;
// 评论时间10月17日 09:27
@property (nonatomic,   copy) NSString *time;
// 评论内容
@property (nonatomic, strong) NSNumber *msg_content;
// 是否打赏，1打赏，0未打赏
@property (nonatomic, strong) NSNumber *is_reward;
// 是否中奖，1中奖，0未中奖
@property (nonatomic, strong) NSNumber *is_luck;
// 消息类型，评论(0)打赏(1)中奖(2)发红包(3)抢红包(4)
@property (nonatomic, strong) NSNumber *type;
// 聊天记录数据合集（除置顶信息外）
@property (nonatomic, strong) NSMutableArray <TDLiveChatRoomChatListModel *>* chatList;
// 聊天记录数据合集（置顶信息）
@property (nonatomic, strong) NSMutableArray <TDLiveChatRoomChatListModel *>* topList;

@end
