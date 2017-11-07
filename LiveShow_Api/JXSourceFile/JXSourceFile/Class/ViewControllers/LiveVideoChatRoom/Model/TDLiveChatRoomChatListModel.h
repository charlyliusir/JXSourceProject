//
//  TDLiveChatRoomChatListModel.h
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/20.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDLiveChatRoomChatListModel : NSObject
// 用户标识 eg:56096
@property (nonatomic, strong) NSNumber *user_id;
// 是否主持人消息 0-不是 1-是
@property (nonatomic, strong) NSNumber *host;
// 主持人头衔 eg:
@property (nonatomic,   copy) NSString *host_name;
// 用户头像 eg:http:\/\/img.juyun.tv/user/user.png
@property (nonatomic,   copy) NSString *user_logo;
// 用户名; eg:北京网友
@property (nonatomic,   copy) NSString *user_name;
// 时间 eg:10-17 13:23
@property (nonatomic,   copy) NSString *date;
// 时间 eg:10月17日 13:23
@property (nonatomic,   copy) NSString *time;
// 评论内容 eg:22222
@property (nonatomic,   copy) NSString *msg_content;
// 原消息  eg:22222
@property (nonatomic,   copy) NSString *reply_msg;
// 原消息的用户名称 eg:22222
@property (nonatomic,   copy) NSString *reply_user_name;
// 是否二级回复，1是，0不是 eg:0
@property (nonatomic, strong) NSNumber *is_reply;
// 是否打赏，1打赏，0未打赏 eg:0
@property (nonatomic, strong) NSNumber *is_reward;
// 是否中奖，1中奖，0未中奖 eg:0
@property (nonatomic, strong) NSNumber *is_luck;
// 消息类型，评论(0)打赏(1)中奖(2)发红包(3)抢红包(4) eg:0
@property (nonatomic, strong) NSNumber *type;

- (CGFloat)chatCellHeight;

- (BOOL)isReplyMessage;

- (NSString *)getUserNameWithChatMessage;
- (NSString *)getMessageWithChatMessage;

- (NSString *)getReplyUserNameWithChatMessage;
- (NSString *)getReplyMessageWithChatMessage;

@end
