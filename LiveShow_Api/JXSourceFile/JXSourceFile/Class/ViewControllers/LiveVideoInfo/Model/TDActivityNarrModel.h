//
//  TDActivityNarrModel.h
//  JXSourceFile
//
//  Created by 刘朝龙 on 2017/10/21.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDActivityNarrModel : NSObject

/// 聊天
@property (nonatomic, strong) NSNumber * chat;
/// 图文
@property (nonatomic, strong) NSNumber * pic;
/// 打赏
@property (nonatomic, strong) NSNumber * reward;
/// 投票
@property (nonatomic, strong) NSNumber * vote;
/// 抽奖
@property (nonatomic, strong) NSNumber * luck;
/// 考试
@property (nonatomic, strong) NSNumber * exam;
/// 签到
@property (nonatomic, strong) NSNumber * Sign;
/// 提问（问答）
@property (nonatomic, strong) NSNumber * question;
/// 报名
@property (nonatomic, strong) NSNumber * enter;

@end
