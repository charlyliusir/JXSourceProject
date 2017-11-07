//
//  TDLivePlayerViewController.h
//  JXMediaPlayer
//
//  Created by tidemedia on 2017/10/25.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDPlayerController.h"
#import "TDActivityInfoViewModel.h"
#import "TDLiveInfoViewModel.h"
#import "TDLiveClipsViewModel.h"

typedef void(^TDPlayerComeBackHandler) (TDActivityInfoViewModel *model, TDLivePlayerViewController *presentController, BOOL isFull);

@interface TDLivePlayerViewController : TDPlayerController

@property (nonatomic, copy) TDPlayerComeBackHandler comeBackHandler;

@property (nonatomic, strong) TDActivityInfoViewModel *viewmodel;
@property (nonatomic, strong) TDLiveInfoViewModel *infoVM;
@property (nonatomic, strong) TDLiveClipsViewModel *videoVM;
@property (nonatomic, assign) BOOL fullScreen;

@end
