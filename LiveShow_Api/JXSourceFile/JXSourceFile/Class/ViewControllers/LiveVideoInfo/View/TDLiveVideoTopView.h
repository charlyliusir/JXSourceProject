//
//  TDLiveVideoTopView.h
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/26.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDActivityInfoViewModel.h"
#import "TDLiveClipsViewModel.h"

@interface TDLiveVideoTopView : UIView

/// 活动详情
@property (nonatomic, strong)TDActivityInfoViewModel *activityViewmodel;
/// 当前选中片段
@property (nonatomic, strong)TDLiveClipsViewModel *model;

@property (nonatomic, readonly, strong) UIImageView *bgImageView;
@property (nonatomic, readonly, strong) UIButton *playButton;
@property (nonatomic, readonly, strong) UIButton *backButton;
@property (nonatomic, readonly, strong) UIButton *liveMoreButton;

@end
