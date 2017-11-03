//
//  TDLiveVideoTopView.h
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/26.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDActivityInfoViewModel.h"

@interface TDLiveVideoTopView : UIView

@property (nonatomic, strong)TDActivityInfoViewModel *activityViewmodel;


@property (nonatomic, readonly, strong) UIImageView *bgImageView;
@property (nonatomic, readonly, strong) UIButton *playButton;
@property (nonatomic, readonly, strong) UIButton *backButton;
@property (nonatomic, readonly, strong) UIButton *liveMoreButton;

@end
