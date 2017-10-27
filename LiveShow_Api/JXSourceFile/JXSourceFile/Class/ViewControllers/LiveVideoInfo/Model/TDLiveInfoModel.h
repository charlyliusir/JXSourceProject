//
//  TDLiveInfoModel.h
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/20.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDLiveInfoModel : NSObject

// 打赏笔数
@property (nonatomic, strong) NSNumber *reward_number;
// 在线人数
@property (nonatomic, strong) NSNumber *online;
// 投票数量
@property (nonatomic, strong) NSNumber *vote;
// 直播状态
@property (nonatomic,   copy) NSString *live_state;
// 最后一条聊天编号
@property (nonatomic, strong) NSNumber *mes_id;
// 最后一条图文编号
@property (nonatomic, strong) NSNumber *host_id;
// 最后一条聊天置顶时间
@property (nonatomic, strong) NSNumber *mes_toptime;
// 最后一条图文置顶时间
@property (nonatomic, strong) NSNumber *host_toptime;
// 直播状态 0（无），1（直播），2（回看）
@property (nonatomic, strong) NSNumber *state;
// 活动状态0（未开始），1（直播中），2（暂停），3（已结束）
@property (nonatomic, strong) NSNumber *s2;
// 聊天框状态，0（可聊天），1（需要审核），2（禁言）
@property (nonatomic, strong) NSNumber *is_chat;

@end
