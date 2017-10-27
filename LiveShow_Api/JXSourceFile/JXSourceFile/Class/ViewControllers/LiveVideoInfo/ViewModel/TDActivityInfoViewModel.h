//
//  TDActivityInfoViewModel.h
//  JXSourceFile
//
//  Created by 刘朝龙 on 2017/10/21.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TDActivityInfoModel.h"
@class TDLivePlayerViewController;

@interface TDActivityInfoViewModel : NSObject


@property (nonatomic, readonly, strong) TDActivityInfoModel *model;
@property (nonatomic, weak) UIViewController *owner;

- (instancetype)initWithModel:(TDActivityInfoModel *)model;
+ (instancetype)liveInfoWithModel:(TDActivityInfoModel *)model;

- (void)getActivityInfo:(TD_Request_Handler)handler withSourceId:(NSUInteger)sourceId;
- (void)fullScreenButtonClickedHandlerForVodPlayController:(TDLivePlayerViewController *)vodPlayController isFullScreen:(BOOL)isFullScreen;

/// 是否开启片段
- (BOOL)showDispaly;
/// 是否展示动态组件
- (BOOL)showDynamic;
/// 是否展示聊天组件
- (BOOL)showChat;
/// 是否展示抽奖组件
- (BOOL)showLuck;
/// 是否展示投票组件
- (BOOL)showVote;
/// 是否展示打赏组件
- (BOOL)showReward;
/// 动态组件的名字
- (NSString *)dynamicTitle;
/// 聊天组件的名字
- (NSString *)chatTitle;
/// 介绍组件的名字
- (NSString *)introduceTitle;
/// 介绍信息
- (NSString *)introduceSummary;
/// 聊天信息数量
- (NSUInteger)messageNumber;
/// 打赏数量
- (NSUInteger)rewardNumber;
/// 投票数量
- (NSUInteger)voteNumber;
/// 介绍内容的高度
- (CGFloat)summaryHeight;
/// 介绍内容富文本文字
- (NSAttributedString *)summaryAttributedString;

@end
