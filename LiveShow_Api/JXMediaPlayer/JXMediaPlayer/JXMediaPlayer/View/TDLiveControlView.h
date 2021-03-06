//
//  TDLiveControlView.h
//  JXMediaPlayer
//
//  Created by tidemedia on 2017/10/25.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDLiveControlView : UIView

@property (nonatomic, assign) NSTimeInterval totalPlayTime;

/// 返回按钮
@property (nonatomic, readonly, strong) UIButton *backButton;
/// 直播状态按钮
@property (nonatomic, readonly, strong) UIButton *liveStateButton;
/// 观看人数按钮
@property (nonatomic, readonly, strong) UIButton *livePeopleButton;
/// 更多按钮
@property (nonatomic, readonly, strong) UIButton *liveMoreButton;

/// 播放按钮
@property (nonatomic, readonly, strong) UIButton *livePlayButton;
/// 播放时间按钮
@property (nonatomic, readonly, strong) UILabel *livePlayTimeLabel;
/// 视频总时间按钮
@property (nonatomic, readonly, strong) UILabel *liveTotalTimeLabel;
/// 时间滑条控件
@property (nonatomic, readonly, strong) UISlider *liveSlider;
/// 全屏按钮
@property (nonatomic, readonly, strong) UIButton *fullScreenButton;

- (void)updatePlayedTime:(NSTimeInterval)playedTime;
- (void)updateTotalPlayTime:(NSTimeInterval)totalPlayTime;

@end
